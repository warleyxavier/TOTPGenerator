unit UTokenGenerator;

interface

uses
  SysUtils, DateUtils, Math, IdGlobal, IdHMACSHA1,

  UCoderBase32, UTokenHashGenerator;

type
  ETokenGeneratorException = class(Exception);
  EInvalidTokenDuration = class(ETokenGeneratorException);
  EInvalidToken = class(ETokenGeneratorException);

  ITokenGenerator = interface
    ['{820474D2-0BBE-4454-8EE9-DBE408834FB9}']

    function GetSecretKey: string;
    procedure SetSecretKey(const Value: string);

    function Generate(): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime): string; overload;
    function Generate(const TokenDurationInSeconds: Integer): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string; overload;

    procedure Validate(const Token: string); overload;
    procedure Validate(const Token: string; const DurationTime: Integer); overload;

    property SecretKey: string read GetSecretKey write SetSecretKey;

  end;

  TTokenGenerator = class(TInterfacedObject, ITokenGenerator)
  private
    FSecretKey: string;

    function GetSecretKey: string;
    procedure SetSecretKey(const Value: string);

    function GenerateToken(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string;
    function IsAValidToken(const Token: string; const DateTimeToCalculate: TDateTime; const DurationTokenInSeconds: Integer): Boolean;

  public

    constructor Create(const SecretKey: string); overload;
    constructor Create; overload;

    function Generate(): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime): string; overload;
    function Generate(const TokenDurationInSeconds: Integer): string; overload;
    function Generate(const DateTimeToCalculate: TDateTime; const TokenDurationInSeconds: Integer): string; overload;

    procedure Validate(const Token: string); overload;
    procedure Validate(const Token: string; const DurationTime: Integer); overload;

    property SecretKey: string read GetSecretKey write SetSecretKey;

  end;

const
  DEFAULT_TOKEN_DURATION_IN_SECONDS = 30;

implementation

constructor TTokenGenerator.Create(const SecretKey: string);
begin
  FSecretKey := SecretKey;
end;

constructor TTokenGenerator.Create;
begin
  inherited;
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

function TTokenGenerator.GetSecretKey: string;
begin
  Result := FSecretKey;
end;

procedure TTokenGenerator.Validate(const Token: string);
begin
  Validate(Token, DEFAULT_TOKEN_DURATION_IN_SECONDS);
end;

procedure TTokenGenerator.Validate(const Token: string; const DurationTime: Integer);
begin

  if IsAValidToken(Token, Now, DurationTime) then
    Exit;

  raise EInvalidToken.Create('Invalid token!');

end;

function TTokenGenerator.IsAValidToken(const Token: string; const DateTimeToCalculate: TDateTime; const DurationTokenInSeconds: Integer): Boolean;
var
  UnixValue, Value: Integer;
  SimuledToken: string;
begin

  UnixValue := DateTimeToUnix(DateTimeToCalculate, False) div DurationTokenInSeconds;

  for Value := UnixValue - 4 to UnixValue + 4 do
  begin

    SimuledToken := GenerateToken(Now, DurationTokenInSeconds);

    if not SimuledToken.Equals(Token) then
      continue;

    Exit(True);

  end;

  Result := False;
end;

procedure TTokenGenerator.SetSecretKey(const Value: string);
begin
  FSecretKey := Value;
end;

end.
