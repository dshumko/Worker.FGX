{*********************************************************************
 *
 * Copyright © 2020, Brovin Yaroslav
 * All rights reserved
 *
 * Autor: Brovin Y.D.
 * E-mail: y.brovin@gmail.com
 *
 ********************************************************************}

unit FGX.Map.iOS;

{$SCOPEDENUMS ON}

interface

uses
  System.Types,Classes, System.Generics.Collections, System.UITypes, Macapi.ObjectiveC, iOS.Api.MapKit, iOS.Api.ObjCRuntime,
  iOS.Api.CoreGraphics, iOS.Api.UIkit, iOS.Api.CoreLocation, FGX.Messaging, FGX.Controls.iOS, FGX.Controls, FGX.Map,
  FGX.Map.Types, FGX.Assets;

type
  IFGXMap = interface(MKMapView)
  ['{CF6F57AE-0ED8-47B9-892D-2EF3C889EC41}']
    { UIView }
    procedure layoutSubviews; cdecl;
  end;

  TfgiOSOverlays = class;
  TfgiOSMapDelegate = class;
  TfgiOSMapMarker = class;
  TfgiOSMapCircle = class;

  TfgiOSMap = class(TfgiOSControl<IFGXMap, TfgCustomMap>)
  private
    FDelegate: TfgiOSMapDelegate;
    FMarkers: TDictionary<id, TfgiOSMapMarker>;
    FOverlays: TfgiOSOverlays;
    procedure UpdateMapType;
    procedure UpdateCamera;
    procedure UpdateCameraLocation;
    procedure UpdateControlsSettings;
    procedure UpdateStandardLayerKinds;
    procedure UpdateUserGestureKinds;
    procedure UpdateMarkersCalloutButtonVisibility;
    procedure UpdateMarkerCalloutButtonVisibility(const AMarker: TfgiOSMapMarker);
    { Handler }
    procedure ShapeRecreatedHandler(const AOldShape: MKShape; const ANewShape: MKShape);
    procedure ShapeVisibleChangedHandler(const AObject: TfgMapObject);
    procedure ShapeZOrderChangedHandler(const AObject: TfgMapObject);
  protected
    procedure Resized; override;
    procedure DoMarkerDragStart(const AMarker: TfgMapMarker); virtual;
    procedure DoMarkerDragging(const AMarker: TfgMapMarker); virtual;
    procedure DoMarkerDragEnd(const AMarker: TfgMapMarker); virtual;
    procedure DoMarkerTap(const AMarker: TfgMapMarker); virtual;
    procedure DoInfoWindowTap(const AMarker: TfgMapMarker); virtual;

    { TfgMap }

    procedure WMMapTypeChanged(var AMessage: TfgMessage<TfgMapType>); message TfgMapMessages.WM_MAP_TYPE_CHANGED;
    procedure WMGoogleMapStyleChanged(var AMessage: TfgMessage<TfgMapType>); message TfgMapMessages.WM_GOOGLE_MAP_STYLE_CHANGED;
    procedure WMCameraLocationChanged(var AMessage: TfgMessage<TfgMapType>); message TfgMapMessages.WM_LOCATION_CHANGED;
    procedure WMCameraBearingChanged(var AMessage: TfgMessage<TfgMapType>); message TfgMapMessages.WM_BEARING_CHANGED;
    procedure WMCameraZoomChanged(var AMessage: TfgMessage<TfgMapType>); message TfgMapMessages.WM_ZOOM_CHANGED;
    procedure WMCameraTiltChanged(var AMessage: TfgMessage<TfgMapType>); message TfgMapMessages.WM_TILT_CHANGED;
    procedure WMAddMarker(var AMessage: TfgMessage<TfgAddMapMarkerInfo>); message TfgMapMessages.WM_ADD_MARKER;
    procedure WMRemoveMarker(var AMessage: TfgMessage<TfgMapMarker>); message TfgMapMessages.WM_REMOVE_MARKER;
    procedure WMAddPolyline(var AMessage: TfgMessage<TfgAddMapPolylineInfo>); message TfgMapMessages.WM_ADD_POLYLINE;
    procedure WMRemovePolyline(var AMessage: TfgMessage<TfgMapPolyline>); message TfgMapMessages.WM_REMOVE_POLYLINE;
    procedure WMAddPolygon(var AMessage: TfgMessage<TfgAddMapPolygonInfo>); message TfgMapMessages.WM_ADD_POLYGON;
    procedure WMRemovePolygon(var AMessage: TfgMessage<TfgMapPolygon>); message TfgMapMessages.WM_REMOVE_POLYGON;
    procedure WMAddCircle(var AMessage: TfgMessage<TfgAddMapCircleInfo>); message TfgMapMessages.WM_ADD_CIRCLE;
    procedure WMRemoveCircle(var AMessage: TfgMessage<TfgMapCircle>); message TfgMapMessages.WM_REMOVE_CIRCLE;
    procedure WMGetIsMapReady(var AMessage: TfgMessage<Boolean>); message TfgMapMessages.WM_GET_IS_MAP_READY;
    procedure WMControlsSettingsChanged(var AMessage: TfgMessage<TfgMapControlSettings>); message TfgMapMessages.WM_CONTROLS_SETTINGS_CHANGED;
    procedure WMPositionToCoordinate(var AMessage: TfgMessage<TfgMapCoordinateConversionInfo>); message TfgMapMessages.WM_POSITION_TO_COORDINATE;
    procedure WMCoordinateToPosition(var AMessage: TfgMessage<TfgMapCoordinateConversionInfo>); message TfgMapMessages.WM_COORDINATE_TO_POSITION;
    procedure WMStandardLayerKindsChanged(var AMessage: TfgMessage<TfgMapStandardLayerKinds>); message TfgMapMessages.WM_STANDARD_LAYER_KINDS_CHANGED;
    procedure WMUserGestureKindsChanged(var AMessage: TfgMessage<TfgMapUserGestureKinds>); message TfgMapMessages.WM_USER_GESTURE_KINDS_CHANGED;
    procedure WMSetOnInfoWindowTapEvent(var AMessage: TfgMessage<TfgMapMarkerEvent>); message TfgMapMessages.WM_SET_ON_INFO_WINDOW_TAP_EVENT;

    { TfgControl }

    procedure WMLoaded(var AMessage: TfgMessage); message TfgControlMessages.WM_LOADED;
  public
    constructor Create(const AControl: TfgControl); override;
    destructor Destroy; override;

    property Markers: TDictionary<id, TfgiOSMapMarker> read FMarkers;
    property Overlays: TfgiOSOverlays read FOverlays;
  end;

  /// <summary>Отвечает за отображение оверлеев, сортировку, управление видимостью.</summary>
  TfgiOSOverlays = class
  private
    FMapView: MKMapView;
    FVisibleOverlays: TList<TfgMapObject>;
    FInvisibleOverlays: TList<TfgMapObject>;
    FIndecies: TDictionary<id, TfgMapObject>;
  public
    constructor Create(const AMapView: MKMapView);
    destructor Destroy; override;

    procedure Add(const AMapObject: TfgMapObject);
    procedure Remove(const AMapObject: TfgMapObject);
    procedure Update(const AOldOverlayId, ANewOverlayId: id);
    function GetObjectOrRaise(const AOverlayId: id): TfgMapObject;
    function GetShapeOrRaise(const AMapObject: TfgMapObject): MKShape;

    { Visibility }
    procedure Show(const AMapObject: TfgMapObject);
    procedure Hide(const AMapObject: TfgMapObject);

    procedure UpdateZOrderFor(const AMapObject: TfgMapObject);

    property MapView: MKMapView read FMapView;
  end;

  MKMapViewDelegate = interface(IObjectiveC)
  ['{BA2BE4B4-0B9F-4B66-BB69-DD8B9F58BB2F}']
    { Responding to Map Position Changes }
    [MethodName('mapView:regionDidChangeAnimated:')]
    procedure mapViewRegionDidChangeAnimated(mapView: MKMapView; animated: Boolean); cdecl;
    procedure mapViewDidChangeVisibleRegion(mapView: MKMapView); cdecl;

    { Managing Annotation Views }
    [MethodName('mapView:viewForAnnotation:')]
    function mapViewViewForAnnotation(mapView: MKMapView; annotation: Pointer): MKAnnotationView; cdecl;
    [MethodName('mapView:annotationView:calloutAccessoryControlTapped:')]
    procedure mapViewAnnotationView(mapView: MKMapView; view: MKAnnotationView; control: UIControl); overload; cdecl;

    { Managing the Display of Overlays }
    [MethodName('mapView:rendererForOverlay:')]
    function mapViewRendererForOverlay(mapView: MKMapView; overlay: Pointer): MKOverlayRenderer; cdecl;

    { Dragging an Annotation View }
    [MethodName('mapView:annotationView:didChangeDragState:fromOldState:')]
    procedure mapViewAnnotationView(mapView: MKMapView; view: MKAnnotationView; newState: MKAnnotationViewDragState; oldState: MKAnnotationViewDragState); overload; cdecl;

    { Selecting Annotation Views }
    [MethodName('mapView:didSelectAnnotationView:')]
    procedure mapViewDidSelectAnnotationView(mapView: MKMapView; view: MKAnnotationView); cdecl;
    [MethodName('mapView:didDeselectAnnotationView:')]
    procedure mapViewDidDeselectAnnotationView(mapView: MKMapView; view: MKAnnotationView); cdecl;
  end;

  TfgiOSMapDelegate = class(TfgiOSListener<TfgiOSMap>, MKMapViewDelegate)
  protected
    procedure RefreshCameraParameters;
    function GetMarkerOrRaise(const AAnnotation: id): TfgiOSMapMarker;
    function GetShapeOrRaise(const AOverlay: id): TfgMapObject;
  public
    { Responding to Map Position Changes }
    [MethodName('mapView:regionDidChangeAnimated:')]
    procedure mapViewRegionDidChangeAnimated(mapView: MKMapView; animated: Boolean); cdecl;
    procedure mapViewDidChangeVisibleRegion(mapView: MKMapView); cdecl;

    { Managing Annotation Views }
    [MethodName('mapView:viewForAnnotation:')]
    function mapViewViewForAnnotation(mapView: MKMapView; annotation: Pointer): MKAnnotationView; cdecl;
    [MethodName('mapView:annotationView:calloutAccessoryControlTapped:')]
    procedure mapViewAnnotationView(mapView: MKMapView; view: MKAnnotationView; control: UIControl); overload; cdecl;

    { Managing the Display of Overlays }
    [MethodName('mapView:rendererForOverlay:')]
    function mapViewRendererForOverlay(mapView: MKMapView; overlay: Pointer): MKOverlayRenderer; cdecl;

    { Dragging an Annotation View }
    [MethodName('mapView:annotationView:didChangeDragState:fromOldState:')]
    procedure mapViewAnnotationView(mapView: MKMapView; view: MKAnnotationView; newState: MKAnnotationViewDragState; oldState: MKAnnotationViewDragState); overload; cdecl;

    { Selecting Annotation Views }
    [MethodName('mapView:didSelectAnnotationView:')]
    procedure mapViewDidSelectAnnotationView(mapView: MKMapView; view: MKAnnotationView); cdecl;
    [MethodName('mapView:didDeselectAnnotationView:')]
    procedure mapViewDidDeselectAnnotationView(mapView: MKMapView; view: MKAnnotationView); cdecl;
  end;

