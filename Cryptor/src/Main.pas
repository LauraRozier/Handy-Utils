unit Main;

interface

uses
  // Windows
  Winapi.Windows, Winapi.Messages,
  // System
  System.Actions, System.SysUtils, System.Classes, System.UITypes,
  // VCL
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Buttons,
  Vcl.ActnMan, Vcl.RibbonObsidianStyleActnCtrls, Vcl.Imaging.pngimage,
  // Cindy
  cyBaseStaticText, cyAdvStaticText, cyBaseButton, cyAdvButton,
  // Syn
  SynCrypto, cyBaseLed, cyAdvLed, cyLed, Vcl.PlatformDefaultStyleActnCtrls;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    Action3: TAction;
    Action4: TAction;
    cyAdvButton1: TcyAdvButton;
    cyAdvButton2: TcyAdvButton;
    cyAdvStaticText1: TcyAdvStaticText;
    cyLed1: TcyLed;
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure cyLed1Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Action3Execute(Sender: TObject);
var
  OpenDlg:                             TOpenDialog;
  PassPhrase, InFileName, OutFileName: string;
  I, TotalFiles:                       Integer;
  Digest:                              TSHA256Digest;
  FSIn, FSOut:                         TFileStream;
  AES:                                 TAESFull;
  FT:                                  TFileTime;
  HadErr:                              Boolean;
begin
  OpenDlg         := TOpenDialog.Create(nil);
  OpenDlg.Filter  := '';
  OpenDlg.Options := [ofOverwritePrompt, ofHideReadOnly, ofAllowMultiSelect,
                      ofPathMustExist, ofFileMustExist, ofEnableSizing,
                      ofDontAddToRecent];
  OpenDlg.Title   := 'Select files to encrypt';

  if not OpenDlg.Execute(Handle) then
    Exit;

  PassPhrase := trim(InputBox('Encrypt files', 'Please type in a password', ''));

  if PassPhrase = '' then
    Exit;

  cyLed1.LedValue := True;
  cyLed1.Refresh;
  SHA256Weak(RawByteString(PassPhrase), Digest);
  TotalFiles := OpenDlg.Files.Count;

  for I := 0 to TotalFiles-1 do
  begin
    InFileName  := OpenDlg.Files[I];
    OutFileName := InFileName + '.crypt';

    FSIn := TFileStream.Create(InFileName, fmOpenRead);

    if FileExists(OutFileName) then
    begin
      FSOut := TFileStream.Create(OutFileName, fmOpenWrite);
      FSOut.Size := 0;
    end else
      FSOut := TFileStream.Create(OutFileName, fmCreate);

    AES.outStreamCreated := nil;
    GetFileTime(FSIn.Handle, nil, nil, @FT);
    HadErr := False;

    try
      if AES.EncodeDecode(Digest, 256, FSIn.Size, True, FSIn, FSOut, nil, nil) < 0 then
        HadErr := True;

    finally
      SetFileTime(FSOut.Handle, nil, nil, @FT);
      FSIn.Free;
      FSOut.Free;

      if HadErr then
      begin
        MessageDlg('Error!' + sLineBreak +
                   'Unable to decrypt file: ' + InFileName,
                   mtError, [mbOK], 0);
        DeleteFile(OutFileName);
      end;
    end;
  end;

  cyLed1.LedValue := False;
  cyLed1.Refresh;
  MessageDlg('Files have been encrypted!', mtInformation, [mbOK], 0);
end;

procedure TForm1.Action4Execute(Sender: TObject);
var
  OpenDlg:                             TOpenDialog;
  PassPhrase, InFileName, OutFileName: string;
  I, TotalFiles:                       Integer;
  Digest:                              TSHA256Digest;
  FSIn, FSOut:                         TFileStream;
  AES:                                 TAESFull;
  FT:                                  TFileTime;
  HadErr:                              Boolean;
begin
  OpenDlg         := TOpenDialog.Create(nil);
  OpenDlg.Filter  := 'Crypt Files (*.crypt)|*.crypt';
  OpenDlg.Options := [ofOverwritePrompt, ofHideReadOnly, ofAllowMultiSelect,
                      ofPathMustExist, ofFileMustExist, ofEnableSizing,
                      ofDontAddToRecent];
  OpenDlg.Title   := 'Select files to decrypt';

  if not OpenDlg.Execute(Handle) then
    Exit;

  PassPhrase := trim(InputBox('Decrypt files', 'Please type in a password', ''));

  if PassPhrase = '' then
    Exit;

  cyLed1.LedValue := True;
  cyLed1.Refresh;
  SHA256Weak(RawByteString(PassPhrase), Digest);
  TotalFiles := OpenDlg.Files.Count;

  for I := 0 to TotalFiles-1 do
  begin
    InFileName := OpenDlg.Files[I];

    if not InFileName.EndsWith('.crypt') then
      Exit;

    OutFileName          := InFileName.Substring(0, InFileName.Length - 6); // '.crypt'
    FSIn                 := TFileStream.Create(InFileName, fmOpenRead);

    if FileExists(OutFileName) then
    begin
      FSOut := TFileStream.Create(OutFileName, fmOpenWrite);
      FSOut.Size := 0;
    end else
      FSOut := TFileStream.Create(OutFileName, fmCreate);

    AES.outStreamCreated := nil;
    GetFileTime(FSIn.Handle, nil, nil, @FT);
    HadErr := False;

    try
      if AES.EncodeDecode(Digest, 256, FSIn.Size, False, FSIn, FSOut, nil, nil) < 0 then
        HadErr := True;

    finally
      SetFileTime(FSOut.Handle, nil, nil, @FT);
      FSIn.Free;
      FSOut.Free;

      if HadErr then
      begin
        MessageDlg('Error!' + sLineBreak +
                   'Unable to decrypt file: ' + InFileName,
                   mtError, [mbOK], 0);
        DeleteFile(OutFileName);
      end;
    end;
  end;

  cyLed1.LedValue := False;
  cyLed1.Refresh;
  MessageDlg('Files have been decrypted!', mtInformation, [mbOK], 0);
end;

procedure TForm1.cyLed1Click(Sender: TObject);
begin
  cyLed1.LedValue := not cyLed1.LedValue;
  Exit;
end;

end.
