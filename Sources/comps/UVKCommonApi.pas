unit UVKCommonAPI;
{******************************************************************************
*          Base unit for creating a specific API connector.                   *
*                                                                             *
*          Author: Vladimir Krapotkin. Saint-Petersburg.                      *
*******************************************************************************

Prerequisites:
XSuperObject library
https://github.com/onryldz/x-superobject

You should create an ancestor for the class TVKCommonApi
where you can implement specific API methods.

For example

procedure TMyApi.ChangeUser(const AUserGuid, ALName, AFname, AEmail: string);
var
x: ISuperObject;
begin
ClearParams;
RESTparams.Add('users');
RESTparams.Add(AUserGuid);

x := SO();
x.S['email'] := AEMail;
x.S['l_name'] := ALName;
x.S['f_name'] := AFName;
PostData.Clear;
PostData.WriteString(x.AsJSON());
Request('POST');
end;

You can construct URL part using RESTparams.Add
You can add query part using FURI.AddParameter

Also look at virtual methods you can override to customize your requests.
I.e. SetHeaders() or MakeURI()

******************************************************************************}

interface

uses
  System.Types, System.Classes, System.Threading, System.SysUtils,
  System.Net.HTTPClient,
  System.Net.UrlClient,
  System.NetEncoding,
  System.syncobjs,
  System.generics.collections,
  XSuperObject,
{$IFDEF FGX}
  FGX.Log,
  FGX.Application, FGX.Dialogs,
  FGX.Platform.Android, FGX.Helpers.Android, Android.Api.JavaTypes,
  Android.Api.ActivityAndView,
{$ENDIF}
  JsonableObject,
  UUriHelper,
  UVKCommonLog;

type
  THttpClientPool = class(TObjectList<THttpClient>)
  private
    CS: TCriticalSection;
  public
    function get: THttpClient;
    procedure put(client: THttpClient);
    constructor Create(AOwnsObjects: Boolean = True);
    destructor Destroy; override;
  end;

  TErrRec = record
    Code: integer;
    Status: string;
    Msg: string;
    HttpCode: integer;
    HttpString: string;
    procedure Clear;
    function HasError: Boolean;
    function InternetUnavailableError: Boolean;
  end;

  TVKCommonApi = class
  private
    FBaseURL: string;
    procedure SetBaseURL(const Value: string);
    function GetBaseURL(): string;
    function GetOnReceiveData: TReceiveDataEvent;
    procedure SetOnReceiveData(const Value: TReceiveDataEvent);
    function GetPostData: TStringStream;
    function GetResStream: TStringStream;
  protected
    FURI: TURI;
    FHeaders: TNameValueArray;
    procedure ResetURL();
    procedure SetHttpClientParams(AHttp: THttpClient); virtual;
  public
    class var HttpClientPool: THttpClientPool;
    // log levels:
    // 1: точки входа, URI, время исполнения HTTP, время исполнения API, ошибки
    // 2: +resultString
    class var LogLevel: integer;
    class var LogTag: string;

    class var FLog: TVKCommonLog;
    class var FCS: TCriticalSection;
    // returns folder name only, without path
    // for putting into GetDocumentsPath
    class function GetLogFolder(): string; virtual;
    class function GetLogFilename(): string; virtual;
    class procedure WriteLog(s: string; ALevel: integer = 1);

  const
    HTTP_STATUS_OK = 200;
    HTTP_STATUS_CREATED = 201;
    HTTP_STATUS_BAD_REQUEST = 400;
    HTTP_STATUS_UNAUTHORIZED = 401;
    HTTP_STATUS_FORBIDDEN = 403;
    HTTP_STATUS_NOT_FOUND = 404;
    HTTP_STATUS_METHOD_NOT_ALLOWED = 405;
    HTTP_STATUS_CONFLICT = 409;
    HTTP_STATUS_INTERNAL_SERVER_ERROR = 500;