{ TfgiOSMapMarker }

  TfgiOSMapMarker = class(TfgMapMarker)
  public
    class var FDefaultPinMarker: MKPinAnnotationView;
    class constructor Create;
    class destructor Destroy;
  private
    FMapView: MKMapView;
    FAnnotation: MKPointAnnotation;
    FAnnotationView: MKAnnotationView;
    FCalloutButton: UIButton;
    FAnchor: TPointF;
    FZIndex: Single;
    FRotation: Single;
    FAppearance: TfgMarkerAppearance;
    procedure UpdateImageAnchor;
  protected
    { TfgMapObject }
    function GetIsVisible: Boolean; override;
    procedure SetIsVisible(const Value: Boolean); override;
    function GetZIndex: Single; override;
    procedure SetZIndex(const Value: Single); override;
    { TfgMapMarker }
    function GetIsDraggable: Boolean; override;
    function GetOpacity: Single; override;
    function GetPosition: TfgMapCoordinate; override;
    function GetRotation: Single; override;
    function GetSnippet: string; override;
    function GetTitle: string; override;
    function GetAnchor: TPointF; override;
    function GetAppearance: TfgMarkerAppearance; override;
    function GetIsInfoWindowVisible: Boolean; override;
    procedure SetIsDraggable(const Value: Boolean); override;
    procedure SetOpacity(const Value: Single); override;
    procedure SetPosition(const Value: TfgMapCoordinate); override;
    procedure SetRotation(const Value: Single); override;
    procedure SetSnippet(const Value: string); override;
    procedure SetTitle(const Value: string); override;
    procedure SetAnchor(const Value: TPointF); override;
    procedure SetAppearance(const Value: TfgMarkerAppearance); override;
    procedure SetIsInfoWindowVisible(const Value: Boolean); override;
    procedure IconChanged(const AAsset: TfgAsset); override;
    procedure UpdateIcon;
  public
    constructor Create(const AMapView: MKMapView; const AId: string; const AOptions: TfgMapMarkerOptions);
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure InstallCalloutButton;
    procedure UninstallCalloutButton;

    property Annotation: MKPointAnnotation read FAnnotation;
    property AnnotationView: MKAnnotationView read FAnnotationView;
    property CalloutButton: UIButton read FCalloutButton;
    property MapView: MKMapView read FMapView;
  end;

