unit JsonableObject;

interface

uses
  XSuperObject,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections;

type
  TStringArray = TArray<string>;
{
  When we serialize List:TObjectList<TMyObject> it saves too many garbage fields
  To keep JSON clear let's declare temp _List:TArray<TMyObject>

  Then you need to move items from one to another using methods BeforeSave and AfterLoad
  [DISABLE]
  List: TObjectList<TMyObject>;
  [Alias('List')]
  _List:TArray<TMyObject>;

  The second example is converting time from string to TDateTime
  [DISABLE]
  FTime: TDateTime;
  [Alias('time')]
  _FTime: string;

  procedure AfterLoad(X:ISuperObject); override;
  begin
    ArrayToList<TMyObject>(_List,List)
    FTime := StrToDateLong(X.S['time']);
  end;

  procedure PrepareProperties; override;
  begin
    ListToArray<TMyObject>(List,_List);
    _FTime := FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', FTime, fs);
  end;

  If we want to hide or add some fields or convert values in ready Json object then we can do it here.
  procedure BeforeSave(var X: ISuperObject); override;
  begin
    X.Remove('Index');
  end;

  Please remind you have to use TJsonableObject.AsJsonObj instead of TSuperObjectHelper.AsJsonObject
  in order to use the advantages of BeforeSave and PrepareProperties methods
}

  TJsonableObject = class(TObject)
  private
  protected
    fs: TFormatSettings;
    function StrToCurr(const s: string): Currency;
    function CurrToStr(c: currency): string;
    function StrToBool(const s: string): boolean;
    function BoolToStr(b: boolean): string;
    function BoolToInt(b: boolean): integer;
    function IntToBool(n: integer): boolean;

    // converts YYYY-MM-DD HH:NN:SS.ZZZ to TDateTime
    function StrToDateLong(const Value: string): TDateTime;
  public
    [DISABLE]
    FileName: string;
    function AsJsonObj: ISuperObject; virtual;
    // indent = true - pretty print. false - single string
    function AsString(indent: Boolean = false): string; overload;
    procedure LoadFromJSON(const S: string); overload; virtual;
    procedure LoadFromJSON(x: ISuperObject); overload; virtual;
    procedure LoadFromFile(const FName: string; Encoding: TEncoding = NIL); virtual;

    // PrepareProperties is to be called BEFORE converting object to JSON
    // so we can for example fill fake arrays instead of lists
    // see comments above
    procedure PrepareProperties(); virtual;
    // BeforeSave - AFTER converting when JSON object is ready
    // we can handle it to change/add/remove fields
    // see comments above
    procedure BeforeSave(var X: ISuperObject); virtual;
    // see comments above
    procedure AfterLoad(X: ISuperObject); virtual;
    class procedure ArrayToList<T: class>(var arr: TArray<T>; lst: TObjectList<T>); overload;
    class procedure ArrayToList(var arr: TStringArray; lst: TStringList); overload;
    class procedure ListToArray(lst: TStringList; var arr: TStringArray); overload;
    class procedure ListToArray<T: class>(lst: TObjectList<T>; var arr: TArray<T>); overload;
    procedure SaveToFile(const FName: string = ''; Encoding: TEncoding = nil); overload; virtual;
    constructor Create; virtual;
    constructor CreateFromFile(const fname: string; Encoding: TEncoding = nil); virtual;
    constructor CreateFromJSON(const JSON: string); overload;
    constructor CreateFromJSON(x: ISuperObject); overload;
    class function Unescape(const s: string): string;
  end;

implementation


{ TJsonableObject }

class procedure TJsonableObject.ArrayToList<T>(var arr: TArray<T>; lst: TObjectList<T>);
var
  i: Integer;
begin
  lst.Clear;
  for i := 0 to length(arr) - 1 do
    lst.Add(arr[i]);
  setlength(arr, 0);
end;

class procedure TJsonableObject.ArrayToList(var arr: TStringArray; lst: TStringList);
var
  i: Integer;
begin
  lst.Clear;
  for i := 0 to length(arr) - 1 do
    lst.Add(arr[i]);
  setlength(arr, 0);
end;

class procedure TJsonableObject.ListToArray(lst: TStringList; var arr: TStringArray);
var
  i: integer;
begin
  setLength(arr, lst.Count);
  for i := 0 to lst.Count - 1 do
    arr[i] := lst[i];
end;

class procedure TJsonableObject.ListToArray<T>(lst: TObjectList<T>; var arr: TArray<T>);
var
  i: integer;
begin
  setLength(arr, lst.Count);
  for i := 0 to lst.Count - 1 do
    arr[i] := lst[i];
end;

procedure TJsonableObject.AfterLoad(X: ISuperObject);
begin

end;

