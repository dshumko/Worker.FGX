unit FGX.Any.Utils;

interface
uses FGX.Log,FGX.Application,FGX.Animation.Types,FGX.Canvas,FGX.Types.AutoreleasePool,FGX.Canvas.Types,FGX.Text,
System.UiTypes,Classes,System.IoUtils,SysUtils {$IFDEF ANDROID},FGX.Controls.Android,FGX.Canvas.Android,Android.Api.Web,Android.Api.ActivityAndView,Android.Api.AppUpdateManager,Android.Api.Exif,Android.Api.PowerManager ,AndroidApi.Jni, Android.Api.Javatypes,Java.Bridge,FGX.Helpers.Android,Android.Api.Providers.Settings{$ELSE},iOS.Api.CoreGraphics,FGX.Canvas.IOS,FGX.Helpers.IOS,iOS.Api.Foundation, iOS.Api.UIKit,iOS.Api.Helpers,iOS.Api.CocoaTypes, Macapi.ObjectiveC{$ENDIF},FGX.Toasts;
type
{$IFDEF ANDROID}
 NativeString=JString;
{$ELSE}
 NativeString=NSString;
{$ENDIF}
function IsPortrait:boolean;
function GetDeviceId:String;
function VersionInfo: String;
function PhoneModel:String;
function Js2S(Js:NativeString):String;
function S2Js(S:String):NativeString;
procedure RemoveAssetDirectory(AName:String);
function ResizeBitmap(B:TfgBitmap;Sz:Double):TfgBitmap;
procedure CompressBitmap(B:TfgBitmap;M:TMemoryStream;ASize:Integer=70);
procedure CompressBitmapFromFile(AFileName:String;M:TMemoryStream;ASize:Integer=70);
function PrepareBitmapFromFile(FileName:String;Sz:Integer;var Lat,Lon:Double;PlaceDate:boolean=false):TfgBitmap;
procedure TfgToastShow(const AMessage: string; const ADuration: TfgToastDuration = TfgToastDuration.Short);
procedure SetControlsDescription(F:TComponent);
procedure OpenFile(const AFileName:String;SMimeTYpe:String='');
procedure AppTerminate;
function  InstalledFromGooglePlay:boolean;
procedure InstallFromGooglePlay(AProc:TProc<Integer>);
implementation
uses FGX.Controls,FGX.Dialogs,FGX.Assets,FGX.Screen;
{$IFDEF ANDROID}
type TGooglePlayUpdate=class(TJavalocal,JOnCompleteListener)
private
FAppUpdate:JAppUpdateManager;
FTask:JTask;
FProc:TProc<Integer>;
public
 procedure onComplete(const AArg0: JTask);
 constructor Create(AProc:TProc<Integer>);
end;
{ TCompleteCheckListener }

constructor TGooglePlayUpdate.Create(AProc:TProc<Integer>);
begin
 inherited Create;
 FProc:=AProc;
 FAppUpdate:=TJAppUpdateManagerFactory.Create(TfgAndroidHelper.Context);
 FTask:=FAppUpdate.getAppUpdateInfo;
 FTask.addOnCompleteListener(Self) ;
 TfgAutoreleasePool.Store(Self);
end;
procedure TGooglePlayUpdate.onComplete(const AArg0: JTask);
var j:JAppUpdateInfo;
begin
 if (AArg0.isSuccessful)  then
 begin
 J:=TJAppUpdateInfo.Wrap(AArg0.getResult);
 TfgLog.Info('Version Code :'+J.availableVersionCode.ToString);
 if (J.updateAvailability=TJUpdateAvailability.UPDATE_NOT_AVAILABLE) then
 begin
  if Assigned(FProc) then FProc(TJUpdateAvailability.UPDATE_NOT_AVAILABLE)
 end
 else
 if (J.updateAvailability=TJUpdateAvailability.UPDATE_AVAILABLE)
 and (J.isUpdateTypeAllowed(TJAppUpdateType.FLEXIBLE))
  then
   begin
     if Assigned(FProc) then FProc(TJUpdateAvailability.UPDATE_AVAILABLE);
    FAppUpdate.startUpdateFlowForResult(j,TJAppUpdateType.FLEXIBLE,TfgAndroidHelper.Activity,100+TJAppUpdateType.FLEXIBLE);
   end
 else
 if (J.updateAvailability=TJUpdateAvailability.UPDATE_AVAILABLE)
 and (J.isUpdateTypeAllowed(TJAppUpdateType.IMMEDIATE))
  then
   begin
     if Assigned(FProc) then FProc(TJUpdateAvailability.UPDATE_AVAILABLE);
    FAppUpdate.startUpdateFlowForResult(j,TJAppUpdateType.IMMEDIATE,TfgAndroidHelper.Activity,100+TJAppUpdateType.IMMEDIATE);
   end
 end
 else
  if Assigned(FProc) then FProc(TJUpdateAvailability.UNKNOWN)


