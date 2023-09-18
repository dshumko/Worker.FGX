unit FGX.Map.MarkerManager;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Threading, FGX.Map.Types,
  System.Generics.Collections, FGX.Map, FGX.Canvas;

const
  MaxZoom = 20;
  CacheWidth = 128;

type
  TRealType = Double;

  TPoint2d = record
    X, Y: TRealType;
  end;

  TRect2D = record
    case Byte of
      0:
        (Left, Bottom, Right, Top: TRealType);
      1:
        (FirstEdge, SecondEdge: TPoint2d);
  end;

type
  TfgMapMarkerManager = class;
  TjsObject2d = class;

  TCacheRecord = class
    Position: TPoint2d;
    Count: Integer;
    NumX, NumY: Integer;
    FirstObject: TjsObject2d;
    FMapMarker: TfgMapMarker;
    FObjects: TObjectList<TjsObject2d>;
    MarkersCount: Integer;
    FManager: TfgMapMarkerManager;
    constructor create(AManager: TfgMapMarkerManager);
    destructor Destroy; override;
    procedure ClearMarkers;

  end;

  TjsObject2d = class
  private
    FOwner: TfgMap;
    FCached: boolean;
    FMapMarker: TfgMapMarker;
    FCenter2d: TPoint2d;
    FHint: String;
    FVisible: boolean;
    FTag: NativeInt;
    FIconName: String;
    FTitle: String;
    FCategory: String;
    FEnabled: boolean;
    procedure SetMapMarker(const Value: TfgMapMarker);
    procedure SetCenter2d(const Value: TPoint2d);
    procedure RecreateMarker;
    procedure SetHint(const Value: String);
    procedure SetVisible(const Value: boolean);
    procedure SetTag(const Value: NativeInt);
    procedure SetIconName(const Value: String);
    procedure SetTitle(const Value: String);
    procedure SetCached(const Value: boolean);
    procedure SetCategory(const Value: String);
    procedure SetEnabled(const Value: boolean);

  public
    constructor create(AOwner: TfgMap);
    destructor Destroy; override;
    property Category: String read FCategory write SetCategory;
    property MapMarker: TfgMapMarker read FMapMarker write SetMapMarker;
    property Center2d: TPoint2d read FCenter2d write SetCenter2d;
    property IconName: String read FIconName write SetIconName;
    property Hint: String read FHint write SetHint;
    property Title: String read FTitle write SetTitle;
    property Visible: boolean read FVisible write SetVisible;
    property Cached: boolean read FCached write SetCached;
    property Enabled: boolean read FEnabled write SetEnabled;
    property Tag: NativeInt read FTag write SetTag;
  end;

  TfgMapMarkerManager = class
  private
    FMap: TfgMap;
    FCachedArray: array [1 .. MaxZoom]
      of TObjectDictionary<string, TCacheRecord>;
    FCacheZoom: Integer;
    FActiveTag: Integer;
    FCurrentZoom: Integer;
    FObjects: TObjectList<TjsObject2d>;
    FBitmaps: TObjectDictionary<String, TfgBitmap>;
    procedure ClearCache(N: Integer);
    procedure AddCachedMarker(Cr: TCacheRecord);
    procedure RebuildObjectCache(S: TjsObject2d);
    procedure SetCacheZoom(const Value: Integer);
    procedure SetActiveTag(const Value: Integer);
    function GetVisualRect: TRect2D;
  public

    property Map: TfgMap read FMap write FMap;
    property ActiveTag: Integer read FActiveTag write SetActiveTag;
    property CacheZoom: Integer read FCacheZoom write SetCacheZoom;
    property CurrentZoom: Integer read FCurrentZoom;
    procedure Clear;
    procedure DrawObjects;
    function AddObject(P: TPoint2d; ACached: boolean): TjsObject2d;
    function DeleteObject(ATag: Integer): boolean;
    constructor create;
    destructor Destroy; override;
  end;

function Point2d(X, Y: TRealType): TPoint2d;

implementation