{ TfgiOSMapCircle }

  TfgiOSMapObjectEvent = procedure (const AObject: TfgMapObject) of object;
  TfgiOSRecreateShapeEvent = procedure (const AOldShape: MKShape; const ANewShape: MKShape) of object;

  TfgiOSMapCircle = class(TfgMapCircle)
  private
    FMapView: MKMapView;
    FCircle: MKCircle;
    FRenderer: MKCircleRenderer;
    FRadius: Single;
    FCenter: TfgMapCoordinate;
    FZIndex: Single;
    FVisible: Boolean;
    FIsClickable: Boolean;
    FOnRecreateShape: TfgiOSRecreateShapeEvent;
    FOnZIndexChanged: TfgiOSMapObjectEvent;
    FOnVisibleChanged: TfgiOSMapObjectEvent;
  protected
    procedure RecreateCircle;
    procedure UpdateBrushParameters;
    procedure DoZIndexChanged;
    procedure DoVisibleChanged;
    { TfgMapObject }
    function GetIsVisible: Boolean; override;
    procedure SetIsVisible(const Value: Boolean); override;
    function GetZIndex: Single; override;
    procedure SetZIndex(const Value: Single); override;
    { TfgMapClickableObject }
    function GetIsClickable: Boolean; override;
    procedure SetIsClickable(const Value: Boolean); override;
    { TfgMapCircle }
    function CreateNativeMapStroke: TfgMapStroke; override;
    function GetCenter: TfgMapCoordinate; override;
    function GetRadius: Double; override;
    function GetNativeFillColor: TAlphaColor; override;
    procedure SetCenter(const Value: TfgMapCoordinate); override;
    procedure SetRadius(const Value: Double); override;
    procedure SetNativeFillColor(const Value: TAlphaColor); override;
  public
    constructor Create(const AMapView: MKMapView; const AId: string; const AOptions: TfgMapCircleOptions);
    destructor Destroy; override;
    procedure AfterConstruction; override;

    property Circle: MKCircle read FCircle;
    property Renderer: MKCircleRenderer read FRenderer;
    property OnRecreateShape: TfgiOSRecreateShapeEvent read FOnRecreateShape write FOnRecreateShape;
    property OnVisibleChanged: TfgiOSMapObjectEvent read FOnVisibleChanged write FOnVisibleChanged;
    property OnZIndexChanged: TfgiOSMapObjectEvent read FOnZIndexChanged write FOnZIndexChanged;
  end;

{ Stroke }

  TfgiOSMapStroke = class(TfgMapStroke)
  private
    FRenderer: MKOverlayPathRenderer;
  protected
    function GetWidth: Single; override;
    function GetNativeColor: TAlphaColor; override;
    procedure SetWidth(const Value: Single); override;
    procedure SetNativeColor(const Value: TAlphaColor); override;
  public
    constructor Create(const AOwner: TfgMapObject; const ARenderer: MKOverlayPathRenderer);
  end;

implementation

uses
  System.SysUtils, System.Math, System.Generics.Defaults, iOS.Api.Foundation, iOS.Api.Helpers, FGX.Controls.Factory,
  FGX.Asserts, FGX.Assets.iOS, FGX.Types.Color;

type
  TfgMapCoordinateHelper = record helper for TfgMapCoordinate
    function ToCLLocationCoordinate2D: CLLocationCoordinate2D;
  end;

  TfgMapTypeHelper = record helper for TfgMapType
    function ToMKMapType: MKMapType;
  end;

{ TfgMapCoordinateHelper }

function TfgMapCoordinateHelper.ToCLLocationCoordinate2D: CLLocationCoordinate2D;
begin
  Result.latitude := Latitude;
  Result.longitude := Longitude;
end;

{ TfgMapTypeHelper }

function TfgMapTypeHelper.ToMKMapType: MKMapType;
begin
  case Self of
    TfgMapType.Normal:
      Result := MKMapTypeStandard;
    TfgMapType.Satellite:
      Result := MKMapTypeSatellite;
    TfgMapType.Terrain:
      Result := MKMapTypeStandard;
    TfgMapType.Hybrid:
      Result := MKMapTypeHybrid;
  else
    raise EfgAssertError.CreateFmt(SUnknownValue, ['TfgMapType']);
  end;
end;

type
  TfgComparerByOverlayZIndex = class(TComparer<TfgMapObject>)
  public
    function Compare(const ALeft, ARight: TfgMapObject): Integer; override;
  end;

{ TfgComparerByOverlayZIndex }

function TfgComparerByOverlayZIndex.Compare(const ALeft, ARight: TfgMapObject): Integer;
begin
  Result := CompareValue(ALeft.ZIndex, ARight.ZIndex);
end;

{ TfgiOSMap }

constructor TfgiOSMap.Create(const AControl: TfgControl);
begin
  inherited;
  FDelegate := TfgiOSMapDelegate.Create(Self);
  View.setDelegate(FDelegate.GetObjectID);
  FMarkers := TDictionary<id, TfgiOSMapMarker>.Create;
  FOverlays := TfgiOSOverlays.Create(View);
end;

destructor TfgiOSMap.Destroy;
begin
  FreeAndNil(FOverlays);
  FreeAndNil(FMarkers);
  View.setDelegate(nil);
  FreeAndNil(FDelegate);
  inherited;
end;

procedure TfgiOSMap.DoInfoWindowTap(const AMarker: TfgMapMarker);
begin
  TfgAssert.IsNotNil(AMarker, 'AMarker');

  if Assigned(Control.OnInfoWindowTap) then
    Control.OnInfoWindowTap(Control, AMarker);
end;

procedure TfgiOSMap.DoMarkerDragEnd(const AMarker: TfgMapMarker);
begin
  TfgAssert.IsNotNil(AMarker, 'AMarker');

  if Assigned(Control.OnMarkerDragEnd) then
    Control.OnMarkerDragEnd(Control, AMarker);
end;

procedure TfgiOSMap.DoMarkerDragging(const AMarker: TfgMapMarker);
begin
  TfgAssert.IsNotNil(AMarker, 'AMarker');

  if Assigned(Control.OnMarkerDrag) then
    Control.OnMarkerDrag(Control, AMarker);
end;

procedure TfgiOSMap.DoMarkerDragStart(const AMarker: TfgMapMarker);
begin
  TfgAssert.IsNotNil(AMarker, 'AMarker');

  if Assigned(Control.OnMarkerDragStart) then
    Control.OnMarkerDragStart(Control, AMarker);
end;

procedure TfgiOSMap.DoMarkerTap(const AMarker: TfgMapMarker);
begin
  TfgAssert.IsNotNil(AMarker, 'AMarker');

  if Assigned(Control.OnMarkerTap) then
    Control.OnMarkerTap(Control, AMarker);
end;

procedure TfgiOSMap.Resized;
begin
  inherited;
  UpdateCamera;
end;

procedure TfgiOSMap.ShapeRecreatedHandler(const AOldShape, ANewShape: MKShape);
begin
  TfgAssert.IsNotNil(AOldShape, 'AOldShape');
  TfgAssert.IsNotNil(ANewShape, 'ANewShape');
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  FOverlays.Update(NSObjectToID(AOldShape), NSObjectToID(ANewShape));
end;

