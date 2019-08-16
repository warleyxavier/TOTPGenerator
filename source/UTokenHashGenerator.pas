unit UTokenHashGenerator;

interface

uses
  SysUtils, IdHMACSHA1, IdGlobal;

type
  TTokenHasGenerator = class
  private
    class function ConverterIdBytes(const Value: TIdBytes): TIdBytes;
    class function ConverterStringToBytes(const Value: string): TIdBytes;
    class function ConverterKeyToHash(const Key: TIdBytes; const Buffer: TIdBytes): TIdBytes;
  public
    class function Generate(const Key: string; const DurationTime: Integer): string;
  end;

implementation

class function TTokenHasGenerator.Generate(const Key: string; const DurationTime: Integer): string;
var
  DurationTimeInBytes: TIdBytes;
  KeyInBytes: TIdBytes;
  Hash: TIdBytes;
begin

  DurationTimeInBytes := ConverterIdBytes(ToBytes(Int64(DurationTime)));

  KeyInBytes := ConverterStringToBytes(Key);

  Hash := ConverterKeyToHash(KeyInBytes, DurationTimeInBytes);

  Result := BytesToStringRaw(Hash);

end;

class function TTokenHasGenerator.ConverterKeyToHash(const Key: TIdBytes; const Buffer: TIdBytes): TIdBytes;
var
  Converter: TIdHMACSHA1;
begin

  Converter := TIdHMACSHA1.Create;

  try
    Converter.Key := Key;
    Result := Converter.HashValue(Buffer);

  finally
    Converter.Free;
  end;

end;

class function TTokenHasGenerator.ConverterIdBytes(const Value: TIdBytes): TIdBytes;
var
  i: Integer;
begin

  SetLength(Result, Length(Value));

  for i := Low(Value) to High(Value) do
    Result[High(Value) - i] := Value[i];

end;

class function TTokenHasGenerator.ConverterStringToBytes(const Value: string): TIdBytes;
var
  ch: Char;
  Index: Integer;
begin
  SetLength(Result, Value.Length);

  Index := 0;
  for ch in Value do
  begin
    Result[Index] := Ord(ch);
    inc(Index);
  end;
end;

end.
