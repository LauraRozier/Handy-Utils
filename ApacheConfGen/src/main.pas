unit Main;

{$mode objfpc}{$H+}
{$ASSERTIONS ON}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MaskEdit;

type

  { TMainForm }

  TMainForm = class(TForm)
    btnGenerate: TButton;
    cbSSLEnabled: TCheckBox;
    cbPHPFPMEnabled: TCheckBox;
    edtPHPFPMSocketSuffix: TEdit;
    edtLogDir: TEdit;
    edtRootDir: TEdit;
    edtServerName: TEdit;
    edtServerAliasOne: TEdit;
    edtServerAliasTwo: TEdit;
    edtCAFile: TEdit;
    edtCertFile: TEdit;
    edtKeyFile: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    edtIPAddress: TMaskEdit;
    Label3: TLabel;
    edtPort: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    memoOutput: TMemo;
    procedure btnGenerateClick(Sender: TObject);
  private
    procedure generateApacheConfig(aStrings: TStringList);
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.generateApacheConfig(aStrings: TStringList);
var
  ipAddress: string;
begin
  ipAddress := StringReplace(edtIPAddress.Text, ' ', '', [rfReplaceAll,
                                                          rfIgnoreCase]);

  Assert(ipAddress <> '...',       'Always provide an IP address!');
  Assert(edtPort.Text <> '',       'Always provide a port!');
  Assert(edtServerName.Text <> '', 'Always provide a server name!');

  aStrings.Add('<VirtualHost ' + ipAddress + ':' + edtPort.Text + '>');
  aStrings.Add('        ServerName ' + edtServerName.Text);

  if edtServerAliasOne.Text <> '' then
     aStrings.Add('        ServerAlias ' + edtServerAliasOne.Text);

  if edtServerAliasTwo.Text <> '' then
     aStrings.Add('        ServerAlias ' + edtServerAliasTwo.Text);

  if cbSSLEnabled.Checked then
  begin
    Assert(edtCertFile.Text <> '', 'Always provide a certificate file!');
    Assert(edtKeyFile.Text <> '',  'Always provide a key file!');
    Assert(edtCAFile.Text <> '',   'Always provide a CA certificate file!');

    aStrings.Add('');
    aStrings.Add('        SSLEngine on');
    aStrings.Add('        SSLCertificateFile ' + edtCertFile.Text);
    aStrings.Add('        SSLCertificateKeyFile ' + edtKeyFile.Text);
    aStrings.Add('        SSLCACertificateFile ' + edtCAFile.Text);
  end;

  Assert(edtRootDir.Text <> '', 'Always provide an HTML directory!');

  aStrings.Add('');
  aStrings.Add('        DocumentRoot ' + edtRootDir.Text);
  aStrings.Add('');
  aStrings.Add('        <Directory ' + edtRootDir.Text + '>');
  aStrings.Add('                Options FollowSymLinks');
  aStrings.Add('                AllowOverride all');
  aStrings.Add('                Order allow,deny ');
  aStrings.Add('                Allow from all');
  aStrings.Add('        </Directory>');

  if cbPHPFPMEnabled.Checked then
  begin
    Assert(edtPHPFPMSocketSuffix.Text <> '', 'Always provide a PHP-FPM socket name!');

    aStrings.Add('');
    aStrings.Add('        Action php5-fcgi /php5-fcgi');
    aStrings.Add('        Alias /php5-fcgi /php5-fpm-' + edtPHPFPMSocketSuffix.Text);
    aStrings.Add('        FastCgiExternalServer /php5-fpm-' + edtPHPFPMSocketSuffix.Text +
                 ' -socket /var/run/php5-fpm-' + edtPHPFPMSocketSuffix.Text +
                 '.sock -pass-header Authorization');
  end;
  Assert(edtLogDir.Text <> '', 'Always provide a log file directory!');

  aStrings.Add('');
  aStrings.Add('        ErrorLog ' + edtLogDir.Text + '/error.log');
  aStrings.Add('');
  aStrings.Add('        # Possible values include: debug, info, notice, warn, error, crit,');
  aStrings.Add('        # alert, emerg.');
  aStrings.Add('        LogLevel debug');
  aStrings.Add('');
  aStrings.Add('        LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"" combined');
  aStrings.Add('        CustomLog ' + edtLogDir.Text + '/access.log combined');


  aStrings.Add('');
  aStrings.Add('        <FilesMatch ".+\.ph(p[345]?|t|tml)$">');

  if cbPHPFPMEnabled.Checked then
  begin
    aStrings.Add('#               SetHandler application/x-httpd-php');
    aStrings.Add('                AddHandler php5-fcgi .php');
  end else
    aStrings.Add('                SetHandler application/x-httpd-php');

  aStrings.Add('        </FilesMatch>');
  aStrings.Add('</VirtualHost>');
end;

procedure TMainForm.btnGenerateClick(Sender: TObject);
var
  confForOutput: TStringList;
begin
  confForOutput := TStringList.Create;
  generateApacheConfig(confForOutput);

  memoOutput.Lines.BeginUpdate;
  memoOutput.Clear;
  memoOutput.Lines.AddStrings(confForOutput);
  memoOutput.Lines.EndUpdate;

  FreeAndNil(confForOutput);
end;

end.

