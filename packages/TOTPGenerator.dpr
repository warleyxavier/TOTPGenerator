library TOTPGenerator;

uses
  System.SysUtils,
  System.Classes,
  UTokenGenerator in '..\source\UTokenGenerator.pas',
  UCoderBase32 in '..\source\UCoderBase32.pas',
  UTokenHashGenerator in '..\source\UTokenHashGenerator.pas';

{$R *.res}

function GenerateTOTP(const SecretKey: PAnsiChar; const DurationTime: Integer = -1): PAnsiChar; export; stdcall;
begin

end;

function ValidateTOTP(const Token: PAnsiChar): Boolean; export; stdcall;
begin

end;

exports GenerateTOTP, ValidateTOTP;

begin
end.
