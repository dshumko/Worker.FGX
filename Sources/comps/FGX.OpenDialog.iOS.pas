{*******************************************************}
{                                                       }
{        Delphi FireMonkey media store for IOS          }
{                                                       }
{ Copyright(c) 2012-2019 Embarcadero Technologies, Inc. }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FGX.OpenDialog.iOS;

interface

{$SCOPEDENUMS ON}



uses
  System.SysUtils,System.IoUtils, System.Classes, System.Types, System.Math, System.Generics.Collections,FGX.Controls.IOS, Macapi.ObjectiveC,FGX.Dialogs,iOS.Api.Helpers,
  iOS.Api.CoreGraphics,iOS.api.Foundation,iOS.Api.CocoaTypes, iOS.api.UIKit, System.TypInfo, IOS.Api.ObjCRuntime,FGX.Controls,FGX.Canvas,FGX.Canvas.IOS,FGX.Helpers.IOS,FGX.Screen;

type
  TImageDelegate = class;
  TiOSOpenDialog = class;
  TiOSOpenDialog = class
  private
    FProc: TProc<boolean>;
    FImageDelegate: UIImagePickerControllerDelegate;
    FImagePicker: UIImagePickerController;
    FFileName: String;
  protected
    procedure TakeImage(const ASourceType: UIImagePickerControllerSourceType);
  public
    constructor Create;
    destructor Destroy; override;
    class function IsAvailableSourceType(const ASourceType: UIImagePickerControllerSourceType): Boolean;
    { IFMXTakenImage }
    property FileName:String read FFileName;
    procedure Execute(FromCamera: boolean;AProc: TProc<boolean>);

  end;

  TImageDelegate = class(TOCLocal, UIImagePickerControllerDelegate)
  private
    [Weak] FImageManager: TiOSOpenDialog;
    function GetAngleOfImageOrientation(const AImage: UIImage): TfgRotation;
  protected
    procedure HidePicker(const APicker: UIImagePickerController);
  public
    constructor Create(const AImageManager: TiOSOpenDialog);
    { UIImagePickerControllerDelegate }
    [MethodName('imagePickerController:didFinishPickingMediaWithInfo:')]
    procedure imagePickerController(picker: UIImagePickerController; info: NSDictionary); overload; cdecl;
    [MethodName('imagePickerController:didFinishPickingImage:editingInfo:')]
    procedure imagePickerController(picker: UIImagePickerController; image: UIImage; editingInfo: NSDictionary); overload; cdecl; // API_DEPRECATED("", ios(2.0, 3.0))
    procedure imagePickerControllerDidCancel(picker: UIImagePickerController); cdecl;


  end;
  TImageZoomDelegate=class(TOCLocal,UIScrollViewDelegate)
  private
    [Weak] FImg:UIImageView;
  public
    constructor Create(const AScroll: UIScrollView;const AImg: UIImageView);
    procedure scrollViewDidChangeAdjustedContentInset(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidEndDecelerating(scrollView: UIScrollView); cdecl;
    [MethodName('scrollViewDidEndDragging:willDecelerate:')]
    procedure scrollViewDidEndDragging(scrollView: UIScrollView; decelerate: Boolean); cdecl;
    procedure scrollViewDidEndScrollingAnimation(scrollView: UIScrollView); cdecl;
    [MethodName('scrollViewDidEndZooming:withView:atScale:')]
    procedure scrollViewDidEndZooming(scrollView: UIScrollView; view: UIView; scale: CGFloat); cdecl;
    procedure scrollViewDidScroll(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidScrollToTop(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidZoom(scrollView: UIScrollView); cdecl;
    function scrollViewShouldScrollToTop(scrollView: UIScrollView): Boolean; cdecl;
    procedure scrollViewWillBeginDecelerating(scrollView: UIScrollView); cdecl;
    procedure scrollViewWillBeginDragging(scrollView: UIScrollView); cdecl;
    [MethodName('scrollViewWillBeginZooming:withView:')]
    procedure scrollViewWillBeginZooming(scrollView: UIScrollView; view: UIView); cdecl;
    [MethodName('scrollViewWillEndDragging:withVelocity:targetContentOffset:')]
    procedure scrollViewWillEndDragging(scrollView: UIScrollView; velocity: CGPoint; targetContentOffset: PCGPoint); cdecl;
    function viewForZoomingInScrollView(scrollView: UIScrollView): UIView; cdecl;
  end;
  IFMXShareSheetActionsService = interface
  ['{79FCC7B1-C5BF-4533-B31E-084F1A6E2264}']
    procedure Share(const AControl: TfgControl; const AText: string; const AImage: TfgBitmap);
  end;

  TShareService = class(TInterfacedObject, IFMXShareSheetActionsService)
  strict private
    FActivityViewController: UIActivityViewController;
    FActivityItems: NSMutableArray;
    FPopoverController: UIPopoverController;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReleaseOldSharingController;
    { IFMXShareSheetActionsService }
    procedure Share(const AControl: TfgControl; const AText: string; const ABitmap: TfgBitmap);
  end;
function UIImageToBitmap(img:UIImage):TfgBitmap;
implementation

constructor TiOSOpenDialog.Create;
begin
  inherited Create;
  FImageDelegate := TImageDelegate.Create(Self);

end;

destructor TiOSOpenDialog.Destroy;
begin
  if FImagePicker <> nil then
  begin
    FImagePicker.release;
    FImagePicker.setDelegate(nil);
  end;
  FImageDelegate:=nil;
  inherited Destroy;
end;

class function TiOSOpenDialog.IsAvailableSourceType(const ASourceType: UIImagePickerControllerSourceType): Boolean;
begin
  Result := TUIImagePickerController.OCClass.isSourceTypeAvailable(ASourceType);
end;




function CGRectMake(x: CGFloat; y: CGFloat; width: CGFloat; height: CGFloat): CGRect;
begin
  Result.origin.x := x;
  Result.origin.y := y;
  Result.size.width := width;
  Result.size.height := height;
end;


procedure TiOSOpenDialog.TakeImage(const ASourceType: UIImagePickerControllerSourceType);

  procedure ShowInFullScreen;
  var
    Window: UIWindow;
  begin

    Window :=TfgIosHelper.SharedApplication.keyWindow;
    if (Window <> nil) and (Window.rootViewController <> nil) then
      Window.rootViewController.presentModalViewController(FImagePicker, True);
  end;
  procedure ShowPicker;
  begin
    // Camera for iPad is showed only in full screen on iPad and iPhone
      ShowInFullScreen
  end;

begin
  if IsAvailableSourceType(ASourceType) then
  begin
    if FImagePicker <> nil then
    begin
      FImagePicker.setDelegate(nil);
      FImagePicker.release;
    end;
    FImagePicker := TUIImagePickerController.Create;
    FImagePicker.retain;
    FImagePicker.setDelegate(TImageDelegate(FImageDelegate).GetObjectID);
    FImagePicker.setSourceType(ASourceType);
    FImagePicker.setAllowsEditing(False);
    ShowPicker;
  end;
end;

procedure TiOSOpenDialog.Execute(FromCamera:boolean;AProc:TProc<boolean>);
begin
 FProc:=AProc;
 if FromCamera then
  TakeImage(UIImagePickerControllerSourceTypeCamera)
 else
  TakeImage(UIImagePickerControllerSourceTypePhotoLibrary)
end;

{ TImageDelegate }

constructor TImageDelegate.Create(const AImageManager: TiOSOpenDialog);
begin
  inherited Create;
  FImageManager := AImageManager;
end;



procedure TImageDelegate.HidePicker(const APicker: UIImagePickerController);
begin
    APicker.dismissModalViewControllerAnimated(True);
end;
function UIImageJPEGRepresentationEx(image: Pointer; compressionQuality: CGFloat): Pointer; cdecl;
  external libUIKit name _PU + 'UIImageJPEGRepresentation';
function TImageDelegate.GetAngleOfImageOrientation(const AImage: UIImage): TfgRotation;
begin
  case AImage.imageOrientation of
    UIImageOrientationDown,
    UIImageOrientationDownMirrored:
      Result := TfgRotation.Rotation180;
    UIImageOrientationLeft,
    UIImageOrientationLeftMirrored:
      Result := TfgRotation.Rotation270;
    UIImageOrientationRight,
    UIImageOrientationRightMirrored:
      Result := TfgRotation.Rotation90;
    UIImageOrientationUp,
    UIImageOrientationUpMirrored:
      Result := TfgRotation.Rotation0;
  else
    Result := TfgRotation.Rotation0;
  end;
end;

procedure TImageDelegate.imagePickerController(picker: UIImagePickerController; image: UIImage;
  editingInfo: NSDictionary);
var
  D:NSData;
  R:TfgRotation;
  B:TfgBitmap;
begin
  HidePicker(picker);
  FImageManager.FFileName:=TPath.GetTempFileName+'.jpg';
  R:=GetAngleOfImageOrientation(image);
  D:=TNSData.Wrap(UIImageJPEGRepresentationEx((image as ILocalObject).GetObjectID, 1));
  D.writeToFile(  StrToNSStr(FImageManager.FileName),true);
  if R<>TfgRotation.Rotation0 then
  begin
  B:=TfgBitmap.Create;
  try
  B.LoadFromFile(FImageManager.FFileName);
  B.Rotate(R);
  B.SaveToFile(FImageManager.FFileName);
  finally
   B.Free;
  end;
  end;
end;
function UIImageToBitmap(img:UIImage):TfgBitmap;
var tmpFile:String;
    D:NSData;
    M:TMemoryStream;
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

procedure TImageDelegate.imagePickerController(picker: UIImagePickerController; info: NSDictionary);
var
  ImageTmp: UIImage;
  //NewImg: UIImage;
  D:NSData;
   R:TfgRotation;
  B:TfgBitmap;
  TmpName:String;
begin
  HidePicker(picker);
  ImageTmp := TUIImage.Wrap(info.objectForKey((UIImagePickerControllerOriginalImage as ILocalObject).GetObjectID));
  R:=GetAngleOfImageOrientation(imageTmp);
//  TUIImage.OCClass.imageWithCIImage(ImageTmp.CIImage,1.0,ImageTmp.imageOrientation);
  FImageManager.FFileName:=TPath.GetTempFileName+'.jpg';
  D:=TNSData.Wrap(UIImageJPEGRepresentation(NSObjectToID(ImageTmp), 1));
  D.writeToFile(  StrToNSStr(FImageManager.FileName),true);
  if R<>TfgRotation.Rotation0 then
  begin
  B:=TfgBitmap.Create;
  try
  B.LoadFromFile(FImageManager.FFileName);
  B.Rotate(R);
  Tfile.Delete(FImageManager.FFileName);
  FImageManager.FFileName:=TPath.GetTempFileName+'.jpg';
  B.SaveToFile(FImageManager.FFileName);
  finally
   B.Free;
  end;
  end;
  if Assigned(FImageManager.FProc)
  then
  FImageManager.FProc(True);
end;

procedure TImageDelegate.imagePickerControllerDidCancel(picker: UIImagePickerController);
begin
  HidePicker(picker);
  if Assigned(FImageManager.FProc)
  then
  FImageManager.FProc(False);
end;

{ TSharingService }

constructor TShareService.Create;
begin
  inherited;
  FActivityItems := TNSMutableArray.Create;
end;

destructor TShareService.Destroy;
begin
  ReleaseOldSharingController;
  FActivityItems.release;
  inherited;
end;

procedure TShareService.ReleaseOldSharingController;
var
  Pop: UIPopoverController;
begin
  if FPopoverController <> nil then
    FPopoverController.release;
  Pop := FPopoverController;

  if FActivityViewController <> nil then
  begin
    FActivityViewController.release;
    FActivityViewController := nil;
  end;
end;
procedure TShareService.Share(const AControl: TfgControl; const AText: string; const ABitmap: TfgBitmap);

  procedure ShowForPhone;
  var
    Window: UIWindow;
  begin
    Window := TfgIOSHelper.SharedApplication.keyWindow;
    if (Window <> nil) and (Window.rootViewController <> nil) then
      Window.rootViewController.presentModalViewController(FActivityViewController, True);
  end;

  procedure ShowForPad;
  var
    Window: UIWindow;
    PopoverRect: CGRect;
    AbsolutePos: TPointF;
  begin
    Window := TfgIOSHelper.SharedApplication.keyWindow;
    if AControl <> nil then
    begin
      AbsolutePos := AControl.LocalToForm(PointF(0, 0));
      PopoverRect := CGRectMake(AbsolutePos.X, AbsolutePos.Y, AControl.Width, AControl.Height);
    end
    else
      PopoverRect := CGRectMake(0, 0, 0, 0);
    FPopoverController := TUIPopoverController.Alloc;
    FPopoverController.initWithContentViewController(FActivityViewController);
    FPopoverController.presentPopoverFromRect(PopoverRect, Window.rootViewController.View, UIPopoverArrowDirectionAny, True);
  end;

  procedure ShowActionsSheet;
  begin
    if TfgiOSHelper.IsIPad then
      ShowForPad
    else
      ShowForPhone;
  end;

var
  OCImage: UIImage;
begin
  Assert((ABitmap <> nil) or not AText.IsEmpty);
  FActivityItems.removeAllObjects;

  if not AText.IsEmpty then
    FActivityItems.addObject((StrToNSStr(AText) as ILocalObject).GetObjectID);

  if (ABitmap <> nil) and not ABitmap.IsEmpty then
  begin
    OCImage := TUIImageHelper.Create(ABitmap);
    FActivityItems.addObject((OCImage as ILocalObject).GetObjectID);
  end;

  try
    if FActivityItems.count > 0 then
    begin
      ReleaseOldSharingController;
      FActivityViewController := TUIActivityViewController.alloc;
      FActivityViewController.initWithActivityItems(FActivityItems , nil);
      ShowActionsSheet;
    end;
  finally
    //if OCImage <> nil then
    //  OCImage.release;
  end;
end;


{ TImageZoomDelegate }

constructor TImageZoomDelegate.Create(const AScroll: UIScrollView;const AImg: UIImageView);
begin
 inherited Create;
 FImg:=AImg;
 AScroll.setDelegate(Self.GetObjectID);
end;

procedure TImageZoomDelegate.scrollViewDidChangeAdjustedContentInset(
  scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewDidEndDecelerating(
  scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewDidEndDragging(scrollView: UIScrollView;
  decelerate: Boolean);
begin

end;

procedure TImageZoomDelegate.scrollViewDidEndScrollingAnimation(
  scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewDidEndZooming(scrollView: UIScrollView;
  view: UIView; scale: CGFloat);
begin

end;

procedure TImageZoomDelegate.scrollViewDidScroll(scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewDidScrollToTop(scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewDidZoom(scrollView: UIScrollView);
begin

end;

function TImageZoomDelegate.scrollViewShouldScrollToTop(
  scrollView: UIScrollView): Boolean;
begin
 Result:=true;
end;

procedure TImageZoomDelegate.scrollViewWillBeginDecelerating(
  scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewWillBeginDragging(
  scrollView: UIScrollView);
begin

end;

procedure TImageZoomDelegate.scrollViewWillBeginZooming(
  scrollView: UIScrollView; view: UIView);
begin

end;

procedure TImageZoomDelegate.scrollViewWillEndDragging(scrollView: UIScrollView;
  velocity: CGPoint; targetContentOffset: PCGPoint);
begin

end;

function TImageZoomDelegate.viewForZoomingInScrollView(
  scrollView: UIScrollView): UIView;
begin
   Result:= TUIView.Wrap((FImg as ILocalObject).GetObjectID );
end;

end.