procedure TfgiOSMap.ShapeVisibleChangedHandler(const AObject: TfgMapObject);
begin
  TfgAssert.IsNotNil(AObject, 'AObject');
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  if AObject.IsVisible then
    FOverlays.Show(AObject)
  else
    FOverlays.Hide(AObject);
end;

procedure TfgiOSMap.ShapeZOrderChangedHandler(const AObject: TfgMapObject);
begin
  TfgAssert.IsNotNil(AObject, 'AObject');
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  FOverlays.UpdateZOrderFor(AObject);
end;

procedure TfgiOSMap.UpdateCamera;

  function CalculateCameraRect: MKMapRect;
  var
    W, H: Double;
    Center: MKMapPoint;
  begin
    Center := MKMapPointForCoordinate(Control.CameraTarget.ToCLLocationCoordinate2D);
    W := 2 * View.bounds.width * Power(2, 20 - Control.CameraZoom);
    H := 2 * View.bounds.height * Power(2, 20 - Control.CameraZoom);
    Result.origin.x := Center.x - W / 2;
    Result.origin.y := Center.y - H / 2;
    Result.size.width := W;
    Result.size.height := H;
  end;

begin
  TfgAssert.IsNotNil(Control, 'Control');
  TfgAssert.IsNotNil(View, 'View');

  View.camera.setPitch(Control.CameraTilt);
  View.camera.setHeading(Control.CameraBearing);
  // Zoom задается неявно через видимый прямоугольник
  View.setVisibleMapRect(CalculateCameraRect, True);
end;

procedure TfgiOSMap.UpdateCameraLocation;
begin
  TfgAssert.IsNotNil(Control, 'Control');
  TfgAssert.IsNotNil(View, 'View');

  View.setCenterCoordinate(Control.CameraTarget.ToCLLocationCoordinate2D, True);
end;

procedure TfgiOSMap.UpdateControlsSettings;
begin
  TfgAssert.IsNotNil(Control, 'Control');
  TfgAssert.IsNotNil(View, 'View');

  View.setShowsCompass(TfgMapControlSetting.Compass in Control.ControlsSettings);
  View.setZoomEnabled(TfgMapControlSetting.Zoom in Control.ControlsSettings);
  View.setShowsUserLocation(TfgMapControlSetting.MyLocation in Control.ControlsSettings);
end;

procedure TfgiOSMap.UpdateMapType;
begin
  TfgAssert.IsNotNil(Control, 'Control');
  TfgAssert.IsNotNil(View, 'View');

  View.setMapType(Control.MapType.ToMKMapType);
end;

procedure TfgiOSMap.UpdateMarkerCalloutButtonVisibility(const AMarker: TfgiOSMapMarker);
begin
  TfgAssert.IsNotNil(AMarker, 'AMarker');

  if Assigned(Control.OnInfoWindowTap) then
    AMarker.InstallCalloutButton
  else
    AMarker.UninstallCalloutButton;
end;

procedure TfgiOSMap.UpdateMarkersCalloutButtonVisibility;
var
  Marker: TfgMapMarker;
begin
  for Marker in Control.Markers do
    UpdateMarkerCalloutButtonVisibility(Marker as TfgiOSMapMarker);
end;

procedure TfgiOSMap.UpdateStandardLayerKinds;
var
  Layers: TfgMapStandardLayerKinds;
begin
  TfgAssert.IsNotNil(Control, 'Control');
  TfgAssert.IsNotNil(View, 'View');

  Layers := Control.StandardLayerKinds;
  View.setShowsTraffic(TfgMapStandardLayerKind.Traffic in Layers);
  View.setShowsBuildings(TfgMapStandardLayerKind.Buildings in Layers);
end;

procedure TfgiOSMap.UpdateUserGestureKinds;
var
  Gestures: TfgMapUserGestureKinds;
begin
  TfgAssert.IsNotNil(Control, 'Control');
  TfgAssert.IsNotNil(View, 'View');

  Gestures := Control.UserGestureKinds;
  View.setRotateEnabled(TfgMapUserGestureKind.Rotate in Gestures);
  View.setScrollEnabled(TfgMapUserGestureKind.Scroll in Gestures);
  View.setZoomEnabled(TfgMapUserGestureKind.Zoom in Gestures);
end;

procedure TfgiOSMap.WMAddCircle(var AMessage: TfgMessage<TfgAddMapCircleInfo>);
var
  Circle: TfgiOSMapCircle;
begin
  TfgAssert.IsNotNil(View, 'View');
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  Circle := TfgiOSMapCircle.Create(View, AMessage.Value.Id, AMessage.Value.Options);
  Circle.OnRecreateShape := ShapeRecreatedHandler;
  Circle.OnVisibleChanged := ShapeVisibleChangedHandler;
  Circle.OnZIndexChanged := ShapeZOrderChangedHandler;
  FOverlays.Add(Circle);
  AMessage.Value.MapObject := Circle;
end;

procedure TfgiOSMap.WMAddMarker(var AMessage: TfgMessage<TfgAddMapMarkerInfo>);
var
  Marker: TfgiOSMapMarker;
begin
  TfgAssert.IsNotNil(View, 'View');
  TfgAssert.IsNotNil(FMarkers, 'FMarkers');

  Marker := TfgiOSMapMarker.Create(View, AMessage.Value.Id, AMessage.Value.Options);
  UpdateMarkerCalloutButtonVisibility(Marker);
  FMarkers.Add(NSObjectToId(Marker.Annotation), Marker);
  AMessage.Value.MapObject := Marker;
  View.addAnnotation(NSObjectToId(Marker.Annotation));
end;

procedure TfgiOSMap.WMAddPolygon(var AMessage: TfgMessage<TfgAddMapPolygonInfo>);
begin

end;

procedure TfgiOSMap.WMAddPolyline(var AMessage: TfgMessage<TfgAddMapPolylineInfo>);
begin

end;

procedure TfgiOSMap.WMCameraBearingChanged(var AMessage: TfgMessage<TfgMapType>);
begin
  UpdateCamera;
end;

procedure TfgiOSMap.WMCameraLocationChanged(var AMessage: TfgMessage<TfgMapType>);
begin
  UpdateCameraLocation;
end;

procedure TfgiOSMap.WMCameraTiltChanged(var AMessage: TfgMessage<TfgMapType>);
begin
  UpdateCamera;
end;

procedure TfgiOSMap.WMCameraZoomChanged(var AMessage: TfgMessage<TfgMapType>);
begin
  UpdateCamera;
end;

procedure TfgiOSMap.WMControlsSettingsChanged(var AMessage: TfgMessage<TfgMapControlSettings>);
begin
  UpdateControlsSettings;
end;

procedure TfgiOSMap.WMCoordinateToPosition(var AMessage: TfgMessage<TfgMapCoordinateConversionInfo>);
var
  Coordinate: CLLocationCoordinate2D;
begin
  Coordinate := AMessage.Value.Coordinate.ToCLLocationCoordinate2D;
  AMessage.Value.Position := View.convertCoordinate(Coordinate, View).ToPointF;
end;

procedure TfgiOSMap.WMGetIsMapReady(var AMessage: TfgMessage<Boolean>);
begin
  AMessage.Value := True;
