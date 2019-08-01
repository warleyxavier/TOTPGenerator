library TOTPGenerator;

uses
  System.SysUtils,
  System.Classes;

{$R *.res}

function GenerateTOTP(const SecretKey: PAnsiChar; const DurationTime: Integer = -1): PAnsiChar;
begin

end;

function ValidateTOTP(const Token: PAnsiChar): Boolean;
begin

end;

begin
end.
