unit Main;

{.$mode objfpc}{.$H+}
{$mode delphi}{$H+}

interface

uses
  Windows, Classes, SysUtils, FileUtil,
  Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, Buttons, Menus, ExtCtrls,
  fpjson, jsonparser;

type
  tMmonitor = class(TThread)  // pipe monitoring thread for console output
  private
    TextString: String;
    procedure UpdateCaption;
  protected
    procedure Execute; override;
  end;

  TButtonRecord = record
    Name:    string[255];
    Caption: string[255];
    Action:  array[0..32767] of Char;
  end;

  TButtonRecordArray = array[0..254] of TButtonRecord;

  TSettingsRecord = record
    ButtonCount: Integer;
    Buttons:     TButtonRecordArray;
  end;

  { TMainForm }
  TMainForm = class(TForm)
    cbCommand: TComboBox;
    memoCommand: TMemo;
    miAddBtn: TMenuItem;
    miDeleteBtn: TMenuItem;
    pcMain: TPageControl;
    pmButtoms: TPopupMenu;
    tsCMD: TTabSheet;
    tsButtons: TTabSheet;
    tsSettings: TTabSheet;
    procedure cbCommandKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miAddBtnClick(Sender: TObject);
    procedure miDeleteBtnClick(Sender: TObject);
  private
    Settings: TSettingsRecord;
    cmdcount: Integer;
    procedure SaveSettings;
    procedure CreateButtons;
    procedure SendCommand;
    procedure CustomBtnClick(Sender: TObject);
  public
    { public declarations }
  end;

var
  MainForm:                        TMainForm;
  InputPipeRead, InputPipeWrite:   THandle;
  OutputPipeRead, OutputPipeWrite: THandle;
  ErrorPipeRead, ErrorPipeWrite:   THandle;
  ProcessInfo:                     TProcessInformation;
  myThread:                        TMmonitor;

const
  SETTINGS_FILE = '.\.bcmd_settings';

implementation

procedure WritePipeOut(OutputPipe: THandle; InString: string);
var
  byteswritten: DWord;
begin
// most console programs require CR/LF after their input.
  InString := InString + #13#10;
  WriteFile(OutputPipe, Instring[1], Length(Instring), byteswritten, nil);
end;

function ReadPipeInput(InputPipe: THandle; var BytesRem: Integer): String;
var
  TextBuffer: array[1..32767] of char;
  TextString: string;
  BytesRead:  LongWord;
  PipeSize:   Integer;
begin
  Result := '';
  PipeSize := Sizeof(TextBuffer);
  // check if there is something to read in pipe
  PeekNamedPipe(InputPipe, nil, PipeSize, @BytesRead, @PipeSize, @BytesRem);

  if bytesread > 0 then
  begin
    ReadFile(InputPipe, TextBuffer, pipesize, bytesread, nil);
    // a requirement for Windows OS system components
    OemToChar(@TextBuffer, @TextBuffer);
    TextString := String(TextBuffer);
    SetLength(TextString, BytesRead);
    Result := TextString;
  end;
end;

procedure tMmonitor.Execute;
var
  BytesRem: LongInt;
begin
  while not Terminated do
    begin
      // read regular output stream and put on screen.
      TextString := ReadPipeInput(OutputPipeRead, BytesRem);

      if TextString <> '' then
         Synchronize(UpdateCaption);

      // now read error stream and put that on screen.
      TextString := ReadPipeInput(ErrorPipeRead, BytesRem);

      if TextString <> '' then
         Synchronize(UpdateCaption);

      sleep(40);
    end;
end;

procedure tMmonitor.UpdateCaption;
begin
  With MainForm.memoCommand.Lines do
    Add(TextString);
end;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  WritePipeOut(InputPipeWrite, 'EXIT'); // quit the CMD we started
  MyThread.Terminate;
  // close process handles
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
  // close pipe handles
  CloseHandle(InputPipeRead);
  CloseHandle(InputPipeWrite);
  CloseHandle(OutputPipeRead);
  CloseHandle(OutputPipeWrite);
  CloseHandle(ErrorPipeRead);
  CloseHandle(ErrorPipeWrite);

  cbCommand.Items.SaveToFile('.bcmd_history');
end;

