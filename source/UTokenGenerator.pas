unit UTokenGenerator;

interface

uses
  SysUtils, DateUtils, IdGlobal, IdHMACSHA1,

  UCoderBase32, UTokenHashGenerator;

type
  ETokenGeneratorException = class(Exception);
  EInvalidTokenDuration = class(ETokenGeneratorException);

  ITokenGenerator = interface
    ['{820474D2-0BBE-4454-8EE9-DBE408834FB9}']
  end;

  TTokenGenerator = class(TInterfacedObject, ITokenGenerator)
  private
    FSecretKey: string;

    function GenerateToken(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string;

  public

    constructor Create(const SecretKey: string);

    function Generate(): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime): string; overload;
    function Generate(const TokenDurationInSeconds: Integer): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string; overload;

    procedure Validate(const Token: string);

  end;

const
  DEFAULT_TOKEN_DURATION_IN_SECONDS = 30;

implementation

constructor TTokenGenerator.Create(const SecretKey: string);
begin
  FSecretKey := SecretKey;
end;

function TTokenGenerator.Generate: string;
begin
  Result := GenerateToken(Now, DEFAULT_TOKEN_DURATION_IN_SECONDS);
end;

function TTokenGenerator.Generate(const DateTimeToCalculate: TDateTime): string;
begin
  Result := GenerateToken(DateTimeToCalculate, DEFAULT_TOKEN_DURATION_IN_SECONDS);
end;

function TTokenGenerator.Generate(const TokenDurationInSeconds: Integer): string;
begin
  Result := GenerateToken(Now, TokenDurationInSeconds);
end;

function TTokenGenerator.Generate(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string;
begin
  Result := GenerateToken(DateTimeToCalculate, TokenDurationInSeconds);
end;

function TTokenGenerator.GenerateToken(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string;
var
  TimeProcessed: Integer;
  KeyEncoded, TokenHash: string;
begin

  if (TokenDurationInSeconds < 0) then
    raise EInvalidTokenDuration.Create('Token Duration can''t be negative');

  TimeProcessed := DateTimeToUnix(DateTimeToCalculate, False) div TokenDurationInSeconds;

  KeyEncoded := TCoderBase32.Encode(FSecretKey);

  TokenHash := TTokenHasGenerator.Generate(KeyEncoded, TimeProcessed);

  Result := '';

end;

procedure TTokenGenerator.Validate(const Token: string);
begin
  // TODO -cMM: TTokenGenerator.Validate default body inserted
end;

end.
