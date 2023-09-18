unit ServiceUnit.Settings;

interface
uses
  XSuperObject, JsonableObject;

type
  TMobWorkerSettings = class(TJsonableObject)
  public
    status: string;
    login: string;
    password: string;
    autoEnter: Boolean;
    gpsInterval: integer;

    validURL: string;
    validURLDate: TDate;
    class function GetFileName:string; static;



var
  Settings: TMobWorkerSettings;

implementation

uses
  system.ioutils;

{ TwlSettings }

class function TMobWorkerSettings.GetFileName: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'accWork');
end;

initialization
  Settings := TMobWorkerSettings.Create;

finalization
  Settings.Free;
  Settings := nil;

end.