procedure TMainForm.cbCommandKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    SendCommand;
    Exit;
  end;

  inherited;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  DosApp:   string;
  Security: TSecurityAttributes;
  start:    TStartUpInfo;
  DF:       File of TSettingsRecord;
begin
  pcMain.ActivePage := tsCMD;

  if FileExists(SETTINGS_FILE) then
  begin
    AssignFile(DF, SETTINGS_FILE);

    try
      Reset(DF);
      Read(DF, Settings);
    finally
      CloseFile(DF);
    end;

    if Settings.ButtonCount <> 0 then
      CreateButtons;
  end else
    Settings.ButtonCount := 0;

  memoCommand.Clear;
  // get COMSPEC variable, this is the path of the command-interpreter
  Dosapp := GetEnvironmentVariable('COMSPEC');

  // create pipes
  With Security do
  begin
    nlength              := SizeOf(TSecurityAttributes) ;
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;

  CreatePipe(InputPipeRead,  InputPipeWrite,  @Security, 0);
  CreatePipe(OutputPipeRead, OutputPipeWrite, @Security, 0);
  CreatePipe(ErrorPipeRead,  ErrorPipeWrite,  @Security, 0);

  // start command-interpreter
  FillChar(Start, Sizeof(Start), #0) ;
  start.cb          := SizeOf(start) ;
  start.hStdInput   := InputPipeRead;
  start.hStdOutput  := OutputPipeWrite;
  start.hStdError   := ErrorPipeWrite;
  start.dwFlags     := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
  start.wShowWindow := SW_HIDE;

  if CreateProcess(nil, PChar(DosApp), @Security, @Security, true,
                   CREATE_NEW_CONSOLE or SYNCHRONIZE,
                   nil, nil, start, ProcessInfo) then
  begin
    MyThread          := tMmonitor.Create(false);  // start monitor thread
    MyThread.Priority := tpHigher;
  end;

  memoCommand.Lines.Add('============== Better Command Prompt ==============');
  memoCommand.Lines.Add('Because clicking a button is more fun then typing.');
  memoCommand.Lines.Add('');
  memoCommand.Lines.Add('(c) 2016 - Thimo Braker');
  memoCommand.Lines.Add('');
  memoCommand.Lines.Add('The following commands are native to BCMD:');
  memoCommand.Lines.Add('');
  memoCommand.Lines.Add('CLR - Clear the memo');
  memoCommand.Lines.Add('LS - Alias for DIR');
  memoCommand.Lines.Add('EXIT - Exit this application');
  memoCommand.Lines.Add('============== Better Command Prompt ==============');
  memoCommand.Lines.Add('');
  cmdcount := 1;

  if FileExists('.\.bcmd_history') then
     cbCommand.Items.LoadFromFile('.\.bcmd_history');
end;

procedure TMainForm.SaveSettings;
var
  DF: File of TSettingsRecord;
begin
  AssignFile(DF, SETTINGS_FILE);

  try
    Rewrite(DF);
    Write(DF, Settings);
  finally
    CloseFile(DF);
  end;
end;

procedure TMainForm.CreateButtons;
var
  I: Integer;
begin
  if Settings.ButtonCount <= 0 then
    Exit;

  for I := 0 to Settings.ButtonCount - 1 do
  begin
    with TButton.Create(tsButtons) do
    begin
      Left    := 20;
      Top     := 30 + (32 * I);
      Width   := 240;
      Height  := 30;
      Name    := Settings.Buttons[I].Name;
      Caption := Settings.Buttons[I].Caption;
      OnClick := CustomBtnClick;
      Parent  := tsButtons;
    end; {end with}
  end;
end;

procedure TMainForm.SendCommand;
{ takes the input from the command edit box and processes it }
var
  UpText: string;
  I:      Integer;
begin
  UpText := UpperCase(cbCommand.Text); // done to eliminate case-sensitivity

  if UpText = 'CLR' then // clear the memo
  begin
    memoCommand.Clear;
    WritePipeOut(InputPipeWrite, #13);
  end else
    if UpText = 'LS' then
      WritePipeOut(InputPipeWrite, 'dir')
    else
      if UpText = 'CMD' then
        inc(cmdcount)
      else
        if UpText = 'COMMAND' then
          inc(cmdcount)
        else
          if UpText = 'EXIT' then // terminate app if user types exit, else let alone
          begin
            if cmdcount = 1 then
              Application.Terminate
            else
              dec(cmdcount);
          end else
            WritePipeOut(InputPipeWrite, cbCommand.Text);

  if cbCommand.Text <> '' then
  begin
    cbCommand.Items.Add(cbCommand.Text);

    for I := cbCommand.Items.Count - 2 downto 0 do // Skip recently added
      if cbCommand.Items[I] = cbCommand.Text then
        cbCommand.Items.Delete(I);

    cbCommand.Text := '';
  end;

  cbCommand.SetFocus;
  cbCommand.Update;
end;

procedure TMainForm.CustomBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Settings.ButtonCount - 1 do
    if (Sender as TButton).Name = Settings.Buttons[I].Name then
      cbCommand.Text := Settings.Buttons[I].Action;

  pcMain.ActivePage := tsCMD;
  SendCommand;
end;

procedure TMainForm.miAddBtnClick(Sender: TObject);
var
  I:                               Integer;
  child:                           TWinControl;
  btnName, btnCaption, btnCommand: string;
  btn:                             TButtonRecord;
begin
  if InputQuery('Add new button', 'Please provide the name for the button', btnName) then
    if InputQuery('Add new button', 'Please provide the text for the button', btnCaption) then
      if InputQuery('Add new button', 'Please provide the command for the button', btnCommand) then
      begin
        for I := 0 to tsButtons.ControlCount - 1 do
        begin
          child := TWinControl(tsButtons.Controls[I]);

          if child is TButton then
          begin
            if child.Name = btnName then
            begin
              if MessageDlg('Error', 'Button name is already in use', mtError, [mbAbort, mbRetry], 0) = mrRetry then
                miAddBtnClick(Sender);

              Exit;
            end;
          end;
        end;

        btn.Name                               := btnName;
        btn.Caption                            := btnCaption;
        btn.Action                             := btnCommand;
        Settings.Buttons[Settings.ButtonCount] := btn;
        Inc(Settings.ButtonCount);

        SaveSettings;

        for I := 0 to tsButtons.ControlCount - 1 do
        begin
          child := TWinControl(tsButtons.Controls[I]);

          if child is TButton then
          begin
            tsButtons.RemoveComponent(child);
            Application.ReleaseComponent(child);
          end;
        end;

        CreateButtons;
      end;
end;

procedure TMainForm.miDeleteBtnClick(Sender: TObject);
var
  btnName, btnString:  string;
  I, btnStrCount:      Integer;
  child:               TWinControl;
  foundBtn:            Boolean;
begin
  if Settings.ButtonCount <= 0 then
    Exit;

  btnString   := '';
  btnStrCount := 0;
  foundBtn    := False;

  for I := 0 to Settings.ButtonCount - 1 do
  begin
    Inc(btnStrCount);

    if I = Settings.ButtonCount - 1 then
      btnString := btnString + Settings.Buttons[I].Name
    else
      btnString := btnString + Settings.Buttons[I].Name + ', ';

    if btnStrCount = 5 then
    begin
      btnStrCount := 0;
      btnString   := btnString + sLineBreak;
    end;
  end;

  if InputQuery('Remove button',
                'Please provide the name for the button' + sLineBreak +
                'Available buttons:' + sLineBreak +
                btnString,
                btnName) then
  begin
    for I := 0 to Settings.ButtonCount - 1 do
    begin
      if Settings.Buttons[I].Name = btnName then
        foundBtn := True;

      if foundBtn then
      begin
        Settings.Buttons[I].Name    := Settings.Buttons[I + 1].Name;
        Settings.Buttons[I].Caption := Settings.Buttons[I + 1].Caption;
        Settings.Buttons[I].Action  := Settings.Buttons[I + 1].Action;
      end;
    end;

    Dec(Settings.ButtonCount);
    SaveSettings;

    for I := 0 to tsButtons.ControlCount - 1 do
    begin
      child := TWinControl(tsButtons.Controls[I]);

      if child is TButton then
      begin
        tsButtons.RemoveComponent(child);
        Application.ReleaseComponent(child);
      end;
    end;

    CreateButtons;
  end;
end;

end.

