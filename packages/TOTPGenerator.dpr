library TOTPGenerator;

uses
  System.SysUtils,
  System.Classes,
  UTokenGenerator in '..\source\UTokenGenerator.pas',
  UCoderBase32 in '..\source\UCoderBase32.pas',
  UTokenHashGenerator in '..\source\UTokenHashGenerator.pas';

{$R *.res}

function GenerateTOTP(const SecretKey: PAnsiChar; const DurationTime: Integer = 30): PAnsiChar; export; stdcall;
var
  Token: string;
  Generator: ITokenGenerator;
begin

  Generator := TTokenGenerator.Create(string(SecretKey));

  Token := Generator.Generate(DurationTime);

  Result := PAnsiChar(Token);

end;

function ValidateTOTP(const Token: PAnsiChar): Boolean; export; stdcall;
begin

end;

exports GenerateTOTP, ValidateTOTP;

begin
end.