end;

procedure TfgiOSMap.WMGoogleMapStyleChanged(var AMessage: TfgMessage<TfgMapType>);
begin
  // Не актуально для iOS. Только для Google Maps.
end;

procedure TfgiOSMap.WMLoaded(var AMessage: TfgMessage);
begin
  inherited;
  UpdateMapType;
  UpdateControlsSettings;
  UpdateStandardLayerKinds;
  UpdateUserGestureKinds;
  UpdateCameraLocation;
  // Карта доступна для работы сразу. Поэтому вызываем это событие после полной загрузки всех настроек компонента.
  if Assigned(Control.OnMapReady) then
    Control.OnMapReady(Owner);
end;

procedure TfgiOSMap.WMMapTypeChanged(var AMessage: TfgMessage<TfgMapType>);
begin
  UpdateMapType;
end;

procedure TfgiOSMap.WMPositionToCoordinate(var AMessage: TfgMessage<TfgMapCoordinateConversionInfo>);
var
  Position: CGPoint;
  Coordinate: CLLocationCoordinate2D;
begin
  Position := AMessage.Value.Position;
  Coordinate := View.convertPoint(Position, View);
  AMessage.Value.Coordinate := TfgMapCoordinate.Create(Coordinate.latitude, Coordinate.longitude);
end;

procedure TfgiOSMap.WMRemoveCircle(var AMessage: TfgMessage<TfgMapCircle>);
begin
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  FOverlays.Remove(AMessage.Value);
end;

procedure TfgiOSMap.WMRemoveMarker(var AMessage: TfgMessage<TfgMapMarker>);
var
  Annotation: MKPointAnnotation;
begin
  TfgAssert.IsClass(AMessage.Value, TfgiOSMapMarker);

  Annotation := TfgiOSMapMarker(AMessage.Value).Annotation;
  FMarkers.Remove(NSObjectToId(Annotation));
  View.removeAnnotation(NSObjectToId(Annotation));
end;

procedure TfgiOSMap.WMRemovePolygon(var AMessage: TfgMessage<TfgMapPolygon>);
begin
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  FOverlays.Remove(AMessage.Value);
end;

procedure TfgiOSMap.WMRemovePolyline(var AMessage: TfgMessage<TfgMapPolyline>);
begin
  TfgAssert.IsNotNil(FOverlays, 'FOverlays');

  FOverlays.Remove(AMessage.Value);
end;

procedure TfgiOSMap.WMSetOnInfoWindowTapEvent(var AMessage: TfgMessage<TfgMapMarkerEvent>);
begin
  UpdateMarkersCalloutButtonVisibility;
end;

procedure TfgiOSMap.WMStandardLayerKindsChanged(var AMessage: TfgMessage<TfgMapStandardLayerKinds>);
begin
  UpdateStandardLayerKinds;
end;

procedure TfgiOSMap.WMUserGestureKindsChanged(var AMessage: TfgMessage<TfgMapUserGestureKinds>);
begin
  UpdateUserGestureKinds;
end;

{ TfgiOSMapDelegate }

function TfgiOSMapDelegate.GetMarkerOrRaise(const AAnnotation: id): TfgiOSMapMarker;
begin
  if not NativeControl.FMarkers.TryGetValue(AAnnotation, Result) then
    raise EfgAssertError.Create('Cannot find marker for id');
end;

function TfgiOSMapDelegate.GetShapeOrRaise(const AOverlay: id): TfgMapObject;
begin
  Result := NativeControl.Overlays.GetObjectOrRaise(AOverlay);
end;

procedure TfgiOSMapDelegate.mapViewAnnotationView(mapView: MKMapView; view: MKAnnotationView; newState,
  oldState: MKAnnotationViewDragState);
var
  Marker: TfgiOSMapMarker;
begin
  Marker := GetMarkerOrRaise(view.annotation);

  case newState of
    MKAnnotationViewDragStateStarting:
      NativeControl.DoMarkerDragStart(Marker);

    MKAnnotationViewDragStateDragging:
      NativeControl.DoMarkerDragging(Marker);

    MKAnnotationViewDragStateCanceling,
    MKAnnotationViewDragStateEnding:
      NativeControl.DoMarkerDragEnd(Marker);
  end;
end;

procedure TfgiOSMapDelegate.mapViewAnnotationView(mapView: MKMapView; view: MKAnnotationView; control: UIControl);
var
  Marker: TfgiOSMapMarker;
begin
  Marker := GetMarkerOrRaise(view.annotation);
  NativeControl.DoInfoWindowTap(Marker);
end;

procedure TfgiOSMapDelegate.mapViewDidChangeVisibleRegion(mapView: MKMapView);
var
  Map: TfgCustomMap;
begin
  RefreshCameraParameters;
  Map := NativeControl.Control;
  if Assigned(Map.OnCameraChanging) then
    Map.OnCameraChanging(Map);
end;

procedure TfgiOSMapDelegate.mapViewDidDeselectAnnotationView(mapView: MKMapView; view: MKAnnotationView);
var
  Marker: TfgiOSMapMarker;
begin
  Marker := GetMarkerOrRaise(view.annotation);
  NativeControl.DoMarkerTap(Marker);
end;

procedure TfgiOSMapDelegate.mapViewDidSelectAnnotationView(mapView: MKMapView; view: MKAnnotationView);
var
  Marker: TfgiOSMapMarker;
begin
  Marker := GetMarkerOrRaise(view.annotation);
  if Assigned(NativeControl.Control.OnInfoWindowTap) then
    Marker.InstallCalloutButton
  else
    Marker.UninstallCalloutButton;;
  NativeControl.DoMarkerTap(Marker);
end;

procedure TfgiOSMapDelegate.mapViewRegionDidChangeAnimated(mapView: MKMapView; animated: Boolean);
var
  Map: TfgCustomMap;
begin
  RefreshCameraParameters;
  Map := NativeControl.Control;
  if Assigned(Map.OnCameraChanged) then
    Map.OnCameraChanged(Map);
end;

function TfgiOSMapDelegate.mapViewRendererForOverlay(mapView: MKMapView; overlay: Pointer): MKOverlayRenderer;
var
  Shape: TfgMapObject;
begin
  Shape := GetShapeOrRaise(overlay);
  if Shape is TfgiOSMapCircle then
    Result := TfgiOSMapCircle(Shape).Renderer
  else
    TfgAssert.Fail('Unknown wshape type');
end;

function TfgiOSMapDelegate.mapViewViewForAnnotation(mapView: MKMapView; annotation: Pointer): MKAnnotationView;
var
  Marker: TfgiOSMapMarker;
begin
  Marker := GetMarkerOrRaise(annotation);
  Result := Marker.AnnotationView;
end;