end;

{$ENDIF}
procedure RemoveAssetDirectory(AName:String);
var
    NormalizedFileName:String;
    ImageFileName:String;

begin
  NormalizedFileName := string(AName).Replace(TfgAsset.FolderSeparator, TPath.PathSeparator);
  ImageFileName := TPath.Combine(TPath.GetCachePath, NormalizedFileName);
  if TDirectory.Exists(ImageFileName) then
  TDirectory.Delete(ImageFileName,True);

end;
procedure InstallFromGooglePlay(AProc:TProc<Integer>);
begin
 {$IFDEF ANDROID}
  TGooglePlayUpdate.Create(AProc);
 {$ENDIF}
end;
function  InstalledFromGooglePlay:boolean;
{$IFDEF ANDROID}
var S:String;
{$ENDIF}
begin
// "com.android.vending", "com.google.android.feedback"
Result:=False;
{$IFDEF ANDROID}
 // .getInstallerPackageName(TfgAndroidHelper.Context.getPackageName)
 // will need to be replaced by
 // .getInstallSourceInfo((TfgAndroidHelper.Context.getPackageName).installingPackageName
 S:=JStringToString(TfgAndroidHelper.Context.getPackageManager.getInstallerPackageName(TfgAndroidHelper.Context.getPackageName));
 if (S='com.android.vending') or (s='com.google.android.feedback') then
  Result:=true;
{$ENDIF}
end;
procedure AppTerminate;
begin
 {$IFDEF ANDROID}
  TfgAndroidHelper.Activity.finish;
 {$ENDIF}
end;
procedure OpenFile(const AFileName:String;SMimeType:String='');
{$IFDEF ANDROID}
var
    TmpFile:String;
    TmpExt:String;
    M:JMimeTypeMap;
    AMimeType:JString;
    J:JIntent;
    Uri:JUri;
 {$ELSE}
 var
  Url: NSUrl;

{$ENDIF}
begin
{$IFDEF ANDROID}
   TmpFile:=AFileName;
    M := TJMimeTypeMap.getSingleton;
    try
     If SMimeType=''
     then
     begin
       TmpExt := ExtractFileExt(TmpFile).Substring(2);
       AMimeTYpe := M.getMimeTypeFromExtension(StringToJString(TmpExt));
     end
     else
      AMimeType:=StringToJString(SMimeType);
        Uri := TfgAndroidHelper.GetUriForFileName(TmpFile);
        J := TJIntent.Create(TJIntent.ACTION_VIEW);
        J.setDataAndType(Uri, AMimeTYpe);
        J.addFlags(TJIntent.FLAG_ACTIVITY_NEW_TASK);
        J.setFlags(TJIntent.FLAG_GRANT_READ_URI_PERMISSION);
        TfgAndroidHelper.Activity.startActivity(J);
    finally
     M:=nil
    end;
{$ELSE}
  if FileExists(AFileName) then
  begin
  Url := StrToNsUrl(AFileName);
  if TfgiOSHelper.SharedApplication.canOpenURL(Url) then
  TfgiOSHelper.SharedApplication.openUrl(Url);
  end;
{$ENDIF}

end;
function Js2S(Js:NativeString):String;
begin
 {$IFDEF ANDROID}
 Result:=JStringToString(Js);
 {$ELSE}
 Result:=NSStrToStr(JS);
 {$ENDIF}
end;
function S2Js(S:String):NativeString;
begin
 {$IFDEF ANDROID}
 Result:=StringToJString(S);
 {$ELSE}
 Result:=StrToNSStr(S);
 {$ENDIF}
end;
function GetDeviceId:String;
begin
{$IFDEF ANDROID}
Result:=JStringToString(TJSettings_Secure.getString( TfgAndroidHelper.Context.getContentResolver,TJSettings_Secure.ANDROID_ID))
{$ELSE}
Result:=NSStrToStr(TUIDevice.OCClass.currentDevice.identifierForVendor.UUIDString);
{$ENDIF}
end;
function VersionInfo: String;
{$IFDEF ANDROID}
  var info:JPackageInfo;
{$ENDIF}
begin
{$IFDEF ANDROID}
 info:=TfgAndroidHelper.Context.getPackageManager.getPackageInfo(TfgAndroidHelper.Context.getPackageName,0);
 Result:=JStringToString(info.versionName)+'.'+IntToStr(info.versionCode);
{$ELSE}
 Result:=Application.Info.Version;
{$ENDIF}
end;
procedure SetControlsDescription(F:TComponent);
{$IFDEF ANDROID}
var i:integer;
{$ENDIF}
begin
{$IFDEF ANDROID}
 for I := 0 to F.ComponentCount-1 do
   if (F.Components[i] is TfgControl)
   and Assigned(TfgControl(F.Components[i]).Handle)
   and Assigned(TfgControl(F.Components[i]).Handle.View)
   then
   TfgControl(F.Components[i]).Handle.View.setContentDescription(StringToJCharSequence(F.Components[i].Name));
{$ENDIF}
end;
{$IFDEF IOS}
 function UIImageJPEGRepresentationEx(image: Pointer; compressionQuality: CGFloat): Pointer; cdecl;
  external libUIKit name _PU + 'UIImageJPEGRepresentation';

