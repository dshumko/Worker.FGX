unit ServiceUnit.BookMarks;

interface

uses
  Generics.Collections, XSuperObject, JsonableObject, ServiceUnit.mwClasses;

type
  TMobWorkerBookMarks = class(TJsonableObject)
  public
    struct: TObjectList<TmwBookMarkItem>;
    constructor Create; override;
    destructor Destroy; override;
    class function GetFileName:string; static;
    function ContainsBookMark(AFormName: String; AId: integer): Integer;
    procedure AddBookMark(AFormName: String; AId: integer; AName: String);
    procedure DeleteBookMark(AFormName: String; AId: integer);
  end;

var
  BookMarks: TMobWorkerBookMarks;

implementation

uses
  System.IOUtils;

procedure TMobWorkerBookMarks.AddBookMark(AFormName: String;
  AId: integer; AName: string);
var item: TmwBookMarkItem;
begin
  if ContainsBookMark(AFormName, aId) = -1 then
  begin
    item := TmwBookMarkItem.Create;
    item.id := AId;
    item.form := AFormName;
    item.name := AName;
    struct.Add(item);
    SaveToFile(GetFileName);
  end;
end;

function TMobWorkerBookMarks.ContainsBookMark(AFormName: String;
  AId: integer):Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to struct.Count - 1 do
  begin
    if (struct[i].form = AFormName) and (struct[i].id = AId) then
    begin
      Result := 1;
      Break;
    end;
  end;
end;

constructor TMobWorkerBookMarks.Create;
begin
  inherited;
  struct := TObjectList<TmwBookMarkItem>.Create(true);
  LoadFromFile(GetFileName);
end;

procedure TMobWorkerBookMarks.DeleteBookMark(AFormName: String;
  AId: integer);
var i: Integer;
begin
  for I := 0 to struct.Count - 1 do
  begin
    if (struct[i].form = AFormName) and (struct[i].id = AId) then
    begin
      struct.Delete(i);
      Break;
    end;
  end;
  SaveToFile(GetFileName);
end;

destructor TMobWorkerBookMarks.Destroy;
begin
  struct.Free;
  inherited;
end;

class function TMobWorkerBookMarks.GetFileName: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'bookmarks');
end;

initialization
  BookMarks := TMobWorkerBookMarks.Create;

finalization
  BookMarks.Free;
  BookMarks:= nil;

end.