procedure TfgiOSMapDelegate.RefreshCameraParameters;

  function GetCameraZoom: Single;
  const
    TileSize = 256;
    FullCircleDegrees = 360;
  begin
    Result := Log2(FullCircleDegrees * ((NativeControl.View.frame.size.width / TileSize) / NativeControl.View.region.span.longitudeDelta)) + 1;
  end;

  function CanCalculateZoom: Boolean;
  begin
    Result := not IsZero(NativeControl.View.frame.size.width) and not IsZero(NativeControl.View.region.span.longitudeDelta);
  end;

var
  Map: TfgCustomMap;
  CameraTarget: CLLocationCoordinate2D;
  MapView: MKMapView;
begin
  Map := NativeControl.Control;

  Map.Handle.DisableNotify;
  try
    MapView := NativeControl.View;
    CameraTarget := MapView.centerCoordinate;

    Map.CameraTarget := TfgMapCoordinate.Create(CameraTarget.latitude, CameraTarget.longitude);
    Map.CameraTilt := MapView.camera.pitch;
    Map.CameraBearing := MapView.camera.heading;
    if CanCalculateZoom then
      Map.CameraZoom := GetCameraZoom;
  finally
    Map.Handle.EnableNotify;
  end;
end;

{ TfgiOSMapMarker }

procedure TfgiOSMapMarker.AfterConstruction;
begin
  inherited;
  UpdateIcon;
end;

constructor TfgiOSMapMarker.Create(const AMapView: MKMapView; const AId: string; const AOptions: TfgMapMarkerOptions);
begin
  TfgAssert.IsNotNil(AMapView, 'AMapView');

  inherited Create(AId);
  FMapView := AMapView;
  FAnnotation := TMKPointAnnotation.Create;
  FAnnotationView := TMKAnnotationView.Wrap(TMKAnnotationView.Alloc.initWithAnnotation(NSObjectToId(FAnnotation), nil));
  FAnnotationView.setUserInteractionEnabled(True);
  FAnnotationView.setEnabled(True);
  FAnnotationView.setCanShowCallout(True);
  IsVisible := AOptions.IsVisible;
  ZIndex := AOptions.ZIndex;
  Position := AOptions.Position;
  Title := AOptions.Title;
  Snippet := AOptions.Snippet;
  Opacity := AOptions.Opacity;
  IsDraggable := AOptions.IsDraggable;
  Appearance := AOptions.Appearance;
  IconName := AOptions.IconName;
  Anchor := AOptions.Anchor;
  Rotation := AOptions.Rotation;
end;

class constructor TfgiOSMapMarker.Create;
var
  Annotation: MKPointAnnotation;
begin
  Annotation := TMKPointAnnotation.Create;
  FDefaultPinMarker := TMKPinAnnotationView.Wrap(TMKPinAnnotationView.Alloc.initWithAnnotation(NSObjectToId(Annotation), nil));
end;

class destructor TfgiOSMapMarker.Destroy;
begin
  FDefaultPinMarker := nil;
end;

destructor TfgiOSMapMarker.Destroy;
begin
  FAnnotationView.release;
  inherited;
end;

function TfgiOSMapMarker.GetAnchor: TPointF;
begin
  Result := FAnchor;
end;

function TfgiOSMapMarker.GetAppearance: TfgMarkerAppearance;
begin
  Result := FAppearance;
end;

function TfgiOSMapMarker.GetIsDraggable: Boolean;
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  Result := FAnnotationView.isDraggable;
end;

function TfgiOSMapMarker.GetIsInfoWindowVisible: Boolean;
begin
  TfgAssert.IsNotNil(Annotation, 'Annotation');
  TfgAssert.IsNotNil(FMapView, 'FMapView');

  Result := FMapView.selectedAnnotations.containsObject(NSObjectToID(Annotation));
end;

function TfgiOSMapMarker.GetIsVisible: Boolean;
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  Result := not FAnnotationView.isHidden;
end;

function TfgiOSMapMarker.GetOpacity: Single;
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  Result := FAnnotationView.alpha;
end;

function TfgiOSMapMarker.GetPosition: TfgMapCoordinate;
var
  Coordinate: CLLocationCoordinate2D;
begin
  TfgAssert.IsNotNil(FAnnotation, 'FAnnotation');

  Coordinate := FAnnotation.coordinate;
  Result := TfgMapCoordinate.Create(Coordinate.latitude, Coordinate.longitude);
end;

function TfgiOSMapMarker.GetRotation: Single;
begin
  Result := FRotation;
end;

function TfgiOSMapMarker.GetSnippet: string;
begin
  TfgAssert.IsNotNil(FAnnotation, 'FAnnotation');

  Result := NSStrToStr(FAnnotation.subtitle);
end;

function TfgiOSMapMarker.GetTitle: string;
begin
  TfgAssert.IsNotNil(FAnnotation, 'FAnnotation');

  Result := NSStrToStr(FAnnotation.title);
end;

function TfgiOSMapMarker.GetZIndex: Single;
begin
  Result := FZIndex;
end;

procedure TfgiOSMapMarker.IconChanged(const AAsset: TfgAsset);
begin
  UpdateIcon;
end;

procedure TfgiOSMapMarker.InstallCalloutButton;
begin
  if FAnnotationView.rightCalloutAccessoryView = nil then
  begin
    FCalloutButton := TUIButton.Wrap(TUIButton.OCClass.buttonWithType(UIButtonTypeDetailDisclosure));
    FAnnotationView.setRightCalloutAccessoryView(FCalloutButton);
  end;
end;

procedure TfgiOSMapMarker.SetAnchor(const Value: TPointF);
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  FAnchor := Value;
  UpdateImageAnchor;
end;

procedure TfgiOSMapMarker.SetAppearance(const Value: TfgMarkerAppearance);
begin
  FAppearance := Value;
end;

procedure TfgiOSMapMarker.SetIsDraggable(const Value: Boolean);
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  FAnnotationView.setDraggable(Value);
end;

procedure TfgiOSMapMarker.SetIsInfoWindowVisible(const Value: Boolean);
begin
  TfgAssert.IsNotNil(FMapView, 'FMapView');
  TfgAssert.IsNotNil(Annotation, 'Annotation');

  FMapView.selectAnnotation(NSObjectToID(Annotation), True);
end;

procedure TfgiOSMapMarker.SetIsVisible(const Value: Boolean);
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  FAnnotationView.setHidden(not Value);
end;

procedure TfgiOSMapMarker.SetOpacity(const Value: Single);
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  FAnnotationView.setAlpha(Value);
end;

procedure TfgiOSMapMarker.SetPosition(const Value: TfgMapCoordinate);
begin
  TfgAssert.IsNotNil(FAnnotation, 'FAnnotation');

  FAnnotation.setCoordinate(Value.ToCLLocationCoordinate2D);
end;

procedure TfgiOSMapMarker.SetRotation(const Value: Single);
var
  Transformation: CGAffineTransform;
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  FRotation := Value;
  Transformation := CGAffineTransformMakeRotation(Value * Pi / 180);
  FAnnotationView.setTransform(Transformation);
end;

procedure TfgiOSMapMarker.SetSnippet(const Value: string);
begin
  TfgAssert.IsNotNil(FAnnotation, 'FAnnotation');

  FAnnotation.setSubtitle(StrToNSStr(Value));
