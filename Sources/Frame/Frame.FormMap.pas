unit Frame.FormMap;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseForm, FGX.NavigationBar.Types, FGX.StaticLabel,
  FGX.ActivityIndicator, FGX.NavigationBar, FGX.Map.Types, FGX.Map,
  FGX.Map.MarkerManager,
  ServiceUnit.mwClasses, Base.BaseApiForm, FGX.Button.Types, FGX.Button,
  FGX.Map.TileProvider;

type
  TmwFormMap = class(TmwBaseApiForm)
    mapMain: TfgMap;
    procedure mapMainMapReady(Sender: TObject);
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure mapMainInfoWindowTap(Sender: TObject; const AMarker: TfgMapMarker);
    procedure fgFormShow(Sender: TObject);
    procedure mapMainMarkerTap(Sender: TObject; const AMarker: TfgMapMarker);
    procedure mapMainCameraChanged(Sender: TObject);
    procedure nbFormTap(Sender: TObject);
  private
    { Private declarations }
    FCurrentLat, FCurrentLon: double;
    FCurrentZoom: Integer;
    FMarkerManager: TfgMapMarkerManager;
    FObjectsJsonStr: string;
    procedure GotoLocation(const aLat, aLon: double);
  public
    procedure SetParams(Values: array of Variant); override;
    procedure DrawMarker(const aLat, aLon: double; const aTitle, aHint, aIcon: string); overload;
    procedure DrawMarker(const json: string); overload;
    procedure DrawMarkers(const json: string);
  end;

  TmwFormMapClass = class of TmwFormMap;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Threading,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Permissions, FGX.Toasts,
{$IFDEF IOS}iOS.Api.CoreLocation, {$ENDIF}
  Form.Main, Frame.FormBidInfo,
  XSuperObject;

procedure TmwFormMap.DrawMarker(const aLat, aLon: double; const aTitle, aHint, aIcon: string);
var
  O: TjsObject2d;
  mc: TfgMapCoordinate;
begin
  mc := TfgMapCoordinate.Create(aLat, aLon);
  O := FMarkerManager.AddObject(Point2d(mc.Latitude, mc.Longitude), true);
  O.Tag := 0;
  O.Title := aTitle;
  O.Hint := aHint;
  O.IconName := aIcon;
end;

procedure TmwFormMap.DrawMarker(const json: string);
var
  marker: TmwMapMarker;
  O: TjsObject2d;
  mc: TfgMapCoordinate;
begin
  marker := TmwMapMarker.CreateFromJSON(json);
  mc := TfgMapCoordinate.Create(marker.lat, marker.lon);
  O := FMarkerManager.AddObject(Point2d(mc.Latitude, mc.Longitude), true);
  O.Tag := 0;
  O.Title := marker.Title;
  O.IconName := marker.icon;
end;

procedure TmwFormMap.DrawMarkers(const json: string);
var
  markerList: ISuperArray;
  I: Integer;
begin
  markerList := TSuperArray.Create(json);
  for I := 0 to markerList.Length - 1 do
  begin
    DrawMarker(markerList.AsArray.O[I].F['lat'], markerList.AsArray.O[I].F['lon'], markerList.AsArray.O[I].S['title'],
      markerList.AsArray.O[I].S['hint'], markerList.AsArray.O[I].S['icon']);
  end;
end;

procedure TmwFormMap.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentZoom := 11;
  FMarkerManager := TfgMapMarkerManager.Create;
  FMarkerManager.CacheZoom := 14;
  FMarkerManager.Map := mapMain;
  FMarkerManager.ActiveTag := 0;
end;

procedure TmwFormMap.fgFormDestroy(Sender: TObject);
begin
  FMarkerManager.Free;
  inherited;
end;

procedure TmwFormMap.fgFormShow(Sender: TObject);
{$IFDEF ANDROID}
const
  AccessCoarseLocationPermission = 'android.permission.ACCESS_COARSE_LOCATION';
  FineLocationPermission = 'android.permission.ACCESS_FINE_LOCATION';
{$ENDIF}
begin
{$IFDEF ANDROID}
  TfgPermissionService.RequestPermissionsAsync([AccessCoarseLocationPermission, FineLocationPermission],
    procedure(const APermissionsInfos: TArray<TfgPermissionInfo>)
    var
      PermissionInfo: TfgPermissionInfo;
      granted: boolean;
    begin
      granted := true;
      for PermissionInfo in APermissionsInfos do
        if PermissionInfo.CheckResult = TPermissionCheckResult.Denied then
          granted := false;
      if granted then
      begin
        mapMain.ControlsSettings := mapMain.ControlsSettings + [TfgMapControlSetting.MyLocation];
      end
      else
      begin
        TfgToastFactory.Show
          ('Необходимо разрешение на использование местоположения. Работа приложения может быть нарушена.');
      end;
    end);
{$ENDIF}
{$IFDEF IOS}
  TCLLocationManager.Create.requestWhenInUseAuthorization;
  mapMain.ControlsSettings := mapMain.ControlsSettings + [TfgMapControlSetting.MyLocation];
{$ENDIF}
end;

procedure TmwFormMap.GotoLocation(const aLat, aLon: double);
var
  currentCoordinates: TfgMapCoordinate;
begin
  if (aLat > 0) and (aLon > 0) then
  begin
    currentCoordinates.Create(aLat, aLon);
    mapMain.CameraTarget := currentCoordinates;
    mapMain.CameraZoom := FCurrentZoom;
  end;
end;

procedure TmwFormMap.mapMainCameraChanged(Sender: TObject);
begin
  inherited;
  if FMarkerManager <> nil then
    FMarkerManager.DrawObjects;
end;

procedure TmwFormMap.mapMainInfoWindowTap(Sender: TObject; const AMarker: TfgMapMarker);
begin
  inherited;
  CloseMe(Self, true);
  FormMain.RunFrame(TmwFormBidInfo, [AMarker.Title.ToInteger], 'Заявка', AMarker.Title);
  FormMain.AddToStack(TmwFormMap, Name, [mapMain.CameraTarget.Latitude, mapMain.CameraTarget.Longitude,
    mapMain.CameraZoom, FObjectsJsonStr], 'Карта', 'Заявки');
end;

procedure TmwFormMap.mapMainMapReady(Sender: TObject);
begin
  if (FCurrentLat = 0) and (FCurrentLon = 0) then
  begin
    FCurrentLat := FormMain.CurrentLat;
    FCurrentLon := FormMain.CurrentLon;
  end;
  GotoLocation(FCurrentLat, FCurrentLon);
  if not FObjectsJsonStr.IsEmpty then
  begin
    DrawMarkers(FObjectsJsonStr);
  end;
end;

procedure TmwFormMap.mapMainMarkerTap(Sender: TObject; const AMarker: TfgMapMarker);
begin
  inherited;
  if AMarker.Title = '' then
    TTask.Run(
      procedure
      begin
        Sleep(100);
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            mapMain.CameraZoom := mapMain.CameraZoom + 1;
            mapMain.CameraTarget := AMarker.Position;
          end)
      end);
end;

procedure TmwFormMap.nbFormTap(Sender: TObject);
begin
  inherited;
  FormMain.pnDrawer.Open(true);
end;

procedure TmwFormMap.SetParams(Values: array of Variant);
begin
  inherited;
  if Length(Values) > 1 then
  begin
    FCurrentLat := Values[0];
    FCurrentLon := Values[1];
  end;
  if Length(Values) > 2 then
    FCurrentZoom := Values[2];
  if Length(Values) > 3 then
  begin
    FObjectsJsonStr := Values[3];
  end;
end;

end.