function TJsonableObject.AsJsonObj: ISuperObject;
begin
  result := inherited AsJSONObject;
  BeforeSave(result);
end;

function TJsonableObject.AsString(indent: Boolean): string;
begin
  result := Unescape(AsJSON(indent, False));
end;

procedure TJsonableObject.BeforeSave(var X: ISuperObject);
begin

end;

constructor TJsonableObject.Create;
begin
  inherited Create;
  fs := TFormatSettings.Create();
  fs.DecimalSeparator := '.';
end;

constructor TJsonableObject.CreateFromJSON(const JSON: string);
begin
  Create;
  LoadFromJSON(JSON);
end;

constructor TJsonableObject.CreateFromFile(const fname: string; Encoding: TEncoding = NIL);
var
  L: TStreamReader;
  s: string;
begin
  if Encoding = NIL then
    Encoding := TEncoding.UTF8;

  if FileExists(fname) then
  begin
    FileName := fname;
    L := TStreamReader.Create(fname, Encoding);
    try
      s := L.ReadToEnd;
      CreateFromJSON(s);
    finally
      L.Free;
    end;
  end
  else
    raise Exception.Create('File not found: ' + fname);
end;

constructor TJsonableObject.CreateFromJSON(x: ISuperObject);
begin
  Create;
  LoadFromJSON(x);
end;

procedure TJsonableObject.LoadFromJSON(const S: string);
begin
  LoadFromJSON(so(S));
end;

procedure TJsonableObject.LoadFromJSON(x: ISuperObject);
begin
  Self.AssignFromJSON(x);
  AfterLoad(x);
end;

procedure TJsonableObject.PrepareProperties;
begin

end;

procedure TJsonableObject.SaveToFile(const FName: string = ''; Encoding: TEncoding = nil);
var
  L: TStreamWriter;
  s: string;
  fn: string;
  X: ISuperObject;
begin
  if Encoding = NIL then
    Encoding := TEncoding.UTF8;

  if (FName = '') then
  begin
    if filename = '' then
      filename := ChangeFileExt(ParamStr(0), '.json');
    fn := Filename;
  end
  else
    fn := FName;
  L := TStreamWriter.Create(fn, False, Encoding);
  try
    PrepareProperties();
    X := AsJsonObj;
    s := Unescape(X.AsJSON(True));
    L.Write(s);
  finally
    L.Free;
  end;
end;

class function TJsonableObject.Unescape(const s: string): string;
var
  i: Integer;
begin
  Result := s;
  i := pos('\u', result);
  while i > 0 do
  begin
    result := Copy(result, 1, i - 1) + Char(StrToIntDef('$' + Copy(result, i + 2, 4), 32)) + copy(result, i + 6, Length(result));
    i := pos('\u', result);
  end;
end;

procedure TJsonableObject.LoadFromFile(const FName: string; Encoding: TEncoding = NIL);
var
  L: TStreamReader;
  s: string;
  fn: string;
begin
  if Encoding = nil then
    Encoding := TEncoding.UTF8;

  if FName = '' then
    fn := ChangeFileExt(ParamStr(0), '.json')
  else
    fn := FName;
  if FileExists(fn) then
  begin
    L := TStreamReader.Create(fn, Encoding);
    try
      s := L.ReadToEnd;
      LoadFromJSON(s);
      filename := FName;
    finally
      L.Free;
    end;
  end;
end;

function TJsonableObject.StrToCurr(const s: string): Currency;
begin
  Result := System.sysutils.StrToCurr(s, fs);
end;

function TJsonableObject.StrToDateLong(const Value: string): TDateTime;
var
  d, m, y: word;
  h, n, s, z: word;
begin
  y := StrToIntDef(Value.Substring(0, 4), 0);
  m := StrToIntDef(Value.Substring(5, 2), 0);
  d := StrToIntDef(Value.Substring(8, 2), 0);
  h := StrToIntDef(Value.Substring(11, 2), 0);
  n := StrToIntDef(Value.Substring(14, 2), 0);
  s := StrToIntDef(Value.Substring(17, 2), 0);
  z := StrToIntDef(Value.Substring(20, 3), 0);
  result := EncodeDate(y, m, d) + EncodeTime(h, n, s, z);
end;

function TJsonableObject.CurrToStr(c: currency): string;
begin
  Result := System.sysutils.CurrToStr(c, fs);
end;

function TJsonableObject.StrToBool(const s: string): boolean;
begin
  result := s = '1';
end;

function TJsonableObject.BoolToStr(b: boolean): string;
begin
  if b then
    Result := '1'
  else
    Result := '0';
end;

function TJsonableObject.BoolToInt(b: boolean): integer;
begin
  if b then
    Result := 1
  else
    Result := 0;
end;

function TJsonableObject.IntToBool(n: integer): Boolean;
begin
  result := n = 1;
end;

end.