uses
  System.SysUtils, System.StrUtils, System.IOUtils, FGX.Assets,
  FGX.Assets.Helpers, FGX.Assets.BitmapSet,
  uCoord{$IFDEF ANDROID}, Android.Api.PlayServices.Maps, FGX.Map.Android,
  FGX.Controls.Android, FGX.Helpers.Android
{$ELSE}, FGX.Canvas.Ios, Ios.Api.UIKit, Ios.Api.CoreLocation,
  Ios.Api.ObjCRuntime, Ios.Api.Foundation, Ios.Api.MapKit, FGX.Map.Ios,
  FGX.Controls.Ios, FGX.Helpers.Ios{$ENDIF};

type
  TOutPos = (Left, Bottom, Right, Top, neareye, fareye);
  TOutCode = set of TOutPos;

function ScreenScale: Double;
begin
{$IFDEF ANDROID}
  Result := TfgAndroidHelper.ScreenScale;
{$ELSE}
  Result := 1;
{$ENDIF}
end;

function Rect2D(const Left, Bottom, Right, Top: TRealType): TRect2D;
begin
  Result.Left := Left;
  Result.Right := Right;
  Result.Bottom := Bottom;
  Result.Top := Top;
end;

function ReOrderRect2D(const R: TRect2D): TRect2D;
begin
  Result := R;
  if R.Left > R.Right then
  begin
    Result.Left := R.Right;
    Result.Right := R.Left;
  end;
  if R.Bottom > R.Top then
  begin
    Result.Bottom := R.Top;
    Result.Top := R.Bottom;
  end;
end;

function _PositionCode2D(const Clip: TRect2D; const P: TPoint2d): TOutCode;
var
  R: TRect2D;
begin
  R := ReOrderRect2D(Clip);
  Result := [];
  if P.X < R.Left then
    Result := [TOutPos.Left]
  else if P.X > R.Right then
    Result := [TOutPos.Right];
  if P.Y < R.Bottom then
    Result := Result + [TOutPos.Bottom]
  else if P.Y > R.Top then
    Result := Result + [TOutPos.Top];
end;

function IsBoxInBox2D(Box1, Box2: TRect2D): boolean;
var
  FCode, SCode: TOutCode;
begin
  Box1 := ReOrderRect2D(Box1);
  Box2 := ReOrderRect2D(Box2);
  FCode := _PositionCode2D(Box2, Box1.FirstEdge);
  SCode := _PositionCode2D(Box2, Box1.SecondEdge);
  Result := (FCode * SCode) = [];
end;

function Point2d(X, Y: TRealType): TPoint2d;
begin
  Result.X := X;
  Result.Y := Y;
end;
{ TjsObject2d }

constructor TjsObject2d.create(AOwner: TfgMap);
begin
  inherited create;
  FOwner := AOwner;
end;

destructor TjsObject2d.Destroy;
begin
  Visible := False;
  inherited;
end;

procedure TjsObject2d.RecreateMarker;
var
  mc: TfgMapCoordinate;
  O: TfgMapMarkerOptions;

begin
  if FVisible then
  begin
    mc := TfgMapCoordinate.create(FCenter2d.X, FCenter2d.Y);
    O := TfgMapMarkerOptions.Default;
    O.Title := FTitle;
    O.IconName := IconName;
    O.Snippet := Hint;
    O.Position := mc;
    O.IsDraggable := FEnabled;
    if FMapMarker = nil then
      MapMarker := FOwner.Markers.AddMarker(O);
    MapMarker.Tag := FTag;
    MapMarker.Category := Category;
  end;

end;

procedure TjsObject2d.SetCached(const Value: boolean);
begin
  FCached := Value;
end;

procedure TjsObject2d.SetCategory(const Value: String);
begin
  FCategory := Value;
end;

procedure TjsObject2d.SetCenter2d(const Value: TPoint2d);
begin
  FCenter2d := Value;
end;

procedure TjsObject2d.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TjsObject2d.SetHint(const Value: String);
begin
  FHint := Value;

