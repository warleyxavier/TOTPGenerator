unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,

  UTokenGenerator;

type
  TForm1 = class(TForm)
    GBGenerator: TGroupBox;
    GBValidator: TGroupBox;
    EDTKey: TEdit;
    LBSecretKey: TLabel;
    LBDurationToken: TLabel;
    EDTDurationToken: TEdit;
    BTNGenerate: TButton;
    PNResult: TPanel;
    LBKeyValidate: TLabel;
    EDTKeyValidate: TEdit;
    EDTToken: TEdit;
    BTNValidate: TButton;
    LBToken: TLabel;
    PNResultValidation: TPanel;
    TMAutoGeneration: TTimer;
    CBAutoGeneration: TCheckBox;
    Label1: TLabel;
    EDTDurationTimeValidation: TEdit;
    procedure BTNGenerateClick(Sender: TObject);
    procedure BTNValidateClick(Sender: TObject);
    procedure CBAutoGenerationClick(Sender: TObject);
    procedure TMAutoGenerationTimer(Sender: TObject);
  private
    procedure GenerateToken;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BTNGenerateClick(Sender: TObject);
begin
  GenerateToken;
end;

procedure TForm1.BTNValidateClick(Sender: TObject);
var
  Generator: ITokenGenerator;
  DurationTime: Integer;
  Result: string;
begin

  if string(EDTKeyValidate.Text).IsEmpty or string(EDTToken.Text).IsEmpty then
  begin
    PNResultValidation.Caption := '';
    Exit;
  end;

  Result := 'Is Valid';

  Generator := TTokenGenerator.Create(EDTKeyValidate.Text);

  try

    DurationTime := Integer.Parse(EDTDurationTimeValidation.Text);

    Generator.Validate(EDTToken.Text, DurationTime);

  except

    on E: EInvalidToken do
      Result := 'Not Is Valid';
    on E: Exception do
    begin
      ShowMessage(E.Message);
      exit;
    end;

  end;

  PNResultValidation.Caption := Result;

end;

procedure TForm1.CBAutoGenerationClick(Sender: TObject);
var
  CanEnable: Boolean;
begin

  CanEnable := CBAutoGeneration.Checked;

  TMAutoGeneration.Enabled := CanEnable;
  BTNGenerate.Enabled := not CanEnable;

end;

procedure TForm1.TMAutoGenerationTimer(Sender: TObject);
begin
  GenerateToken();
end;

procedure TForm1.GenerateToken;
var
  Generator: ITokenGenerator;
  Token: string;
  Duration: Integer;
begin

  if string(EDTKey.Text).IsEmpty or string(EDTDurationToken.Text).IsEmpty then
  begin
    PNResult.Caption := '';
    Exit;
  end;

  Generator := TTokenGenerator.Create(EDTKey.Text);

  Duration := Integer.Parse(EDTDurationToken.Text);

  Token := Generator.Generate(Duration);

  PNResult.Caption := Token;
end;

end.
