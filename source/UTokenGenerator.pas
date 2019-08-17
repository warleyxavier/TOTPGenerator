unit UTokenGenerator;

interface

uses
  SysUtils, DateUtils, Math, IdGlobal, IdHMACSHA1,

  UCoderBase32, UTokenHashGenerator;

type
  ETokenGeneratorException = class(Exception);
  EInvalidTokenDuration = class(ETokenGeneratorException);

  ITokenGenerator = interface
    ['{820474D2-0BBE-4454-8EE9-DBE408834FB9}']

    function Generate(): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime): string; overload;
    function Generate(const TokenDurationInSeconds: Integer): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string; overload;

    procedure Validate(const Token: string);

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
  TimeProcessed, Offset, Part1, Part2, Part3, Part4, CompiledKey: Integer;
  KeyEncoded, TokenHash: string;
  Token: Integer;
begin

  if (TokenDurationInSeconds < 0) then
    raise EInvalidTokenDuration.Create('Token Duration can''t be negative');

  TimeProcessed := DateTimeToUnix(DateTimeToCalculate, False) div TokenDurationInSeconds;

  KeyEncoded := TCoderBase32.Encode(FSecretKey);

  TokenHash := TTokenHasGenerator.Generate(KeyEncoded, TimeProcessed);

  Offset := (ord(TokenHash[20]) AND $0F) + 1;
  Part1 := (ord(TokenHash[Offset + 0]) AND $7F);
  Part2 := (ord(TokenHash[Offset + 1]) AND $FF);
  Part3 := (ord(TokenHash[Offset + 2]) AND $FF);
  Part4 := (ord(TokenHash[Offset + 3]) AND $FF);

  CompiledKey := (Part1 shl 24) OR (Part2 shl 16) OR (Part3 shl 8) OR (Part4);
  Token := CompiledKey mod Trunc(IntPower(10, 6));

  Result := Token.ToString();

end;

procedure TTokenGenerator.Validate(const Token: string);
begin
  // TODO -cMM: TTokenGenerator.Validate default body inserted
end;

end.