{$IFDEF ANDROID}
    ERR_NO_INTERNET = 12029;
{$ENDIF}
{$IFDEF MSWINDOWS}
    ERR_NO_INTERNET = 12029;
{$ENDIF}
{$IFDEF MACOS}
    ERR_NO_INTERNET = 1009;
{$ENDIF}
    ERR_DNS_ERROR = 12007;

  public
    FS: TFormatSettings;
    Token: string;
    RESTparams: TStringList;
    URIparams: TStringList;
    Errors: TStringList;
    Canceled: Boolean;

    // TO-DO - implementation specific fields. Move to ancestor.
    DB: string;
    accesskey: string;
    // -----------------------

    HTTP: THttpClient;
    Err: TErrRec;
    ResultString: string;
    MakeResultJson: Boolean;
    ResultJson: ISuperObject;
    AttemptIntervals: TArray<integer>;
    ResponseTimeouts: TArray<integer>;

    FPostData: TBytesStream;
    FResStream: TBytesStream;

    FIsArray: Boolean;
    FProtocolversion: THTTPProtocolVersion;
    FHttpMethod: string;

    constructor Create; virtual;
    destructor Destroy; override;
    constructor Clone(src: TVKCommonApi);

    procedure ClearParams();
    procedure AddHeader(const Name, Value: string;
      OverrideExisting: Boolean = True);
    function GetHeader(const Name: string; var Value: string): Boolean;
    procedure ClearHeaders();

    procedure AssignFrom(a: TVKCommonApi); virtual;

    function DateAsStr(d: TDateTime): string;
    function FirebirdDateToRus(ADate: string): string;
    function MakeUri(): string; virtual;
    procedure OnValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);

    procedure SetHeaders(); virtual;
    function Request(const ARequestType: string;
      AResStream: TStream = nil): string;
    procedure GetErrFromJson; virtual;

    function passHash(const pass: string): string; virtual;

    procedure SetupStreamForBinary(var AStream: TBytesStream);
    procedure SetupStreamForText(var AStream: TBytesStream);

    property BaseURL: string read GetBaseURL write SetBaseURL;
    property OnReceiveData: TReceiveDataEvent read GetOnReceiveData
      write SetOnReceiveData;

    property PostData: TStringStream read GetPostData;
    property ResStream: TStringStream read GetResStream;
  end;

  // базовый класс для усложненных последовательных вызовов типа DownloadImages
TVKCommonApiThread < T: TVKCommonApi, constructor >= class(TThread)
  public FAPI: T;
Fint:
integer;
constructor Create(const AApi: T; const ATermProc: TNotifyEvent); virtual;
destructor Destroy; override;
end;

{$IFDEF FGX}
TVKDownloaderThread<T: TVKCommonApi, constructor> = class(TVKCommonApiThread<T>)
  public FUrlPath: string;
FFilename:
string;
FResultURI:
JUri;
FFileHash:
string;

constructor Create(const AApi: T; const AURLPath, AFilename: string;
  const ATermProc: TNotifyEvent; const AProgressHandler: TReceiveDataEvent);
  procedure Execute; override;
  end;
{$ENDIF}

const
  sSTATUS = 'status';
  sERROR = 'ERROR';
  sOK = 'OK';
  sTEXT = 'text';
  sMethod = 'method';
  sLogin = 'login';
  sPaswd = 'paswd';
  sToken = 'token';
  sCanceledByUser = 'Отменено пользователем';

implementation

uses
  System.hash, System.netconsts,
  System.ioutils,

  uunescapejson;

resourcestring
  sMSG_ERROR_NO_CONNECTION = 'Нет доступа в интернет';
  sMSG_ERR_GET_DATA = 'Ошибка получения данных';

procedure TErrRec.Clear;
begin
  Code := 0;
  Status := '';
  Msg := '';
end;

procedure TVKCommonApi.SetHeaders;
begin
  AddHeader('Content-Type', 'application/json', false);
  AddHeader('Accept-Encoding', 'deflate, gzip', false);
  AddHeader('Accept', '*/*', false);
end;

procedure TVKCommonApi.SetHttpClientParams(AHttp: THttpClient);
begin
  AHttp.ConnectionTimeout := 15000;
  AHttp.ResponseTimeout := 15000;
  AHttp.OnValidateServerCertificate := OnValidateServerCertificate;
end;