end;

procedure TfgiOSMapMarker.SetTitle(const Value: string);
begin
  TfgAssert.IsNotNil(FAnnotation, 'FAnnotation');

  FAnnotation.setTitle(StrToNSStr(Value));
end;

procedure TfgiOSMapMarker.SetZIndex(const Value: Single);
begin
  // MKAnnotationView не дает свойства z-order, однако это вьюшка, поэтому з-порядок задается на основании индекса вьюшки.
  // При этом  MKMapView автоматически перетаскивает маркер поверх остальных при нажатии на него.
  // Поэтому управление z-order сильно затрудняется.
  FZIndex := Value;
end;

procedure TfgiOSMapMarker.UninstallCalloutButton;
begin
  FAnnotationView.setRightCalloutAccessoryView(nil);
end;

procedure TfgiOSMapMarker.UpdateIcon;
var
  Image: UIImage;
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  Image := AssetToUIImage(IconLink.Asset);
  if Image = nil then
    Image := FDefaultPinMarker.image;
  FAnnotationView.setImage(Image);
  // В iOS точка привязки картинки задается в абсолютных координатах. Поэтому она зависит от размера иконки.
  UpdateImageAnchor;
end;

procedure TfgiOSMapMarker.UpdateImageAnchor;
var
  ImageSize: CGSize;
  Offset: CGPoint;
  CalloutOffset: CGPoint;
begin
  TfgAssert.IsNotNil(FAnnotationView, 'FAnnotationView');

  if IconLink.HasAsset and (FAnnotationView.image <> nil) then
  begin
    ImageSize := FAnnotationView.image.size;
    // iOS привязка идет относительно центральной точки изображения
    Offset := CGPoint.Create(ImageSize.width * (0.5 - FAnchor.x), ImageSize.Height * (0.5 - FAnchor.y));
    CalloutOffset := CGPoint.Create(0, 0);
  end
  else
  begin
    Offset := FDefaultPinMarker.centerOffset;
    // По неизвестным причинам окно с информацией немного смещено относительно булавки. Поэтому во всех примерах
    // в интернете добавляют это смещение для коррекции отображения.
    CalloutOffset := CGPoint.Create(-5, -5);
  end;

  FAnnotationView.setCenterOffset(Offset);
  FAnnotationView.setCalloutOffset(CalloutOffset);
end;

{ TfgiOSMapCircle }

procedure TfgiOSMapCircle.AfterConstruction;
begin
  inherited;
  UpdateBrushParameters;
end;

constructor TfgiOSMapCircle.Create(const AMapView: MKMapView; const AId: string; const AOptions: TfgMapCircleOptions);
begin
  // Наследуемый конструктор создает кисть, для которой нам нужно знать FCircleView. Именно по этому мы вначале создаем
  // нужные объекты до inherited.
  FCircle := TMKCircle.OCClass.circleWithCenterCoordinate(AOptions.Center.ToCLLocationCoordinate2D, AOptions.Radius);
  FRenderer := TMKCircleRenderer.Wrap(TMKCircleRenderer.Alloc.initWithCircle(FCircle));
  inherited Create(AId);

  FMapView := AMapView;
  FVisible := True;
  IsVisible := AOptions.IsVisible;
  ZIndex := AOptions.ZIndex;
  IsClickable := AOptions.IsClickable;
  FillColorName := AOptions.FillColorName;
  FillColor := AOptions.FillColor;
  Stroke.Width := AOptions.Stroke.Width;
  Stroke.ColorName := AOptions.Stroke.ColorName;
  Stroke.Color := AOptions.Stroke.Color;
end;

function TfgiOSMapCircle.CreateNativeMapStroke: TfgMapStroke;
begin
  Result := TfgiOSMapStroke.Create(Self, FRenderer);
end;

destructor TfgiOSMapCircle.Destroy;
begin

  inherited;
end;

procedure TfgiOSMapCircle.DoVisibleChanged;
begin
  if Assigned(FOnVisibleChanged) then
    FOnVisibleChanged(Self);
end;

procedure TfgiOSMapCircle.DoZIndexChanged;
begin
  if Assigned(FOnZIndexChanged) then
    FOnZIndexChanged(Self);
end;

function TfgiOSMapCircle.GetCenter: TfgMapCoordinate;
begin
  Result := FCenter;
end;

function TfgiOSMapCircle.GetIsClickable: Boolean;
begin
  Result := FIsClickable;
end;

function TfgiOSMapCircle.GetIsVisible: Boolean;
begin
  Result := FVisible;
end;

function TfgiOSMapCircle.GetNativeFillColor: TAlphaColor;
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  Result := TAlphaColor.Create(FRenderer.fillColor);
end;

function TfgiOSMapCircle.GetRadius: Double;
begin
  Result := FRadius;
end;

function TfgiOSMapCircle.GetZIndex: Single;
begin
  Result := FZIndex;
end;

procedure TfgiOSMapCircle.RecreateCircle;
var
  NewCircle: MKCircle;
begin
  NewCircle := TMKCircle.OCClass.circleWithCenterCoordinate(Center.ToCLLocationCoordinate2D, Radius);
  try
    if Assigned(OnRecreateShape) then
      OnRecreateShape(FCircle, NewCircle);
  finally
    FCircle := NewCircle;
  end;
end;

procedure TfgiOSMapCircle.SetCenter(const Value: TfgMapCoordinate);
begin
  inherited;
  if Center <> Value then
  begin
    FCenter := Value;
    RecreateCircle;
  end;
end;

procedure TfgiOSMapCircle.SetIsClickable(const Value: Boolean);
begin
  // Не поддерживается
  FIsClickable := Value;
end;

procedure TfgiOSMapCircle.SetIsVisible(const Value: Boolean);
begin
  TfgAssert.IsNotNil(FMapView, 'FMapView');

  if FVisible <> Value then
  begin
    FVisible := Value;
    DoVisibleChanged;
  end;
end;

procedure TfgiOSMapCircle.SetNativeFillColor(const Value: TAlphaColor);
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  FRenderer.setFillColor(Value.ToUIColor);
end;

procedure TfgiOSMapCircle.SetRadius(const Value: Double);
begin
  inherited;
  if not SameValue(FRadius, Value, Single.Epsilon) then
  begin
    FRadius := Value;
    RecreateCircle;
  end;
end;

procedure TfgiOSMapCircle.SetZIndex(const Value: Single);
begin
  if FZIndex <> Value then
  begin
    FZIndex := Value;
    DoZIndexChanged;
  end;
end;

procedure TfgiOSMapCircle.UpdateBrushParameters;
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  FRenderer.setFillColor(FillColorLink.Color.ToUIColor);
  FRenderer.setStrokeColor(Stroke.ColorLink.Color.ToUIColor);
  FRenderer.setLineWidth(Stroke.Width);
end;

{ TfgiOSMapStroke }

constructor TfgiOSMapStroke.Create(const AOwner: TfgMapObject; const ARenderer: MKOverlayPathRenderer);
begin
  TfgAssert.IsNotNil(AOwner, 'AOwner');
  TfgAssert.IsNotNil(ARenderer, 'ARenderer');

  inherited Create(AOwner);
  FRenderer := ARenderer;
