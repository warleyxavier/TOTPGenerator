program TOTPGeneratorExample;

uses
  Vcl.Forms,
  UMain in '..\source\Example\UMain.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  UCoderBase32 in '..\source\UCoderBase32.pas',
  UTokenGenerator in '..\source\UTokenGenerator.pas',
  UTokenHashGenerator in '..\source\UTokenHashGenerator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