{$ENDIF}
procedure CompressBitmap(B:TfgBitmap;M:TMemoryStream;ASize:Integer=70);
var
   fp:TfgBitmapSaveParams;
begin
  fp.Quality:=ASize;
  B.SaveToStream(M,TfgImageFormat.JPEG,fp);
  M.Position:=0;

end;
procedure CompressBitmapFromFile(AFileName:String;M:TMemoryStream;ASize:Integer=70);
var
   fp:TfgBitmapSaveParams;
   B:TfgBitmap;
begin
  B:=TfgBitmap.Create;
  try
  B.LoadFromFile(AFileName);
  fp.Quality:=ASize;
  B.SaveToStream(M,TfgImageFormat.JPEG,fp);
  M.Position:=0;
  finally
    B.Free;
  end;

end;
procedure TfgToastShow(const AMessage: string; const ADuration: TfgToastDuration = TfgToastDuration.Short);
begin
 TfgLog.Info('Start Toast');
 TfgToastFactory.Show(AMessage,ADuration);
 TfgLog.Info('End Toast')
end;

function IsPortrait:boolean;
begin
{$IFDEF ANDROID}
Result:=TfgAndroidHelper.Activity.getResources().getConfiguration().orientation=
  TJConfiguration.ORIENTATION_PORTRAIT
{$ELSE}
Result:=not (TfgiOSHelper.CurrentDevice.orientation in [UIDeviceOrientationLandscapeLeft,UIDeviceOrientationLandscapeRight])
{$ENDIF}
end;
function ResizeBitmapEx(B:TfgBitmap;Sz:Double):TfgBitmap;
{$IFDEF ANDROID}
var M:JMatrix;
    BA,BA1:JBitmap;
{$ENDIF}
begin
{$IFDEF ANDROID}
try
BA:=TfgAndroidBitmapHandle(B.Handle).NativeBitmap;
M:=TJMatrix.Create;
if B.Width>B.Height then
m.postScale(Sz/B.Width,Sz/B.Width)
else
m.postScale(Sz/B.Height,Sz/B.Height);
TfgLog.Info('Post Scale');
BA1:=Ba.copy(Ba.getConfig,true);
BA1:=TJBitmap.createBitmap(BA1,0,0,BA1.getWidth,BA1.getHeight,m,true);
Result:=TfgBitmap.CreateFromNativeBitmap(BA1);
finally
end;
{$ELSE}
Result:=ResizeBitmap(B,Sz);
{$ENDIF}
end;

function ResizeBitmap(B:TfgBitmap;Sz:Double):TfgBitmap;
begin
if B.Width>B.Height then
Result:=TfgBitmap.Create(round(SZ),round(B.Height*SZ/B.Width))
else
Result:=TfgBitmap.Create(round(B.Width*SZ/B.Height),round(SZ));
Result.Canvas.BeginPaint;
Result.Canvas.DrawBitmap(B,Rect(0,0,B.Width,B.Height),Rect(0,0,Result.Width,Result.Height));
Result.Canvas.EndPaint;
end;
{$IFDEF IOS}
function UIImageToBitmap(img:UIImage):TfgBitmap;
var tmpFile:String;
    D:NSData;
begin
  tmpFile:=TPath.GetTempFileName+'.jpg';
  D:=TNSData.Wrap(UIImageJPEGRepresentationEx((img as ILocalObject).GetObjectID, 1));
  D.writeToFile(StrToNSStr(tmpFile),true);
  try
   Result:=TfgBitmap.Create;
   Result.LoadFromFile(tmpFile);
  finally
//   TFile.Delete(tmpFile);
  end;

end;

{$ENDIF}
function RotateBitmap(B:TfgBitmap;Sz:Double):TfgBitmap;
{$IFDEF IOS}
function CGRectMake(x: CGFloat; y: CGFloat; width: CGFloat; height: CGFloat): CGRect;
begin
  Result.origin.x := x;
  Result.origin.y := y;
  Result.size.width := width;
  Result.size.height := height;
