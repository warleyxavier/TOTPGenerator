unit UCoderBase32;

interface

uses
  SysUtils;

type
  TCoderBase32 = class
  public
    class function Encode(const Value: string): string;
  end;

const
  VALIDS_CARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

implementation

class function TCoderBase32.Encode(const Value: string): string;
var
  n, j: Integer;
  Index, Position: Integer;
  CompiledValue: string;
begin

  CompiledValue := Value.ToUpper;

  n := 0;
  j := 0;
  Result := '';

  for Index := 1 to CompiledValue.Length do
  begin
    n := n shl 5;

    Position := Pos(CompiledValue[Index], VALIDS_CARACTERS);

    if Position >= 0 then
      n := n + (Position - 1);

		j := j + 5;

    if (j >= 8) then
    begin
      j := j - 8;
      Result := Result + chr((n AND ($FF shl j)) shr j);
    end;

  end;

end;

end.