end;

procedure TjsObject2d.SetIconName(const Value: String);
begin
  FIconName := Value;
end;

procedure TjsObject2d.SetMapMarker(const Value: TfgMapMarker);
begin
  FMapMarker := Value;
end;

procedure TjsObject2d.SetTag(const Value: NativeInt);
begin
  FTag := Value;
end;

procedure TjsObject2d.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

procedure TjsObject2d.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FVisible then
      RecreateMarker
    else if FMapMarker <> nil then
    begin
      if FOwner.Markers.FindObjectById(FMapMarker.Id, FMapMarker) then
        FOwner.Markers.RemoveObject(FMapMarker);
      FMapMarker := nil;
    end;
  end;
end;

{ TCacheRecord }

procedure TCacheRecord.ClearMarkers;
var
  i: Integer;
begin
  if (MarkersCount <> 0) then
  begin
    if Assigned(FManager.Map) then
      FManager.Map.Markers.ClearObjectsInCategory(IntToStr(NumX) + '_' +
        IntToStr(NumY));

    for i := 0 to FObjects.Count - 1 do
    begin
      FObjects[i].FMapMarker := nil;
    end;
    MarkersCount := 0;
  end;
end;

constructor TCacheRecord.create(AManager: TfgMapMarkerManager);
begin
  FManager := AManager;
  FObjects := TObjectList<TjsObject2d>.create;
  FObjects.OwnsObjects := True;
end;

destructor TCacheRecord.Destroy;
begin
  FObjects.Clear;
  if FManager.Map <> nil then
  begin
    FManager.Map.Markers.ClearObjectsInCategory(IntToStr(NumX) + '_' +
      IntToStr(NumY));
    if FMapMarker <> nil then
      FManager.Map.Markers.RemoveObject(FMapMarker);
  end;
  inherited;
end;

procedure TfgMapMarkerManager.AddCachedMarker(Cr: TCacheRecord);
var
  B: TfgBitmap;

  Bitmaps: TfgAssetBitmapSet;
  Bms: TfgBitmap;
  O: TfgMapMarkerOptions;
  IName: String;

begin
  IName := 'markers\' + IntToStr(Cr.Count);
  if Cr.Count = 1 then
  begin
    O := TfgMapMarkerOptions.Default;
    O.IconName := Cr.FirstObject.IconName;
    O.Position := TfgMapCoordinate.create(Cr.Position.X, Cr.Position.Y);
    O.Title := Cr.FirstObject.Title;
    O.Snippet := Cr.FirstObject.Hint;
    O.Anchor := TPointF.create(0.5, 0.5);
    Cr.FMapMarker := FMap.Markers.AddMarker(O);
  end
  else
  begin
    if not TfgAssetsManager.Current.Contains(IName) then
    begin
      if Cr.Count < 100 then
        TfgAssetsManager.Current.Find<TfgAssetBitmapSet>('m1', Bitmaps)
      else if Cr.Count < 1000 then
        TfgAssetsManager.Current.Find<TfgAssetBitmapSet>('m2', Bitmaps)
      else if Cr.Count < 10000 then
        TfgAssetsManager.Current.Find<TfgAssetBitmapSet>('m3', Bitmaps)

      else if Cr.Count < 100000 then
        TfgAssetsManager.Current.Find<TfgAssetBitmapSet>('m4', Bitmaps)
      else
        TfgAssetsManager.Current.Find<TfgAssetBitmapSet>('m5', Bitmaps);

      B := TfgBitmap.create;
      Bms := Bitmaps.GetBitmap;
      B.Size := TSize.create(Round(Bms.Size.cx * ScreenScale),
        Round(Bms.Size.cy * ScreenScale));
      B.Canvas.BeginPaint;
      try
        B.Canvas.DrawBitmap(Bms, B.Bounds);
        if Cr.Count < 100 then
          B.Canvas.Fill.Color := TAlphaColorRec.White
        else if Cr.Count < 1000 then
          B.Canvas.Fill.Color := TAlphaColorRec.Blue
        else
          B.Canvas.Fill.Color := TAlphaColorRec.White;
        B.Canvas.Font.Size := B.Size.cx / 5;
        B.Canvas.FillText(TRectF.create(0, 0, B.Size.cx, B.Size.cy),
          IntToStr(Cr.Count), False);
      finally
        B.Canvas.EndPaint;
      end;
      if TOSVersion.Platform = TOSVersion.TPlatform.pfiOS then
        FBitmaps.Add(IName, TfgBitmap.CreateFromBitmap(B));
      TfgAssetsManager.Current.AddBitmap(IName, B);
    end;
    O := TfgMapMarkerOptions.Default;
    O.IconName := IName;
    // O.Title:=IName;
    O.Position := TfgMapCoordinate.create(Cr.Position.X, Cr.Position.Y);
    O.Anchor := TPointF.create(0.5, 0.5);
    Cr.FMapMarker := FMap.Markers.AddMarker(O);
{$IFDEF IOS}
    if FBitmaps.TryGetValue(IName, B) then
    begin
      TfgiOSMapMarker(Cr.FMapMarker).AnnotationView.setImage
        (BitmapToUIImage(B));
    end;
{$ENDIF}
  end