end;


function rotatedImage(image:UIImage;rotation:CGFloat):UIImage; // rotation in radians
var
    t:CGAffineTransform;
    destRect,sizeRect:CGRect;
    destinationSize:CGSize;
    context:CGContextRef;
begin

    // Calculate Destination Size
    t:=CGAffineTransformMakeRotation(rotation);
    sizeRect:=CGRectMake(0,0,image.size.width,image.size.height);
    destRect:=CGRectApplyAffineTransform(sizeRect, t);
    destinationSize:=destRect.size;
    // Draw image
    UIGraphicsBeginImageContext(destinationSize);
     context:=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, destinationSize.width / 2.0, destinationSize.height / 2.0);
    CGContextRotateCTM(context, rotation);
    image.drawInRect(CGRectMake(-image.size.width / 2.0, -image.size.height / 2.0, image.size.width, image.size.height));
    result:=TUIImage.Wrap(UIGraphicsGetImageFromCurrentImageContext());
    UIGraphicsEndImageContext();
end;

{$ENDIF}
var
{$IFDEF ANDROID}
 M:JMatrix;
    BA,BA1:JBitmap;
{$ELSE}
  img:UIImage;
{$ENDIF}
begin
try
{$IFDEF ANDROID}
BA:=TfgAndroidBitmapHandle(B.Handle).NativeBitmap;
M:=TJMatrix.Create;
m.postRotate(Sz);
Ba1:=BA.copy(BA.getConfig,true);
BA1:=TJBitmap.createBitmap(BA1,0,0,BA1.getWidth,BA1.getHeight,m,true);
Result:=TfgBitmap.CreateFromNativeBitmap(BA1);
{$ELSE}
 img:=TUIImageHelper.Create(B);
 img:=rotatedImage(img,Sz*pi/180);
 Result:=UIImageToBitmap(img);

{$ENDIF}
finally
 B.Free;
end;
end;
function PrepareBitmapFromFile(FileName:String;Sz:Integer;var Lat,Lon:Double;PlaceDate:boolean=false):TfgBitmap;
var
    D:TfgRotation;
    B:TfgBitmap;
{$IFDEF ANDROID}
 E:JExifInterface;
    Orientation:Integer;
    Ar:IJavaArray<Single>;
{$ENDIF}
begin
{$IFDEF ANDROID}
  E:=TJExifInterface.Create(StringToJString(FileName));
  Orientation:=E.getAttributeInt(TJExifInterface.TAG_ORIENTATION,TJExifInterface.ORIENTATION_UNDEFINED);
  Ar:=TJavaArray<Single>.Create(2);
  if E.getLatLong(Ar) then
  begin
  Lat:=Ar[0];
  Lon:=Ar[1];
  end
  else
  begin
  Lat:=0;
  Lon:=0;

  end;
  if Orientation=TJExifInterface.ORIENTATION_ROTATE_180
  then
   D:=TfgRotation.Rotation180
  else
  if Orientation=TJExifInterface.ORIENTATION_ROTATE_90
  then
   D:=TfgRotation.Rotation90
  else
  if Orientation=TJExifInterface.ORIENTATION_ROTATE_270
  then
   D:=TfgRotation.Rotation270
  else
  D:=TfgRotation.Rotation0;
 {$ELSE}
  D:=TfgRotation.Rotation0;
  Lat:=0;
  Lon:=0;
 {$ENDIF}
  B:=TfgBitmap.CreateFromFile(FileName);
  try
   Result:=ResizeBitmap(B,Sz);
   if D<>TfgRotation.Rotation0 then Result.Rotate(D);
   if PlaceDate then
    begin
     Result.Canvas.BeginPaint;
     Result.Canvas.Font.Size:= 50;
     Result.Canvas.Fill.Color := TAlphaColorRec.White;
     Result.Canvas.Fill.Kind := TfgBrushKind.Solid;
     Result.Canvas.FillText(Result.Bounds, DateTimeToStr(now) ,False, TfgHorizontalAlignment.Right, TfgVerticalAlignment.Bottom);
     Result.Canvas.EndPaint;
    end;
  finally
   B.Free;
  end;
end;
function PhoneModel:String;

begin
{$IFDEF ANDROID}
   Result:=JStringToString(TJBuild.MANUFACTURER.toString)+' '+JStringToString(TJBuild.MODEL);
{$ELSE}
  Result:=Js2S(TfgiOSHelper.CurrentDevice.name)+' '+   Js2S(TfgiOSHelper.CurrentDevice.model);
{$ENDIF}

end;

end.
