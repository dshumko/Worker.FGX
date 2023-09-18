unit UUriHelper;

interface
uses System.NetEncoding, System.Net.URLClient;

type
  TURIHelper = record helper for TURI
    function FindParameterIndex(const AName: string): Integer;
    function ParamExists(const AName:string): Boolean;
    procedure AddOrSetParamByName(const AName,AValue: string);
  end;


implementation

uses
  System.SysUtils;

{ TURIHelper }

procedure TURIHelper.AddOrSetParamByName(const AName, AValue: string);
var
  LIndex: Integer;
begin
  LIndex := FindParameterIndex(AName);
  if LIndex >= 0 then
    Parameter[LIndex] := TURIParameter.Create( TNetEncoding.URL.EncodeQuery(AName), TNetEncoding.URL.EncodeQuery(AValue))
  else
    AddParameter(AName, AValue);
end;

function TURIHelper.FindParameterIndex(const AName: string): Integer;
var
  I: Integer;
  LName: string;
begin
  Result := -1;
  LName := TNetEncoding.URL.EncodeQuery(AName);
  for I := 0 to Length(Params) - 1 do
    if Params[I].Name = LName then
      Exit(I);
end;

function TURIHelper.ParamExists(const AName: string): Boolean;
begin
  Result := FindParameterIndex(AName)<>-1;
end;

end.