constructor TVKCommonApi.Create;
begin
  URIparams := TStringList.Create;
  RESTparams := TStringList.Create;
  FS := TFormatSettings.Create();
  FS.DateSeparator := '.';
  FS.DecimalSeparator := '.';

  FPostData := TStringStream.Create('', TEncoding.UTF8);
  FResStream := TStringStream.Create('', TEncoding.UTF8);

  // AttemptIntervals := [10,20,50];
  AttemptIntervals := [15, 30, 60];

  // SetLength(FHeaders, 1);
  // FHeaders[0].Name := 'Connection';
  // FHeaders[0].Value := 'close';

  HTTP := HttpClientPool.get;
  SetHttpClientParams(HTTP);

  MakeResultJson := True;
end;

destructor TVKCommonApi.Destroy;
begin
  HttpClientPool.put(HTTP);
  FreeAndNil(FPostData);
  FreeAndNil(FResStream);
  FreeAndNil(URIparams);
  FreeAndNil(RESTparams);
  inherited Destroy;
end;

constructor TVKCommonApi.Clone(src: TVKCommonApi);
begin
  HttpClientPool.CS.Enter;
  try
    Create;
    AssignFrom(src);
  finally
    HttpClientPool.CS.leave;
  end;
end;

procedure TVKCommonApi.ClearParams;
begin
  RESTparams.Clear;
  URIparams.Clear;
  FPostData.Clear;
  ClearHeaders();
end;

procedure TVKCommonApi.AddHeader(const Name: string; const Value: string;
  OverrideExisting: Boolean = True);
var
  i: integer;
begin
  for i := 0 to High(FHeaders) do
  begin
    if AnsiSameText(Name, FHeaders[i].Name) then
    begin
      if OverrideExisting then
        FHeaders[i].Value := Value;
      exit;
    end;
  end;
  SetLength(FHeaders, length(FHeaders) + 1);
  FHeaders[length(FHeaders) - 1].Name := name;
  FHeaders[length(FHeaders) - 1].Value := Value;
end;

procedure TVKCommonApi.ClearHeaders;
begin
  SetLength(FHeaders, 0);
end;

procedure TVKCommonApi.AssignFrom(a: TVKCommonApi);
begin
  Token := a.Token;
  BaseURL := a.BaseURL;
  FS := a.FS;
  DB := a.DB;
  MakeResultJson := a.MakeResultJson;
  accesskey := a.accesskey;
  AttemptIntervals := copy(a.AttemptIntervals);
  ResponseTimeouts := copy(a.ResponseTimeouts);
end;

function TVKCommonApi.GetBaseURL;
begin
  result := FBaseURL;
end;

function TVKCommonApi.GetOnReceiveData: TReceiveDataEvent;
begin
  result := HTTP.OnReceiveData;
end;

function TVKCommonApi.GetPostData: TStringStream;
begin
  if FPostData is TStringStream then
    result := TStringStream(FPostData)
  else
    result := nil;
end;

function TVKCommonApi.GetResStream: TStringStream;
begin
  if FResStream is TStringStream then
    result := TStringStream(FResStream)
  else
    result := nil;
end;

function TVKCommonApi.DateAsStr(d: TDateTime): string;
begin
  result := FormatDateTime('ddmmyyyy', d, FS);
end;

function TVKCommonApi.FirebirdDateToRus(ADate: string): string;
var
  a: TArray<string>;
begin
  a := ADate.Split(['-']);
  result := a[2] + '.' + a[1] + '.' + a[0];
end;

function TVKCommonApi.MakeUri(): string;
var
  i: integer;
  s: string;
begin
  s := BaseURL;
  if (s <> '') and (s.Substring(s.length - 1) = '/') then
    s := s.Substring(0, s.length - 1);

  for i := 0 to RESTparams.Count - 1 do
    s := s + '/' + RESTparams[i];
  FURI.Create(s);

  for i := 0 to URIparams.Count - 1 do
    FURI.AddOrSetParamByName(URIparams.Names[i], URIparams.ValueFromIndex[i]);

  // if db<>'' then
  // FURI.AddOrSetParamByName('db',db);
  //
  // if (token<>'') then
  // FURI.AddOrSetParamByName(sToken,token);

  result := FURI.ToString;