end;

function TfgMapMarkerManager.AddObject(P: TPoint2d; ACached: boolean)
  : TjsObject2d;
begin
  Result := TjsObject2d.create(FMap);
  Result.FCached := ACached;
  Result.FCenter2d := P;
  if ACached then
    RebuildObjectCache(Result)
  else
    FObjects.Add(Result);
end;

procedure TfgMapMarkerManager.Clear;
var
  i: Integer;
begin

  if (FMap <> nil) then
  begin
    FMap.BeginUpdate;
  end;
  try
    FObjects.Clear;
    for i := 1 to CacheZoom do
      ClearCache(i);
    FMap.Markers.ClearObjects;
  finally
    if (FMap <> nil) then
    begin
      FMap.EndUpdate;
    end;

  end;

end;

procedure TfgMapMarkerManager.ClearCache(N: Integer);
begin
  FCachedArray[N].Clear
end;

procedure TfgMapMarkerManager.RebuildObjectCache(S: TjsObject2d);
var
  NumX, NumY: Integer;
  Z: Integer;
  L: TObjectDictionary<string, TCacheRecord>;
  R: TCacheRecord;
  PT: TPoint2d;
begin
  for Z := 1 to CacheZoom do
  begin
    L := FCachedArray[Z];
    if S.FCached then
    begin
      PT := S.Center2d;
      GetBlockCoordinate(PT.X, PT.Y, MaxZoom - Z, NumX, NumY, CacheWidth);
      R := nil;
      if not L.TryGetValue(IntToStr(NumX) + '_' + IntToStr(NumY), R) then
      begin
        R := TCacheRecord.create(Self);
        R.NumX := NumX;
        R.NumY := NumY;
        R.Count := 0;
        R.Position.X := 0;
        R.Position.Y := 0;
        L.Add(IntToStr(NumX) + '_' + IntToStr(NumY), R);
      end;
      R.Count := R.Count + 1;
      R.Position.X := (R.Position.X * (R.Count - 1) + PT.X) / R.Count;
      R.Position.Y := (R.Position.Y * (R.Count - 1) + PT.Y) / R.Count;
      R.FirstObject := S;
      if Z = CacheZoom then
      begin
        R.FObjects.Add(S);
        S.Category := IntToStr(NumX) + '_' + IntToStr(NumY);
      end;
    end;

  end;
end;

procedure TfgMapMarkerManager.SetActiveTag(const Value: Integer);
begin
  FActiveTag := Value;
end;

procedure TfgMapMarkerManager.SetCacheZoom(const Value: Integer);
begin
  FCacheZoom := Value;
end;

constructor TfgMapMarkerManager.create;
var
  i: Integer;
