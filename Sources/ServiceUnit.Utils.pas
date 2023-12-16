unit ServiceUnit.Utils;

interface

uses System.UITypes, System.SysUtils, System.Generics.Collections, System.Generics.Defaults,
  ServiceUnit.mwClasses, FGX.Canvas;

type
  TGenericsUtils = class
  public
    class function AScan<T>(const Arr: array of T; const Value: T; const Comparer: IEqualityComparer<T>)
      : Integer; overload;
    class function AScan<T>(const Arr: array of T; const Value: T): Integer; overload;
  end;

function ColorToAlphaColor(Value: TColor): TAlphaColor;
function IsLightColor(const Value: TAlphaColor): Boolean;
function PhonesSplit(const aValue: string): TArray<string>;
procedure LoadLocalBidText(const aID: Integer; out aResult: Integer; out aResultText: string;
  out aUnixDateTime: Integer);
procedure LoadLocalBidMaterials(const aID: Integer; out aResultText: TmwLocalBidMaterials);
procedure LoadLocalBidWorks(const aID: Integer; out aResultText: TmwLocalBidWorks);
procedure LoadLocalBidPhoto(const aID, aIndex: Integer; out aImage: TfgBitmap);
procedure SaveLocalBidMaterials(const aID: Integer; const aIDS, aCounts, aWHIDs: string);
procedure SaveLocalBidWorks(const aID: Integer; const aIDS, aCounts: string);
procedure SaveLocalBidText(const aID, aResult: Integer; const aResultText: string; aUnixDateTime: int64);
procedure SaveLocalBidPhoto(const aID, aIndex: Integer; const aImage: TfgBitmap);
procedure RemoveBidPhotos(const aID: Integer);
function generateBid(const aID: Integer): string;
{$IFDEF ANDROID}
procedure DoExternalCall(phoneNumber: string);
{$ENDIF}

implementation

uses System.IOUtils, System.DateUtils, System.NetEncoding, System.Classes,
  Generics.Collections,
{$IFDEF ANDROID}
  Android.Api.ActivityAndView, Android.Api.Javatypes, FGX.Helpers.Android,
  Android.Api.Providers.Settings, Java.Bridge, AndroidApi.Jni,
{$ENDIF}
  FGX.Assets, FGX.Assets.Helpers, FGX.Assets.BitMapSet,
  FGX.Any.Utils;

{$IFDEF ANDROID}

procedure DoExternalCall(phoneNumber: string);
var
  Intent: JIntent;
  U: JUri;
begin
  Intent := TJIntent.Create(TJIntent.ACTION_DIAL);
  U := TJUri.parse(StringToJString('tel:' + phoneNumber));
  Intent.setData(U);
  TfgAndroidHelper.Activity.startActivity(Intent);
end;
{$ENDIF}

procedure LoadLocalBidPhoto(const aID, aIndex: Integer; out aImage: TfgBitmap);
var
  aFile: string;
  aBid: TmwLocalBid;
  aMem: TMemoryStream;
  aStrMem: TBytesStream;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
  begin
    aBid := TmwLocalBid.CreateFromFile(aFile);
    if aBid.photos.Count > aIndex then
    begin
      aMem := TMemoryStream.Create;
      aStrMem := TBytesStream.Create(BytesOf(aBid.photos[aIndex].data));
      try
        if TNetEncoding.Base64.Decode(aStrMem, aMem) > 0 then
        begin
          aMem.Position := 0;
          if aImage = nil then
            aImage := TfgBitmap.Create;
          aImage.LoadFromStream(aMem);
        end;
      finally
        aMem.Free;
        aStrMem.Free;
      end;
    end;
  end
end;

procedure RemoveBidPhotos(const aID: Integer);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
  begin
    aBid := TmwLocalBid.CreateFromFile(aFile);
    aBid.photos.Clear;
    aBid.SaveToFile(aFile);
  end
end;

procedure SaveLocalBidPhoto(const aID, aIndex: Integer; const aImage: TfgBitmap);
var
  aFile: string;
  aBid: TmwLocalBid;
  aJpeg: TMemoryStream;
  item: TmwLocalBidPhotoItem;
  Params: TfgBitmapSaveParams;
begin
  if not Assigned(aImage) then
    Exit;
  aFile := generateBid(aID);
  if FileExists(aFile) then
    aBid := TmwLocalBid.CreateFromFile(aFile)
  else
  begin
    aBid := TmwLocalBid.Create;
    aBid.status := 'OK';
    aBid.id := aID;
    aBid.Result := 0;
    aBid.resultText := '';
    aBid.unix_dt := DateTimeToUnix(Now, false);
    aBid.photos := TObjectList<TmwLocalBidPhotoItem>.Create(true);
  end;
  aJpeg := TMemoryStream.Create;
  try
    Params := TfgBitmapSaveParams.Default;
    Params.Quality := 80;
    aImage.SaveToStream(aJpeg, TfgImageFormat.JPEG, Params);
    item := TmwLocalBidPhotoItem.Create;
    item.data := TNetEncoding.Base64.EncodeBytesToString(aJpeg.Memory, aJpeg.Size);
    aBid.photos.Add(item);
  finally
    aJpeg.Free;
    aBid.SaveToFile(aFile);
  end;
end;

function generateBid(const aID: Integer): string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, IntToStr(aID) + '.json')
end;