end;

procedure TVKCommonApi.OnValidateServerCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
  Accepted := True;
end;

function TVKCommonApi.passHash(const pass: string): string;
begin
  result := THashMD5.GetHashString(THashMD5.GetHashString(pass + 'salt')
    + 'sugar');
end;

procedure TVKCommonApi.GetErrFromJson();
begin
  Err.Code := ResultJson['error.code'].AsInteger;
  Err.Msg := ResultJson['error.msg'].AsString;
end;

function TVKCommonApi.GetHeader(const Name: string; var Value: string): Boolean;
var
  i: integer;
begin
  for i := 0 to High(FHeaders) do
  begin
    if AnsiSameText(Name, FHeaders[i].Name) then
    begin
      Value := FHeaders[i].Value;
      exit(True);
    end;
  end;
  result := false;
end;

function TVKCommonApi.Request(const ARequestType: string;
  AResStream: TStream = nil): string;
var
  vResp: IHTTPResponse;
  vURL: string;
  attempt: integer;
  d: int64;
  httpReqTime: int64;
  timeStr: string;
begin
  if ResultJson <> NIL then
    ResultJson := nil;
  // предположим сначала плохое
  Err.Status := sERROR;
  Err.Msg := sMSG_ERR_GET_DATA;

  FResStream.Clear;
  result := '';
  Canceled := false;
  FIsArray := false;

  vURL := MakeUri();
  WriteLog(ARequestType + ' ' + vURL, 1);
  timeStr := 'Time.';
  attempt := 0;
  SetHeaders;
  FHttpMethod := ARequestType;
  repeat
    d := TThread.gettickcount;
    if attempt <= high(ResponseTimeouts) then
      HTTP.ResponseTimeout := ResponseTimeouts[attempt] * 1000;
    try
      if ARequestType = sHTTPMethodGet then
      begin
        vResp := HTTP.get(vURL, FResStream, FHeaders)
      end
      else if ARequestType = sHTTPMethodPost then
      begin
        FPostData.Position := 0;
        vResp := HTTP.Post(vURL, FPostData, FResStream, FHeaders);
      end
      else if ARequestType = sHTTPMethodPut then
      begin
        FPostData.Position := 0;
        vResp := HTTP.put(vURL, FPostData, FResStream, FHeaders);
      end
      else if ARequestType = sHTTPMethodDelete then
      begin
        FPostData.Position := 0;
        vResp := HTTP.Delete(vURL, FResStream, FHeaders);
      end
      else
        raise Exception.Create('Method is not supported.');

      FProtocolversion := vResp.Version;
      httpReqTime := TThread.gettickcount - d;
      timeStr := timeStr + ' HTTP:' + httpReqTime.ToString;
      Break;
    except
      on e: ENetHTTPClientException do
      begin
        WriteLog('HTTP error: ' + e.message, 1);
        if attempt >= length(AttemptIntervals) then
        begin
          if e.message.Contains(TVKCommonApi.ERR_NO_INTERNET.ToString) then
            Err.Code := ERR_NO_INTERNET
          else if e.message.Contains(TVKCommonApi.ERR_DNS_ERROR.ToString) then
            Err.Code := ERR_DNS_ERROR
          else
            Err.Code := 1;
          Err.Status := sERROR;
          Err.Msg := e.message; // sMSG_ERROR_NO_CONNECTION;
          exit;
        end
        else
        begin
          Sleep(AttemptIntervals[attempt]);
          inc(attempt);
          WriteLog('repeat: ' + attempt.ToString, 1);
        end;
      end;
      on e: Exception do
      begin
        WriteLog('common error: ' + e.message, 1);
        Err.Code := 1;
        Err.Status := sERROR;
        Err.Msg := e.message;
        Err.HttpCode := vResp.StatusCode;
        exit;
      end;
    end;
  until false;

  Err.Clear;

  // если vresp=nil то мы уже вышли по exception
  // Поэтому не проверяем
  // узнать, что сюда приходит, когда в OnReceiveData был Abort!
  if (not Canceled) then
  begin
    try
      if (vResp.MimeType.Contains('text') or vResp.MimeType.Contains('json'))
      then
        ResultString := unescapejson(vResp.ContentAsString());
    except
      on e: Exception do
      begin
        WriteLog('common error: ' + e.message, 1);
        Err.Code := 1;
        Err.Status := sERROR;
        Err.Msg := e.message;
        Err.HttpCode := vResp.StatusCode;
        exit;
      end;
    end;
    Err.HttpCode := vResp.StatusCode;
    if (vResp.StatusCode div 100 = 2) then
    begin
      Err.Status := sOK;
      Err.Msg := '';
    end
    else
    begin
      Err.HttpString := vResp.ContentAsString();
      Err.Code := vResp.StatusCode;
      Err.Status := sERROR;
      Err.Msg := 'HTTP status ' + vResp.StatusCode.ToString + ' : ' +
        vResp.StatusText;
    end;
    if (vResp.StatusCode div 200 <> 2) or
      (not vResp.MimeType.StartsWith('application/json')) then
      WriteLog('HTTP status: ' + vResp.StatusCode.ToString + ' response type: '
        + vResp.MimeType, 1);
    WriteLog(ResultString, 2);
    result := ResultString;

    if vResp.MimeType.StartsWith('application/json') then
    begin
      if MakeResultJson and (ResultString <> '') then
      begin
        try
          d := TThread.gettickcount;
          ResultJson := TSuperObject.Create(ResultString);
          timeStr := timeStr + ' JSON:' + (TThread.gettickcount - d).ToString;
          FIsArray := ResultString.StartsWith('[');
          if FIsArray then
          begin; // do nothing
          end
          else if ResultJson.Contains('time') then
          begin
            timeStr := timeStr + ' API:' + ResultJson['time.duration'].AsString
              + ' PDO:' + ResultJson['time.connect'].AsString + ' ' + vURL;
          end;
          GetErrFromJson();
          if Err.Code <> 0 then
          begin
            WriteLog('error: ' + Err.Code.ToString + ' ' + Err.Msg, 1);
          end;
        except
          on e: Exception do
          begin
            WriteLog('JSON parse error: ' + e.message, 1);
            WriteLog(ResultString, 1);
            Err.Code := -1;
            Err.Msg := e.message;
          end;
        end;
      end;
    end
    else if vResp.MimeType.StartsWith('text/html') then
    begin
      if vResp.ContentStream <> NIL then
        vResp.ContentStream.Position := 0;
      ResultString := vResp.ContentAsString();
      ResultString := ResultString.Trim([#$FEFF]);
      result := ResultString;
    end
    else
    begin
      if Assigned(AResStream) then
      begin
        WriteLog('content size: ' + FResStream.Size.ToString, 1);
        FResStream.Position := 0;
        AResStream.CopyFrom(FResStream, FResStream.Size); // size of source
      end;
    end;

  end
  else
  begin
    if Canceled then
    begin
      Err.Code := 499;
      Err.Status := sERROR;
      Err.Msg := sCanceledByUser;
      WriteLog('canceled by user', 1);
    end
    else
    begin
      Err.Code := vResp.StatusCode;
      Err.Status := sERROR;
      Err.Msg := vResp.StatusText;
      WriteLog('bad response status: ' + vResp.StatusCode.ToString + ' ' +
        vResp.StatusText, 1);
    end;
  end;
  WriteLog(timeStr, 1);
  WriteLog('', 1);
end;

procedure TVKCommonApi.ResetURL;
begin
  FURI := TURI.Create(BaseURL);
  FPostData.Clear;
end;

procedure TVKCommonApi.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
end;

procedure TVKCommonApi.SetOnReceiveData(const Value: TReceiveDataEvent);
begin
  HTTP.OnReceiveData := Value;
end;

procedure TVKCommonApi.SetupStreamForBinary(var AStream: TBytesStream);
begin
  FreeAndNil(AStream);
  AStream := TBytesStream.Create();
  AddHeader('Accept', '*/*', True);
end;

procedure TVKCommonApi.SetupStreamForText(var AStream: TBytesStream);
begin
  FreeAndNil(AStream);
  AStream := TStringStream.Create('', TEncoding.UTF8);
  AddHeader('Accept', 'application/json', True);
end;

{$IFDEF FGX}
{ TVKDownnloaderThread }

constructor TVKDownloaderThread<T>.Create(const AApi: T;
  const AURLPath, AFilename: string; const ATermProc: TNotifyEvent;
  const AProgressHandler: TReceiveDataEvent);
begin
  inherited Create(AApi, ATermProc);
  FUrlPath := AURLPath;
  FFilename := AFilename;

  FAPI.HTTP.OnReceiveData := AProgressHandler;
  FAPI.BaseURL := FUrlPath;
  FAPI.RESTparams.Add(FFilename);
end;

procedure TVKDownloaderThread<T>.Execute;
var
  st: TMemoryStream;
  OutputDir: JFile;
  path, filename: string;
begin
  st := TMemoryStream.Create;
  try
    OutputDir := TfgAndroidHelper.Context.getExternalCacheDir();
    path := JStringToString(OutputDir.getAbsolutePath);
    filename := path + '/' + FFilename;
    FAPI.Request(sHTTPMethodGet, st);
    st.Position := 0;
    st.SaveToFile(filename);
    FFileHash := THashMD5.GetHashStringFromFile(filename);
    FResultURI := TfgAndroidHelper.GetUriForFileName(filename);
  finally
    FreeAndNil(st);
  end;
end;

{$ENDIF}
{ TApiThread }

constructor TVKCommonApiThread<T>.Create(const AApi: T;
  const ATermProc: TNotifyEvent);
begin
  inherited Create(True);
  if AApi <> NIL then
    FAPI := T.Clone(AApi)
  else
    FAPI := T.Create();
  OnTerminate := ATermProc;
  FreeOnTerminate := True;
  NameThreadForDebugging(ClassName + ThreadID.ToString, ThreadID);
end;

destructor TVKCommonApiThread<T>.Destroy;
begin
  FreeAndNil(FAPI);
  inherited;
end;

class function TVKCommonApi.GetLogFilename: string;
var
  path: string;
begin
  path := tpath.GetDocumentsPath + tpath.DirectorySeparatorChar + GetLogFolder;
  ForceDirectories(path);
  result := path + tpath.DirectorySeparatorChar + 'log.txt';
end;

class function TVKCommonApi.GetLogFolder: string;
begin
  result := ClassName;
end;

class procedure TVKCommonApi.WriteLog(s: string; ALevel: integer = 1);
begin
  if ALevel > LogLevel then
    exit;

{$IFDEF FGX}
  FGX.Log.TfgLog.Debug('[' + LogTag + ']  ' + s);
{$ENDIF}
  if Assigned(FLog) then
  begin
    FCS.Enter;
    try
      FLog.Log('-- API -- ' + s);
    finally
      FCS.leave;
    end;
  end;
end;

{ THttpClientPool }

constructor THttpClientPool.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  CS := TCriticalSection.Create;
end;

destructor THttpClientPool.Destroy;
begin
  CS.Free;
  inherited Destroy;
end;

function THttpClientPool.get: THttpClient;
begin
  result := nil;

  if self = nil then
    exit;

  CS.Enter;
  try
    if Count = 0 then
    begin
      result := THttpClient.Create;
    end
    else
      result := Extract(Items[0]);
  finally
    CS.leave;
  end;

end;

procedure THttpClientPool.put(client: THttpClient);
begin
  if self = nil then
    exit;

  CS.Enter;
  try
    Add(client);
  finally
    CS.leave;
  end;
end;

function TErrRec.HasError: Boolean;
begin
  result := Code <> 0;
end;

function TErrRec.InternetUnavailableError: Boolean;
begin
  result := (Code = TVKCommonApi.ERR_NO_INTERNET) or
    (Code = TVKCommonApi.ERR_DNS_ERROR);
end;

initialization

TVKCommonApi.FCS := TCriticalSection.Create;
TVKCommonApi.LogLevel := 1;
TVKCommonApi.HttpClientPool := THttpClientPool.Create(True);

finalization

FreeAndNil(TVKCommonApi.FCS);
FreeAndNil(TVKCommonApi.HttpClientPool);

end.
