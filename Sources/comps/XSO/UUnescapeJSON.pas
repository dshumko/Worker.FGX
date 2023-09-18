unit UUnescapeJSON;
interface
uses System.SysUtils, strutils;

function UnescapeJSON(const JSON:string):string;

implementation
function UnescapeJSON(const JSON:string):string;
var
  p,ind:integer;
  s:string;

  function ToInt(ch:char):integer;
  begin
    if '0123456789'.Contains(ch) then
      Result := Ord(ch)-ord('0')
    else
      if 'abcdef'.Contains(ch) then
        Result := 10+Ord(ch)-ord('a')
      else
        Result := 10+Ord(ch)-ord('A')
  end;

  function GetChar(const SubString:string):char;
  var n:array[0..3] of integer;
    ch:char;
    I: Integer;
  begin
    i:=0;
    for ch in substring do
    begin
      n[i]:=ToInt(ch);
      Inc(i);
    end;
    result := Chr((n[0] * 16 * 16 * 16 ) + (n[1] * 16 * 16) + (n[2] * 16) + n[3]);
  end;

begin
  ind:=1;
  result := '';
  repeat
    p:=posEx('\u',JSON,ind);
    if p<>0 then
    begin
      result := result + Copy(JSON, ind, p-ind);
      s:=copy(JSON,p+2,4);
      result := result + GetChar(s);
      ind := p+6;
    end;
  until (p=0);
  result := result + Copy(JSON, ind, json.Length-ind+1);
end;

end.
