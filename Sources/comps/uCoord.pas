unit uCoord; // Процедуры из скриптов Google Maps

interface

type
  Trealtype = double;
  TName = string;

const
  MaxZoom = 20;
  StdBlockSize = 256;
procedure GetBlockCoordinate(Lat, Lon: Trealtype; ZoomLevel: integer; var NumX, NumY: integer;
  BlockSize: integer = StdBlockSize);

// procedure YandexGetBlockCoordinate (Lat, Lon: TRealType; ZoomLevel: integer; var NumX, NumY: integer;BlockSize:Integer=stdBlockSize);
// procedure GetLatLon (X, Y: integer; ZoomLevel: integer; var Lat, Lon: TRealType);
// procedure YandexGetLatLon (X, Y: integer; ZoomLevel: integer; var Lat, Lon: TRealType);
// function IsInTileBoundsY (NumY: integer; ZoomLevel: integer): boolean;
var
  NumTiles: array [0 .. MaxZoom - 1] of integer;

implementation

uses Math;

// =============================================================================

var
  PixelsPerLonDegree: array [0 .. MaxZoom - 1] of Trealtype;
  PixelsPerLonRadian: array [0 .. MaxZoom - 1] of Trealtype;
  BitmapOrigo: array [0 .. MaxZoom - 1] of integer;



  // =============================================================================

function D2R(degree: Trealtype): Trealtype;
begin
  Result := degree * PI / 180;
end;

// -----------------------------------------------------------------------------

procedure InitMercator;
var
  a: integer;
  b: integer;
begin
  a := 256;
  for b := MaxZoom - 1 downto 0 do
  begin
    PixelsPerLonDegree[b] := a / 360;
    PixelsPerLonRadian[b] := a / (2 * PI);
    BitmapOrigo[b] := a div 2;
    NumTiles[b] := a div 256;
    a := a * 2;
  end;
end;

// -----------------------------------------------------------------------------
function atanh(x: Trealtype): Trealtype;
begin
  Result := 0.5 * Ln((1 + x) / (1 - x));
end;

procedure GetBitmapCoordinate(Lat, Lon: Trealtype; ZoomLevel: integer; var x, Y: integer);
var
  e: Trealtype;
begin
  x := floor(BitmapOrigo[ZoomLevel] + Lon * PixelsPerLonDegree[ZoomLevel]);

  if (Lat > 89) then
    Lat := 89;
  if (Lat < -89) then
    Lat := -89;
  e := sin(D2R(Lat));

  Y := floor(BitmapOrigo[ZoomLevel] - 0.5 * Ln((1 + e) / (1 - e)) * PixelsPerLonRadian[ZoomLevel]);
end;

procedure YandexGetBitmapCoordinate(Lat, Lon: Trealtype; ZoomLevel: integer; var x, Y: integer);
var
  z, c, exct, PixelsAtZoom: Trealtype;
begin
  PixelsAtZoom := 256 * Power(2, ZoomLevel);
  exct := 0.0818197;
  z := sin(DegToRad(Lat));
  c := (PixelsAtZoom / (2 * PI));
  x := floor(PixelsAtZoom / 2 + Lon * (PixelsAtZoom / 360));
  Y := floor(PixelsAtZoom / 2 - c * (atanh(z) - exct * atanh(exct * z)));
end;

// -----------------------------------------------------------------------------

procedure GetLatLon(x, Y: integer; ZoomLevel: integer; var Lat, Lon: Trealtype);
var
  e: Trealtype;
begin
  Lon := (x - BitmapOrigo[ZoomLevel]) / PixelsPerLonDegree[ZoomLevel];

  e := (Y - BitmapOrigo[ZoomLevel]) / -PixelsPerLonRadian[ZoomLevel];
  Lat := (2 * arctan(exp(e)) - PI / 2) * 180 / PI;
end;

procedure YandexGetLatLon(x, Y: integer; ZoomLevel: integer; var Lat, Lon: Trealtype);
var
  exct, Zu, Zum1, yy, PixelsAtZoom: Trealtype;
begin
  PixelsAtZoom := 256 * Power(2, ZoomLevel);
  Lon := (x - PixelsAtZoom / 2) / (PixelsAtZoom / 360);
  Lat := (Y - PixelsAtZoom / 2) / -(PixelsAtZoom / (2 * PI));
  Lat := abs((2 * arctan(exp(Lat)) - PI / 2) * 180 / PI);
  Zu := Lat / (180 / PI);
  Zum1 := Zu + 1;
  exct := 0.0818197;
  yy := -abs((Y - PixelsAtZoom / 2));
  while (abs(Zum1 - Zu) > 0.0000001) do
  begin
    Zum1 := Zu;
    Zu := ArcSin(1 - ((1 + sin(Zum1)) * Power(1 - exct * sin(Zum1), exct)) / (exp((2 * yy) / -(PixelsAtZoom / (2 * PI)))
      * Power(1 + exct * sin(Zum1), exct)));
  end;
  if (Y > PixelsAtZoom / 2) then
    Lat := -Zu * 180 / PI
  else
    Lat := Zu * 180 / PI;

end;
// -----------------------------------------------------------------------------

procedure GetBlockCoordinate(Lat, Lon: Trealtype; ZoomLevel: integer; var NumX, NumY: integer;
  BlockSize: integer = StdBlockSize);
var
  x, Y: integer;
begin
  GetBitmapCoordinate(Lat, Lon, ZoomLevel, x, Y);
  NumX := floor(x / BlockSize);
  NumY := floor(Y / BlockSize);
end;

procedure YandexGetBlockCoordinate(Lat, Lon: Trealtype; ZoomLevel: integer; var NumX, NumY: integer;
  BlockSize: integer);
var
  x, Y: integer;
begin
  YandexGetBitmapCoordinate(Lat, Lon, ZoomLevel, x, Y);
  NumX := floor(x / BlockSize);
  NumY := floor(Y / BlockSize);
end;

// -----------------------------------------------------------------------------

function IsInTileBoundsY(NumY: integer; ZoomLevel: integer): boolean;
begin
  Result := (0 <= NumY) and (NumY < NumTiles[ZoomLevel]);
end;

function GetMaxNum(ZoomLevel: integer): integer;
begin
  Result := NumTiles[ZoomLevel] - 1;
end;

// -----------------------------------------------------------------------------
procedure GetBlockNum(Name: TName; var NumX, NumY: integer);
var
  Lev: integer;
  i: integer;
  c: char;
  d: integer;
begin
  Lev := Length(Name);
  NumX := 0;
  NumY := 0;
  d := 1;
  for i := Lev downto 2 do
  begin
    if (i < Lev) then
      d := d * 2;
    c := Name[i];
    case ord(c) of
      ord('t'):
        begin
          NumY := NumY + d;
        end;
      ord('s'):
        begin
          NumY := NumY + d;
          NumX := NumX + d;
        end;
      ord('r'):
        begin
          NumX := NumX + d;
        end;
    end;
  end;
end;

// =============================================================================

{ function CoordsToBlockName (Lat, Lon: TRealType; ZoomLevel: integer): TName;
  var NumX, NumY: integer;
  begin
  GetBlockCoordinate (Lat, Lon, ZoomLevel, NumX, NumY);
  Result:= GetBlockName (NumX, NumY, ZoomLevel);
  end;
}
// =============================================================================

begin
  InitMercator;

end.
