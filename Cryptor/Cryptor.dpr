program Cryptor;

uses
  Vcl.Forms,
  Main in 'src\Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cryptor';
  TStyleManager.TrySetStyle('Obsidian');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