begin
  FBitmaps := TObjectDictionary<String, TfgBitmap>.create;
  FObjects := TObjectList<TjsObject2d>.create;
  FObjects.OwnsObjects := True;
  CacheZoom := 18;
  ActiveTag := -1;
  FCurrentZoom := -1;
  for i := 1 to MaxZoom do
  begin
    FCachedArray[i] := TObjectDictionary<string, TCacheRecord>.create(0);
  end;

end;

function TfgMapMarkerManager.DeleteObject(ATag: Integer): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FObjects.Count - 1 do
  begin
    if FObjects[i].Tag = ATag then
    begin
      if FObjects[i].FMapMarker <> nil then
        FObjects[i].FOwner.Markers.RemoveObject(FObjects[i].FMapMarker);
      FObjects.Delete(i);
      Result := True;
      Break;
    end;
  end;
end;

destructor TfgMapMarkerManager.Destroy;
var
  i: Integer;
begin
  // FBitmaps.Free;
  FObjects.Free;
  for i := 1 to MaxZoom do
  begin
    ClearCache(i);
    FCachedArray[i].Free;
  end;

  inherited;
end;

procedure TfgMapMarkerManager.DrawObjects;
var
  i: Integer;
  S: TjsObject2d;
  MinX, MinY, MaxX, MaxY: Integer;
  Cr: TCacheRecord;
  R: TRect2D;
  FVisualRect2d: TRect2D;
  FZoom: Integer;
  PT: TPair<string, TCacheRecord>;
begin
  if Assigned(FMap) and not(FMap.IsUpdating) then
    try
      FZoom := Round(FMap.CameraZoom);
      for i := 1 to CacheZoom do
        if FZoom <> i then
        begin
          for PT in FCachedArray[i] do
            if PT.Value.FMapMarker <> nil then
            begin
              FMap.Markers.RemoveObject(PT.Value.FMapMarker);
              PT.Value.FMapMarker := nil;
            end;
        end;
      if FZoom < 1 then
        Exit;
      FVisualRect2d := GetVisualRect;
      if (FVisualRect2d.Left = FVisualRect2d.Right) and
        (FVisualRect2d.Top = FVisualRect2d.Bottom) then
      begin
        Exit;
      end;

      for i := 0 to FObjects.Count - 1 do
      begin
        S := TjsObject2d(FObjects[i]);
        if not(S.Visible) then
        begin
          S.Visible := True;
          if Assigned(S.MapMarker) then
          begin
            if (S.FTag = ActiveTag) then
            begin
              S.MapMarker.IsInfoWindowVisible := True;
              ActiveTag := -1;
            end;
          end;
        end
        else if Assigned(S.MapMarker) then
        begin
          if (S.FTag = ActiveTag) then
          begin
            S.MapMarker.IsInfoWindowVisible := True;
            ActiveTag := -1;
          end;

        end;

      end;

      if FZoom <= CacheZoom then
      begin
        GetBlockCoordinate(FVisualRect2d.Left, FVisualRect2d.Bottom,
          MaxZoom - FZoom, MaxX, MinY, CacheWidth);
        GetBlockCoordinate(FVisualRect2d.Right, FVisualRect2d.Top,
          MaxZoom - FZoom, MinX, MaxY, CacheWidth);
        for PT in FCachedArray[FZoom] do
        begin
          Cr := PT.Value;
          if (Cr.NumX >= MinX) and (Cr.NumX <= MaxX) and (Cr.NumY >= MinY) and
            (Cr.NumY <= MaxY) then
          begin
            if Cr.FMapMarker = nil then
              AddCachedMarker(Cr);
          end
          else if PT.Value.FMapMarker <> nil then
          begin
            FMap.Markers.RemoveObject(PT.Value.FMapMarker);
            PT.Value.FMapMarker := nil;
          end;
        end;
      end;
      if (FZoom <> CurrentZoom) or (FZoom > CacheZoom) then
      begin
        FCurrentZoom := FZoom;
        GetBlockCoordinate(FVisualRect2d.Left, FVisualRect2d.Bottom,
          MaxZoom - CacheZoom, MaxX, MinY, CacheWidth);
        GetBlockCoordinate(FVisualRect2d.Right, FVisualRect2d.Top,
          MaxZoom - CacheZoom, MinX, MaxY, CacheWidth);
        for PT in FCachedArray[CacheZoom] do
        begin
          Cr := PT.Value;
          if (Cr.NumX >= MinX) and (Cr.NumX <= MaxX) and (Cr.NumY >= MinY) and
            (Cr.NumY <= MaxY) then
          begin
            for i := 0 to Cr.FObjects.Count - 1 do
            begin
              S := TjsObject2d(Cr.FObjects[i]);
              R.FirstEdge := S.FCenter2d;
              R.SecondEdge := S.FCenter2d;
              if (FZoom > CacheZoom) or (not S.FCached) then
              begin
                if (not S.FCached) or IsBoxInBox2D(R, FVisualRect2d) then
                begin
                  if not(S.Visible) then
                  begin
                    S.Visible := True;
                    Cr.MarkersCount := Cr.MarkersCount + 1;
                    if Assigned(S.MapMarker) then
                    begin
                      if (S.FTag = ActiveTag) then
                      begin
                        S.MapMarker.IsInfoWindowVisible := True;
                        ActiveTag := -1;
                      end;
                    end;
                  end
                  else if Assigned(S.MapMarker) then
                  begin
                    if (S.FTag = ActiveTag) then
                    begin
                      S.MapMarker.IsInfoWindowVisible := True;
                      ActiveTag := -1;
                    end;

                  end;
                end
                else if (S.Visible) then
                begin
                  S.Visible := False;
                  Cr.MarkersCount := Cr.MarkersCount - 1;
                end
              end
              else if ((S.Visible) and (S.FCached)) then
              begin
                S.Visible := False;
                Cr.MarkersCount := Cr.MarkersCount - 1;
              end;

            end;
          end
          else
            Cr.ClearMarkers;
        end;
      end
      // setCenter2d(Center2d);
    finally
    end;
