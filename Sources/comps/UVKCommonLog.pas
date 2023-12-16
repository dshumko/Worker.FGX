unit UVKCommonLog;

interface
uses
  System.Classes, System.SysUtils, system.ioutils;

type

  TVKCommonLog = class
  private
    FS: TFormatSettings;
    procedure CreateFile;
  public
    LogFile: TStreamwriter;
    LogStrings: TStrings;
    Filename : string;
    function Folder() : string;
    procedure Log(const s:string);
    procedure LogDashes(count: integer);
    procedure CopyLogFileTo(const ADstFilename: string);
    constructor Create(const AFilename: string);
    destructor Destroy; override;
    procedure Clear;
  end;

var
  Log: TVKCommonLog;

implementation

{ TSfaLog }

function TVKCommonLog.Folder() : string;
begin
  result := ExtractFilePath(Filename);
end;

constructor TVKCommonLog.Create(const AFilename: string);
begin
  FS := TFormatSettings.Create;
  Filename := AFilename;
  ForceDirectories(Folder());
  CreateFile;
end;


procedure TVKCommonLog.Clear;
begin
  FreeAndNil(LogFile);
  if FileExists(Filename) then
    TFile.Delete(Filename);
  CreateFile();
end;


procedure TVKCommonLog.CreateFile;
var
  r:TFileStream;
  mode : word;
begin
  if FileExists(Filename) then
    mode := fmOpenWrite + fmShareDenyWrite
  else
    mode := fmCreate + fmShareDenyWrite;

  r := TFileStream.Create(Filename, mode);
  r.Seek(0,TSeekOrigin.soEnd);
  LogFile := TStreamWriter.Create(r, TEncoding.UTF8);
  LogFile.OwnStream;
end;

destructor TVKCommonLog.Destroy;
begin
  FreeAndNil(LogFile);
  inherited;
end;

procedure TVKCommonLog.LogDashes(count: integer);
begin
  log (StringOfChar('-', count));
end;

procedure TVKCommonLog.CopyLogFileTo(const ADstFilename: string);
begin
  TFile.Copy(filename, ADstFilename);
end;

procedure TVKCommonLog.Log(const s: string);
var
  txt : string;
begin
  if TThread.CurrentThread.ThreadID = MainThreadID then
    txt := formatdatetime('hh:nn:ss.zzz ', now, fs)  + '(main) ' + s
  else
    txt := formatdatetime('hh:nn:ss.zzz ', now, fs) + '(' + TThread.CurrentThread.ThreadID.ToString + ') ' + s;
  TThread.Queue(nil,
  procedure
  begin
    if s <> '' then
      LogFile.Write( txt );
    if Logstrings<>NIL then
      Logstrings.Add( txt );
    LogFile.WriteLine;
  end
  );
end;


initialization

finalization
  FreeAndNil(Log);

end.