procedure LoadLocalBidText(const aID: Integer; out aResult: Integer; out aResultText: string;
  out aUnixDateTime: Integer);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
    aBid := TmwLocalBid.CreateFromFile(aFile)
  else
  begin
    aBid := TmwLocalBid.Create;
    aBid.status := 'OK';
    aBid.id := aID;
    aBid.Result := 0;
    aBid.resultText := '';
    aBid.unix_dt := DateTimeToUnix(Now, false);
    aBid.photos := TObjectList<TmwLocalBidPhotoItem>.Create(true);
  end;
  aResult := aBid.Result;
  aResultText := aBid.resultText;
  aUnixDateTime := aBid.unix_dt;
end;

procedure SaveLocalBidText(const aID, aResult: Integer; const aResultText: string; aUnixDateTime: int64);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
    aBid := TmwLocalBid.CreateFromFile(aFile)
  else
  begin
    aBid := TmwLocalBid.Create;
    aBid.status := 'OK';
    aBid.id := aID;
    aBid.Result := 0;
    aBid.resultText := '';
    aBid.unix_dt := DateTimeToUnix(Now, false);
  end;
  aBid.status := 'OK';
  aBid.id := aID;
  aBid.Result := aResult;
  aBid.resultText := aResultText;
  aBid.unix_dt := aUnixDateTime;
  aBid.SaveToFile(aFile);
end;

procedure LoadLocalBidMaterials(const aID: Integer; out aResultText: TmwLocalBidMaterials);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
  begin
    aBid := TmwLocalBid.CreateFromFile(aFile);
    aResultText := aBid.materials;
  end
  else
  begin
    aResultText := nil;
  end;
end;

procedure LoadLocalBidWorks(const aID: Integer; out aResultText: TmwLocalBidWorks);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
  begin
    aBid := TmwLocalBid.CreateFromFile(aFile);
    aResultText := aBid.works;
  end
  else
  begin
    aResultText := nil;
  end;
end;

procedure SaveLocalBidMaterials(const aID: Integer; const aIDS, aCounts, aWHIDs: string);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
  begin
    aBid := TmwLocalBid.CreateFromFile(aFile);
    aBid.status := 'OK';
    aBid.unix_dt := DateTimeToUnix(Now, false);
    aBid.materials.ids := aIDS;
    aBid.materials.counts := aCounts;
    aBid.materials.whids := aWHIDs;
  end
  else
  begin
    aBid := TmwLocalBid.Create;
    aBid.status := 'OK';
    aBid.id := aID;
    aBid.Result := 0;
    aBid.resultText := '';
    aBid.unix_dt := DateTimeToUnix(Now, false);
    aBid.materials := TmwLocalBidMaterials.Create;
    aBid.materials.ids := aIDS;
    aBid.materials.counts := aCounts;
    aBid.materials.whids := aWHIDs;
  end;
  aBid.SaveToFile(aFile);
end;

procedure SaveLocalBidWorks(const aID: Integer; const aIDS, aCounts: string);
var
  aFile: string;
  aBid: TmwLocalBid;
begin
  aFile := generateBid(aID);
  if FileExists(aFile) then
  begin
    aBid := TmwLocalBid.CreateFromFile(aFile);
    aBid.status := 'OK';
    aBid.unix_dt := DateTimeToUnix(Now, false);
    aBid.works.ids := aIDS;
    aBid.works.counts := aCounts;
  end
  else
  begin
    aBid := TmwLocalBid.Create;
    aBid.status := 'OK';
    aBid.id := aID;
    aBid.Result := 0;
    aBid.resultText := '';
    aBid.unix_dt := DateTimeToUnix(Now, false);
    aBid.works := TmwLocalBidWorks.Create;
    aBid.works.ids := aIDS;
    aBid.works.counts := aCounts;
  end;
  aBid.SaveToFile(aFile);
end;

function ColorToAlphaColor(Value: TColor): TAlphaColor;
var
  CRec: TColorRec;
  ARec: TAlphaColorRec;
begin
  CRec.Color := Value;
  ARec.A := $FF;
  ARec.B := CRec.B;
  ARec.G := CRec.G;
  ARec.R := CRec.R;
  Result := ARec.Color;
end;

function IsLightColor(const Value: TAlphaColor): Boolean;
var
  ARec: TAlphaColorRec;
begin
  ARec.Color := Value;
  if (1 - (0.299 * ARec.R + 0.587 * ARec.B + 0.114 * ARec.B) / 255 < 0.5) then
    Result := true
  else
    Result := false;
end;

function PhonesSplit(const aValue: string): TArray<string>;
var
  aCount: Integer;
  aStr: string;
begin
  SetLength(Result, 0);
  aStr := aValue;
  if not aStr.EndsWith(',') then
    aStr := aStr + ',';
  aCount := aStr.CountChar(',');
  Result := aStr.Split([','], aCount);
end;

class function TGenericsUtils.AScan<T>(const Arr: array of T; const Value: T): Integer;
begin
  Result := AScan<T>(Arr, Value, TEqualityComparer<T>.Default);
end;

class function TGenericsUtils.AScan<T>(const Arr: array of T; const Value: T;
  const Comparer: IEqualityComparer<T>): Integer;
var
  i: Integer;
begin
  for i := Low(Arr) to High(Arr) do
    if Comparer.Equals(Arr[i], Value) then
      Exit(i);
  Exit(-1);
end;

end.
