unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    GBGenerator: TGroupBox;
    GBValidator: TGroupBox;
    EDTKey: TEdit;
    LBSecretKey: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    BTNGenerate: TButton;
    PNResult: TPanel;
    procedure BTNGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BTNGenerateClick(Sender: TObject);
begin
  PNResult.Caption := '123456';
end;

end.