end;

function TfgiOSMapStroke.GetNativeColor: TAlphaColor;
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  Result := TAlphaColor.Create(FRenderer.strokeColor);
end;

function TfgiOSMapStroke.GetWidth: Single;
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  Result := FRenderer.lineWidth;
end;

procedure TfgiOSMapStroke.SetNativeColor(const Value: TAlphaColor);
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  FRenderer.setStrokeColor(Value.ToUIColor);
end;

procedure TfgiOSMapStroke.SetWidth(const Value: Single);
begin
  TfgAssert.IsNotNil(FRenderer, 'FRenderer');

  FRenderer.setLineWidth(Value);
end;

{ TfgiOSOverlays }

procedure TfgiOSOverlays.Add(const AMapObject: TfgMapObject);
var
  Shape: MKShape;
begin
  TfgAssert.IsNotNil(AMapObject, 'AMapObject');
  TfgAssert.IsNotNil(FIndecies, 'FIndecies');
  TfgAssert.IsNotNil(FVisibleOverlays, 'FVisibleOverlays');
  TfgAssert.IsNotNil(FInvisibleOverlays, 'FInvisibleOverlays');

  // Добавляем в индекс
  Shape := GetShapeOrRaise(AMapObject);
  FIndecies.Add(NSObjectToId(Shape), AMapObject);

  // Формируем списки видимых/невидимых оверлев
  if AMapObject.IsVisible then
    FVisibleOverlays.Add(AMapObject)
  else
    FInvisibleOverlays.Add(AMapObject);

  // Добавляем на карту
  if AMapObject.IsVisible then
  begin
    FMapView.addOverlay(NSObjectToId(Shape));
    UpdateZOrderFor(AMapObject);
  end;
  if IsZero(AMapObject.ZIndex) then
    AMapObject.ZIndex := FIndecies.Count - 1;
end;

constructor TfgiOSOverlays.Create(const AMapView: MKMapView);
begin
  TfgAssert.IsNotNil(AMapView, 'AMapView');

  FMapView := AMapView;
  FVisibleOverlays := TList<TfgMapObject>.Create(TfgComparerByOverlayZIndex.Create);
  FInvisibleOverlays := TList<TfgMapObject>.Create; // У оверлеев нету возможности скрытия. поэтому скрытие реализуется через удаление
  FIndecies := TDictionary<id, TfgMapObject>.Create;
end;

destructor TfgiOSOverlays.Destroy;
begin
  FreeAndNil(FIndecies);
  FreeAndNil(FInvisibleOverlays);
  FreeAndNil(FVisibleOverlays);
end;

function TfgiOSOverlays.GetObjectOrRaise(const AOverlayId: id): TfgMapObject;
begin
  if not FIndecies.TryGetValue(AOverlayId, Result) then
    raise EfgAssertError.Create('Cannot find map object for overlay id');
end;

function TfgiOSOverlays.GetShapeOrRaise(const AMapObject: TfgMapObject): MKShape;
begin
  TfgAssert.IsNotNil(AMapObject, 'AMapObject');

  { TODO : По хороему, надо сделать через интерфейс. }
  if AMapObject is TfgiOSMapCircle then
    Result := TfgiOSMapCircle(AMapObject).Circle
  else
    raise Exception.Create('Unknown AObject class type');
end;

procedure TfgiOSOverlays.Hide(const AMapObject: TfgMapObject);
begin
  TfgAssert.IsNotNil(AMapObject, 'AMapObject');
  TfgAssert.IsNotNil(FVisibleOverlays, 'FVisibleOverlays');
  TfgAssert.IsNotNil(FInvisibleOverlays, 'FInvisibleOverlays');

  FVisibleOverlays.Remove(AMapObject);
  if not FInvisibleOverlays.Contains(AMapObject) then
    FInvisibleOverlays.Add(AMapObject);
end;

procedure TfgiOSOverlays.Remove(const AMapObject: TfgMapObject);
var
  ShapeId: id;
begin
  TfgAssert.IsNotNil(FIndecies, 'FIndecies');
  TfgAssert.IsNotNil(FVisibleOverlays, 'FVisibleOverlays');
  TfgAssert.IsNotNil(FInvisibleOverlays, 'FInvisibleOverlays');
  TfgAssert.IsNotNil(AMapObject, 'AMapObject');

  if FVisibleOverlays.Remove(AMapObject) = -1 then
    FInvisibleOverlays.Remove(AMapObject); // не удалось удалить из одного списка, удаляем из другого

  ShapeId := NSObjectToId(GetShapeOrRaise(AMapObject));
  FIndecies.Remove(ShapeId);
  FMapView.removeOverlay(ShapeId);
end;

procedure TfgiOSOverlays.Show(const AMapObject: TfgMapObject);
begin
  TfgAssert.IsNotNil(AMapObject, 'AMapObject');
  TfgAssert.IsNotNil(FVisibleOverlays, 'FVisibleOverlays');
  TfgAssert.IsNotNil(FInvisibleOverlays, 'FInvisibleOverlays');

  FInvisibleOverlays.Remove(AMapObject);
  if not FVisibleOverlays.Contains(AMapObject) then
    FVisibleOverlays.Add(AMapObject);
  UpdateZOrderFor(AMapObject);
end;

procedure TfgiOSOverlays.Update(const AOldOverlayId, ANewOverlayId: id);
var
  MapObject: TfgMapObject;
begin
  TfgAssert.IsNotNil(AOldOverlayId, 'AOldOverlayId');
  TfgAssert.IsNotNil(ANewOverlayId, 'ANewOverlayId');

  MapObject := FIndecies[AOldOverlayId];
  FIndecies.Remove(AOldOverlayId);
  FIndecies.Add(ANewOverlayId, MapObject);
end;

procedure TfgiOSOverlays.UpdateZOrderFor(const AMapObject: TfgMapObject);
var
  NewIndex: Integer;
  OverlayId: id;
begin
  TfgAssert.IsNotNil(AMapObject, 'AMapObject');

  OverlayId := NSObjectToID(GetShapeOrRaise(AMapObject));
  FMapView.removeOverlay(OverlayId);
  if not AMapObject.IsVisible then
    Exit;

  FVisibleOverlays.Sort;

  // Обновление позиции объекта делаем через повторную вставку в нужную позицию.
  NewIndex := FVisibleOverlays.IndexOf(AMapObject);
  FMapView.insertOverlayAtIndex(OverlayId, NewIndex);
end;

initialization
  TfgNativeControlFactory.Register(TfgMap,
  function (const AControl: TComponent): TfgNativeControlHandle
var
  NativeView: TfgiOSControl;
begin
  NativeView := TfgiOSMap.Create(AControl as TfgControl);
  Result := TfgiOSControlHandle.Create(NativeView);
end);
//  TfgiOSControl.CreateHandle<TfgiOSMap>);
finalization
  TfgNativeControlFactory.Unregister(TfgMap);
end.
