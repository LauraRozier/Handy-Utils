program OutlookFix;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, CustApp, Registry, Forms, Dialogs, LCLType, Controls,
  Interfaces
  { you can add units after this };

type

  { TOutlookFix }

  TOutlookFix = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TOutlookFix }

procedure TOutlookFix.DoRun;
var
  ErrorMsg:             string;
  Reg32, Reg64:         TRegistry;
  RegKey321, RegKey322: Integer;
  RegKey641, RegKey642: Integer;
  Key1, Key2:           string;
begin
  // quick check parameters
  ErrorMsg := CheckOptions('h', 'help');
  if ErrorMsg <> '' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }
  Application.Initialize;
  {$ifdef WIN32}
  try
    Key1 := 'SOFTWARE\Microsoft\Windows Messaging Subsystem';
    Key2 := 'SOFTWARE\Microsoft\Windows Messaging Subsystem\Applications\Outlook';


    Reg32 := TRegistry.Create(KEY_ALL_ACCESS);
    Reg32.RootKey := HKEY_LOCAL_MACHINE;
    if Reg32.OpenKeyReadOnly(Key1) then
    begin
      if Reg32.ValueExists('SharedMemMaxSize') then
      begin
        RegKey321 := Reg32.ReadInteger('SharedMemMaxSize');
        Reg32.CloseKey;
        writeln('Current value: ' + IntToStr(RegKey321));
      end else
        writeln('Value does not yet exist in ' + Key1);
    end;
    Reg32.Free;
    Reg32 := nil;

    Reg32 := TRegistry.Create(KEY_ALL_ACCESS);
    Reg32.RootKey := HKEY_LOCAL_MACHINE;
    if Reg32.OpenKeyReadOnly(Key2) then
    begin
      if Reg32.ValueExists('SharedMemMaxSize') then
      begin
        RegKey322 := Reg32.ReadInteger('SharedMemMaxSize');
        Reg32.CloseKey;
        writeln('Current value: ' + IntToStr(RegKey322));
      end else
        writeln('Value does not yet exist in ' + Key2);
    end;
    Reg32.Free;
    Reg32 := nil;

    if MessageDlg('Confirmation',
                  'Do you wish to create or update the keys and/or values?',
                  mtConfirmation,
                  [mbYes, mbNo],
                  0) = mrYes then
    begin
      Reg32 := TRegistry.Create(KEY_ALL_ACCESS);
      Reg32.RootKey := HKEY_LOCAL_MACHINE;
      if Reg32.OpenKey(Key1, True) then
      begin
        if RegKey321 = 3145728 then
          if not Reg32.WriteInteger('SharedMemMaxSize', 8388608) then
            Raise Exception.Create('Unable to create/set value 1')
        else
          if not Reg32.WriteInteger('SharedMemMaxSize', 3145728) then
            Raise Exception.Create('Unable to create/set value 1');

        Reg32.CloseKey;
      end;
      Reg32.Free;
      Reg32 := nil;

      Reg32 := TRegistry.Create(KEY_ALL_ACCESS);
      Reg32.RootKey := HKEY_LOCAL_MACHINE;
      if Reg32.OpenKey(Key2, True) then
      begin
        if RegKey322 = 3145728 then
          if not Reg32.WriteInteger('SharedMemMaxSize', 8388608) then
            Raise Exception.Create('Unable to create/set value 2')
        else
          if not Reg32.WriteInteger('SharedMemMaxSize', 3145728) then
            Raise Exception.Create('Unable to create/set value 2');

        Reg32.CloseKey;
      end;
    end;
  finally
    Reg32.Free;
    Reg32 := nil;
  end;
  {$else} //if were running 64bit code, OS must be 64bit
  try
    Key1 := 'SOFTWARE\Microsoft\Windows Messaging Subsystem';
    Key2 := 'SOFTWARE\Microsoft\Windows Messaging Subsystem\Applications\Outlook';

    Reg32 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_32KEY);
    Reg32.RootKey := HKEY_LOCAL_MACHINE;
    if Reg32.OpenKeyReadOnly(Key1) then
    begin
      if Reg32.ValueExists('SharedMemMaxSize') then
      begin
        RegKey321 := Reg32.ReadInteger('SharedMemMaxSize');
        Reg32.CloseKey;
        writeln('Current value: ' + IntToStr(RegKey321));
      end else
        writeln('32-bit value does not yet exist in ' + Key1);
    end;
    Reg32.Free;
    Reg32 := nil;

    Reg32 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_32KEY);
    Reg32.RootKey := HKEY_LOCAL_MACHINE;
    if Reg32.OpenKeyReadOnly(Key2) then
    begin
      if Reg32.ValueExists('SharedMemMaxSize') then
      begin
        RegKey322 := Reg32.ReadInteger('SharedMemMaxSize');
        Reg32.CloseKey;
        writeln('Current value: ' + IntToStr(RegKey322));
      end else
        writeln('32-bit value does not yet exist in ' + Key2);
    end;
    Reg32.Free;
    Reg32 := nil;

    if MessageDlg('Confirmation',
                  'Do you wish to create or update the 32-bit keys and/or values?',
                  mtConfirmation,
                  [mbYes, mbNo],
                  0) = mrYes then
    begin
      Reg32 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_32KEY);
      Reg32.RootKey := HKEY_LOCAL_MACHINE;
      if Reg32.OpenKey(Key1, True) then
      begin
        if RegKey321 = 3145728 then
          Reg32.WriteInteger('SharedMemMaxSize', 8388608)
        else
          Reg32.WriteInteger('SharedMemMaxSize', 3145728);

        Reg32.CloseKey;
      end;
      Reg32.Free;
      Reg32 := nil;

      Reg32 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_32KEY);
      Reg32.RootKey := HKEY_LOCAL_MACHINE;
      if Reg32.OpenKey(Key2, True) then
      begin
        if RegKey322 = 3145728 then
          Reg32.WriteInteger('SharedMemMaxSize', 8388608)
        else
          Reg32.WriteInteger('SharedMemMaxSize', 3145728);

        Reg32.CloseKey;
      end;
      Reg32.Free;
      Reg32 := nil;
    end;

    Reg64 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
    Reg64.RootKey := HKEY_LOCAL_MACHINE;
    if Reg64.OpenKeyReadOnly(Key1) then
    begin
      if Reg64.ValueExists('SharedMemMaxSize') then
      begin
        RegKey641 := Reg64.ReadInteger('SharedMemMaxSize');
        Reg64.CloseKey;
        writeln('Current value: ' + IntToStr(RegKey641));
      end else
        writeln('64-bit value does not yet exist in ' + Key1);
    end;
    Reg64.Free;
    Reg64 := nil;

    Reg64 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
    Reg64.RootKey := HKEY_LOCAL_MACHINE;
    if Reg64.OpenKeyReadOnly(Key2) then
    begin
      if Reg64.ValueExists('SharedMemMaxSize') then
      begin
        RegKey642 := Reg64.ReadInteger('SharedMemMaxSize');
        Reg64.CloseKey;
        writeln('Current value: ' + IntToStr(RegKey642));
      end else
        writeln('64-bit value does not yet exist in ' + Key2);
    end;
    Reg64.Free;
    Reg64 := nil;

    if MessageDlg('Confirmation',
                  'Do you wish to create or update 64-bit the keys and/or values?',
                  mtConfirmation,
                  [mbYes, mbNo],
                  0) = mrYes then
    begin
      Reg64 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
      Reg64.RootKey := HKEY_LOCAL_MACHINE;
      if Reg64.OpenKey(Key1, True) then
      begin
        if RegKey641 = 3145728 then
          Reg64.WriteInteger('SharedMemMaxSize', 8388608)
        else
          Reg64.WriteInteger('SharedMemMaxSize', 3145728);

        Reg64.CloseKey;
      end;
      Reg64.Free;
      Reg64 := nil;

      Reg64 := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
      Reg64.RootKey := HKEY_LOCAL_MACHINE;
      if Reg64.OpenKey(Key2, True) then
      begin
        if RegKey642 = 3145728 then
          Reg64.WriteInteger('SharedMemMaxSize', 8388608)
        else
          Reg64.WriteInteger('SharedMemMaxSize', 3145728);

        Reg64.CloseKey;
      end;
    end;
  finally
    Reg64.Free;
    Reg64 := nil;
  end;
  {$endif}
  // stop program loop
  Terminate;
end;

constructor TOutlookFix.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  StopOnException := True;
end;

destructor TOutlookFix.Destroy;
begin
  inherited Destroy;
end;

procedure TOutlookFix.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TOutlookFix;
begin
  Application := TOutlookFix.Create(nil);
  Application.Title := 'Outlook Fix';
  Application.Run;
  Application.Free;
end.