end;

function TfgMapMarkerManager.GetVisualRect: TRect2D;
var
{$IFDEF ANDROID}
  gm: JGoogleMap;
{$ELSE}
  gm: IFGXMap;
  rect: MKMapRect;
  pointne: MKMapPoint;
  pointsw: MKMapPoint;
  coordpointne: CLLocationCoordinate2D;
  coordpointsw: CLLocationCoordinate2D;
{$ENDIF}
  Lat1, Lat2, Lon1, Lon2: Double;

begin
{$IFDEF ANDROID}
  gm := TfgAndroidMap(TfgAndroidControlHandle(FMap.Handle).NativeControl)
    .GoogleMap;
  Lat1 := gm.getProjection.getVisibleRegion.latLngBounds.northeast.latitude;
  Lon1 := gm.getProjection.getVisibleRegion.latLngBounds.northeast.longitude;
  Lat2 := gm.getProjection.getVisibleRegion.latLngBounds.southwest.latitude;
  Lon2 := gm.getProjection.getVisibleRegion.latLngBounds.southwest.longitude;
{$ELSE}
  gm := TfgiOSMap(TfgiOSControlHandle(FMap.Handle).NativeControl).View;
  rect := gm.visibleMapRect;
  pointne.X := rect.origin.X + rect.Size.width;
  pointne.Y := rect.origin.Y;
  pointsw.X := rect.origin.X;
  pointsw.Y := rect.origin.Y + rect.Size.height;
  coordpointne := MKCoordinateForMapPoint(pointne);
  coordpointsw := MKCoordinateForMapPoint(pointsw);
  Lat1 := coordpointne.latitude;
  Lon1 := coordpointne.longitude;
  Lat2 := coordpointsw.latitude;
  Lon2 := coordpointsw.longitude;
{$ENDIF}
  Result := Rect2D(Lat1, Lon1, Lat2, Lon2);
end;

end.
