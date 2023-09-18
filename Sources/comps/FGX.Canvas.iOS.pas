{*********************************************************************
 *
 * Copyright © 2020, Brovin Yaroslav
 * All rights reserved
 *
 * Autor: Brovin Y.D.
 * E-mail: y.brovin@gmail.com
 * Date: 26.03.2020
 *
 *********************************************************************}

unit FGX.Canvas.iOS;

{$SCOPEDENUMS ON}

interface

uses
  System.UITypes, System.Types, System.Classes, iOS.Api.UIKit, iOS.Api.CoreText, iOS.Api.Foundation, iOS.Api.CocoaTypes,
  iOS.Api.CoreGraphics, iOS.Api.CoreFoundation, FGX.Canvas.Types, FGX.Canvas, FGX.Text;

resourcestring
{$IFDEF ENG}
  SLoadingBitmapFromFile = 'Loading bitmap from file: fileName="%s"';
  SCannotLoadBitmapFromFile = 'Bitmap loading is failed: fileName="%s"';
  SCannotLoadBitmapFromStream = 'Bitmap is not loaded from stream.';
  SCannotSaveBitmapToStream = 'Cannot save bitmap to stream.';
{$ELSE}
  SLoadingBitmapFromFile = 'Загрузка битмапа из файла: fileName="%s"';
  SCannotLoadBitmapFromFile = 'Не удалось загрузить битмап из файла: fileName="%s"';
  SCannotLoadBitmapFromStream = 'Не удалось загрузить битмап из потока.';
  SCannotSaveBitmapToStream = 'Не удалось сохранить битмап в поток.';
{$ENDIF}

type
  TfgiOSBitmapService = class(TInterfacedObject, IFGXBitmapService)
  private type
    TfgImagePresentation = (JPEG, PNG, Unkown);
  private
    class function DataFromImage(const AImage: UIImage; const APresentation: TfgImagePresentation;
                                 const AParams: TfgBitmapSaveParams): NSData;
    class function DefineImagePresentation(const AFileName: string): TfgImagePresentation;
  public
    { IFGXBitmapService }
    function CreateBitmap(const AWidth: Integer; const AHeight: Integer): TfgBitmapHandle;
    function CreateFromBitmap(const AHandle: TfgBitmapHandle): TfgBitmapHandle;
    function CreateHandleForNativeBitmap(const ANativeBitmap: IInterface; out ANewSize: TSize): TfgBitmapHandle;
    function CreateCanvasForBitmap(const AHandle: TfgBitmapHandle): TfgCanvas;
    function LoadFromFile(const AHandle: TfgBitmapHandle; const AFileName: string; out ANewSize: TSize): Boolean;
    function LoadFromStream(const AHandle: TfgBitmapHandle; const AStream: TStream; out ANewSize: TSize): Boolean;
    function SaveToFile(const AHandle: TfgBitmapHandle; const AFileName: string; const AParams: TfgBitmapSaveParams): Boolean;
    function SaveToStream(const AHandle: TfgBitmapHandle; const AStream: TStream; const AFormat: TfgImageFormat;
                          const AParams: TfgBitmapSaveParams): Boolean;
    procedure SetSize(const AHandle: TfgBitmapHandle; const AWidth: Integer; const AHeight: Integer);
    procedure SetScale(const AHandle: TfgBitmapHandle; const AScale: Single);
    function GetBitmapMaxSize: TSize;
    procedure ApplyTintColor(const AHandle: TfgBitmapHandle; const ATintColor: TAlphaColor);
  end;

  TfgiOSBitmapHandle = class(TfgBitmapHandle)
  private class var
    FColorSpaceRGB: CGColorSpaceRef;
  private
    FImageRef: CGImageRef; // Strong reference
    FScale: Single;
    procedure SetImageRef(const Value: CGImageRef);
    procedure SetImageRefWithoutRetain(const Value: CGImageRef);
    procedure ReleaseImageRef;
    class constructor Create;
    class destructor Destroy;
    function GetSize: TSize;
    function CreateNewContext(const ASize: TSize): CGContextRef;
  protected
    function GetNativeBitmap: IInterface; override;
  public
    constructor Create(const AImageRef: CGImageRef; const AScale: Single); overload;
    constructor Create(const AWidth, AHeight: Integer; const AScale: Single); overload;
    destructor Destroy; override;

    procedure SetSize(const AWidth, AHeight: Integer);
    function CreateContext: CGContextRef;
    function CreateCopy(const ASourceRect: TRect; const ASize: TSize): CGImageRef;
    procedure DrawOnto(const AContext: CGContextRef; const ASourceRect: TRect; const ADestRect: TRectF);
    procedure ApplyTintColor(const ATintColor: TAlphaColor);

    property Scale: Single read FScale write FScale;
    /// <summary>Сильная ссылка на изображение CoreGraphics.</summary>
    property ImageRef: CGImageRef read FImageRef write SetImageRef;
    property Size: TSize read GetSize;
  end;

{ TfgiOSCanvas }

  TfgiOSCanvas = class(TfgCanvas)
  private type
    TfgBrushState = (OutdateFill, OutdateStroke, OutdateFont);
    TfgBrushStates = set of TfgBrushState;

    TfgArcParameters = record
      StartAngle: Single;
      EndAngle: Single;
      Radius: Single;
      ClockwiseMode: Boolean;
      Transform: CGAffineTransform;
    end;
  private
    FContext: CGContextRef;
    FContextSize: TSizeF;
    FStrokeGradient: CGGradientRef;
    FFillGradient: CGGradientRef;
    FBrushState: TfgBrushStates;
    FBitmapHandle: TfgiOSBitmapHandle;
    procedure FgPathToPath(const ASource: TfgPath; const ADest: CGMutablePathRef);
    procedure MakeNativeGradientFromFgGradient(const ASource: TfgGradient; var ADest: CGGradientRef);
    procedure ReleaseGradient(var ASource: CGGradientRef);
    procedure UpdateStrokeBrushIfNeeded;
    procedure UpdateFillBrushIfNeeded;
    procedure DrawStrokeGradientPath(const ARect: TRectF);
    procedure DrawFillGradientPath(const ARect: TRectF);
    function AdaptRectForStrokeThickness(const ARect: TRectF): TRectF;
    function IsBitmapCanvas: Boolean; inline;
    function CreateNativeDashPattern: TArray<CGFloat>;
    function GetArcParameters(const ARect: TRectF; const AStartAngle, ASweepAngle: Single): TfgArcParameters;
    procedure NormalizeCoordinateSystem(const AContext: CGContextRef; const AScale, AHeight: Single);
    function CreateMask(const AMask: TfgiOSBitmapHandle; const AMaskSourceRect: TRect; const AMaskDestRect: TRectF; const ASize: TSize): CGImageRef;
    function CreateMaskedImage(const ASize: TSize; const ABitmap: TfgiOSBitmapHandle; const ASourceRect: TRect;
      const AMask: TfgiOSBitmapHandle; const AMaskSourceRect: TRect; const AMaskDestRect: TRectF): CGImageRef;
  protected
    procedure DoDrawPoint(const APoint: TPointF); override;
    procedure DoDrawPoints(const APoints: TfgPoints); override;
    procedure DoDrawLine(const APt1, APt2: TPointF); override;
    procedure DoDrawLines(const APoints: TfgPoints); override;
    procedure DoDrawCircle(const ACenter: TPointF; const ARadius: Single); override;
    procedure DoDrawEllipse(const ARect: TRectF); override;
    procedure DoDrawBitmap(const ABitmap: TfgBitmap; const ASourceRect: TRect; const ADestRect: TRectF); override;
    procedure DoDrawPath(const APath: TfgPath); override;
    procedure DoDrawRect(const ARect: TRectF); override;
    procedure DoDrawArc(const ARect: TRectF; const StartAngle, SweepAngle: Single); override;
    procedure DoDrawBitmapWithMask(const ABitmap: TfgBitmap; const ASourceRect: TRect; const ADestRect: TRectF;
      const AMask: TfgBitmap; const AMaskSourceRect: TRect; const AMaskDestRect: TRectF); override;

    procedure DoFillColor(const AColor: TAlphaColor); override;
    procedure DoFillPolygon(const APolygon: TfgPoints); override;
    procedure DoFillRect(const ARect: TRectF); override;
    procedure DoFillRoundRect(const ARect: TRectF; const RX, RY: Single); override;
    procedure DoFillCircle(const ACenter: TPointF; const ARadius: Single); override;
    procedure DoFillEllipse(const ARect: TRectF); override;
    procedure DoFillPath(const APath: TfgPath); override;
    procedure DoFillText(const ARect: TRectF; const AText: string; const WordWrap: Boolean;
                         const AHorizontalAlign: TfgHorizontalAlignment = TfgHorizontalAlignment.Center;
                         const AVerticalAlign: TfgVerticalAlignment = TfgVerticalAlignment.Center); override;
    function DoMeasureText(const AText: string; const AMaxSize: TSizeF; const AWordWrap: Boolean): TSizeF; override;
    function GetHeight: Single; override;
    function GetWidth: Single; override;
    procedure DoBeginPaint; override;
    procedure DoEndPaint; override;

    procedure FillBrushChanged(const AFill: TfgBrush); override;
    procedure StrokeBrushChanged(const AStroke: TfgStrokeBrush); override;
    procedure FontChanged(const AFont: TfgFont); override;
  public
    constructor CreateForContext(const AContext: CGContextRef; const AContextSize: TSizeF);
    constructor CreateForBitmap(const ABitmapHandle: TfgiOSBitmapHandle);
    destructor Destroy; override;
//    property ScreenScale: Single read FScreenScale;

    property NativeContext: CGContextRef read FContext;
  end;

  TfgiOSTextRender = record
  private
  type
    TTextAttributes = record
      Handle: CFMutableAttributedStringRef;
      Range: CFRange;
    end;

    TTextSettings = record
      Font: TfgFont;
      Color: TAlphaColor;
      WordWrap: Boolean;
      HorizontalAlign: TfgHorizontalAlignment;
      VerticalAlign: TfgVerticalAlignment;
    end;

    class procedure SetupFont(const AAttributes: TTextAttributes; const AFont: TfgFont); static;
    class procedure SetupTextColor(const AAttributes: TTextAttributes; const AFontColor: TAlphaColor); static;
    class procedure SetupParagraph(const AAttributes: TTextAttributes; const AWordWrap: Boolean; const AHorizontalAlign: TfgHorizontalAlignment); static;
    class procedure SetupVerticalAlignment(const AContext: CGContextRef; const AFrameSize, ATextSize: TSizeF; const AVerticalAlign: TfgVerticalAlignment); static;
    class procedure SetupHorizontalAlignment(const AContext: CGContextRef; const AFrameSize, ATextSize: TSizeF; const AHorizontalAlign: TfgHorizontalAlignment); static;
    class function CreateAttributes(const AText: string): TTextAttributes; static;
    class function CreateFrameSetter(const AText: string; const ATextSettings: TTextSettings): CTFramesetterRef; static;
    class function CreateFrame(const AContext: CGContextRef; const AText: string; const AFrameSize: TSizeF; const ATextSettings: TTextSettings): CTFrameRef; static;
    class procedure PrepareContextCoordinates(const ACanvas: TfgiOSCanvas; const ARect: TRectF); static;
    class function MeasureTextSize(const AFrameSetter: CTFramesetterRef; const AText: string; const AMaxWidth: Single): TSizeF; static;
  public
    class procedure FillText(const ACanvas: TfgiOSCanvas; const ARect: TRectF; const AText: string;
      const AWordWrap: Boolean; const AHorizontalAlign: TfgHorizontalAlignment; const AVerticalAlign: TfgVerticalAlignment); static;
    class function MeasureText(const ACanvas: TfgiOSCanvas; const AText: string; const AMaxSize: TSizeF;
      const AWordWrap: Boolean): TSizeF; static;
  end;

{ TfgiOSGraphicsRender }

  TfgiOSGraphicsRenderCallback = reference to procedure (rendererContext: UIGraphicsImageRendererContext);

  /// <summary>Оболочка над <c>UIGraphicsImageRenderer</c>, позволяющая использовать анонимные функции Delphi.</summary>
  TfgiOSGraphicsImageRender = class
  private
    FRender: UIGraphicsImageRenderer;
    FCallback: TfgiOSGraphicsRenderCallback;
    { Handler }
    procedure RenderBlock(rendererContext: UIGraphicsImageRendererContext);
  private
    constructor Create(const ASize: TSizeF);
    function Render(const ARenderCallback: TfgiOSGraphicsRenderCallback): UIImage; overload;
  public
    class function Render(const ASize: TSizeF; const ARenderCallback: TfgiOSGraphicsRenderCallback): UIImage; overload;
  end;

function FontToUIFont(const AFont: TfgFont): UIFont;
function FontToCTFontRef(const AFont: TfgFont): CTFontRef;
function BitmapToUIImage(const ABitmap: TfgBitmap): UIImage;

implementation

uses
  System.SysUtils, System.Math, Macapi.ObjectiveC, iOS.Api.Helpers, FGX.Asserts, FGX.Log, FGX.SystemInfo,
  FGX.Platform;

function GetFontName(const AFont: TfgFont): string;
const
  BoldStyleSuffix = '-Bold'; //Do not localize
  BoldItalicStyleSuffix = '-BoldOblique'; //Do not localize
  ItalicStyleSuffix = '-Oblique'; //Do not localize
begin
  if (TFontStyle.fsBold in AFont.Style) and (TFontStyle.fsItalic in AFont.Style) then
    Result := AFont.Family + BoldItalicStyleSuffix
  else if TFontStyle.fsBold in AFont.Style then
    Result := AFont.Family + BoldStyleSuffix
  else if TFontStyle.fsItalic in AFont.Style then
    Result := AFont.Family + ItalicStyleSuffix
  else
    Result := AFont.Family;
end;

function FontToCTFontRef(const AFont: TfgFont): CTFontRef;
const
  FontFaceBold = 'Bold';
  FontFaceItalic = 'Italic';

  function StyleToString(const AStyle: TFontStyles): string;
  begin
    if [TFontStyle.fsBold, TFontStyle.fsItalic] * AStyle = [TFontStyle.fsBold, TFontStyle.fsItalic] then
      Result := FontFaceBold + ' ' + FontFaceItalic
    else if TFontStyle.fsBold in AStyle then
      Result := FontFaceBold
    else if TFontStyle.fsItalic in AStyle then
      Result := FontFaceItalic
    else
      Result := string.Empty;
  end;

  function FontAttributeToKey(const AValue: CFStringRef): NSString;
  begin
    Result := TNSString.Wrap(AValue);
  end;

var
  LFontAttributes: NSMutableDictionary;
  LDescriptor: CTFontDescriptorRef;
  FontSize: Single;
  SystemFont: UIFont;
  FontFamily: string;
begin
  LFontAttributes := TNSMutableDictionary.Wrap(TNSMutableDictionary.OCClass.dictionaryWithCapacity(3));

  { Size }
  if TfgFont.TfgFontParameter.Size in AFont.Default then
    FontSize := TUIFont.OCClass.systemFontSize
  else
  begin
    FontSize := AFont.Size;
    LFontAttributes.setValue(DoubleToID(FontSize), FontAttributeToKey(kCTFontSizeAttribute));
  end;

  { Family Name }
  SystemFont := TUIFont.OCClass.systemFontOfSize(FontSize);
  if TfgFont.TfgFontParameter.Family in AFont.Default then
    // Очень важно здесь указать системное название шрифта по умолчанию, иначе iOS подберет другой не системный шрифт
    FontFamily := NSStrToStr(SystemFont.familyName)
  else
    FontFamily := AFont.Family;
  LFontAttributes.setValue(StringToID(FontFamily), FontAttributeToKey(kCTFontFamilyNameAttribute));

  { Style }
  if not (TfgFont.TfgFontParameter.Style in AFont.Default) then
    LFontAttributes.setValue(StringToID(StyleToString(AFont.Style)), FontAttributeToKey(kCTFontStyleNameAttribute));

  LDescriptor := CTFontDescriptorCreateWithAttributes(NSObjectToID(LFontAttributes));
  try
    Result := CTFontCreateWithFontDescriptor(LDescriptor, FontSize, nil);
  finally
    CFRelease(LDescriptor);
  end;
end;

function FontToUIFont(const AFont: TfgFont): UIFont;
var
  FontRef: CTFontRef;
begin
  FontRef := FontToCTFontRef(AFont);
  Result := TUIFont.Wrap(FontRef);
  {TODO -oViktor -cGeneral : Надо релизить FontRef?}
end;

function BitmapToUIImage(const ABitmap: TfgBitmap): UIImage;
var
  ImageRef: CGImageRef;
begin
  TfgAssert.IsNotNil(ABitmap, 'ABitmap');

  ImageRef := TfgiOSBitmapHandle(ABitmap.Handle).ImageRef;
  Result := TUIImage.OCClass.imageWithCGImage(ImageRef, ABitmap.Scale, UIImageOrientationUp);
end;

{ TfgiOSBitmapService }

procedure TfgiOSBitmapService.ApplyTintColor(const AHandle: TfgBitmapHandle; const ATintColor: TAlphaColor);
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);

  TfgiOSBitmapHandle(AHandle).ApplyTintColor(ATintColor);
end;

function TfgiOSBitmapService.CreateBitmap(const AWidth, AHeight: Integer): TfgBitmapHandle;
begin
  TfgAssert.MoreAndEqualThan(AWidth, 0);
  TfgAssert.MoreAndEqualThan(AHeight, 0);

  Result := TfgiOSBitmapHandle.Create(AWidth, AHeight, 1.0);
end;

function TfgiOSBitmapService.CreateFromBitmap(const AHandle: TfgBitmapHandle): TfgBitmapHandle;
var
  ImageRef: CGImageRef;
  CopiedImageRef: CGImageRef;
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);

  ImageRef := TfgiOSBitmapHandle(AHandle).ImageRef;
  CopiedImageRef := CGImageCreateCopy(ImageRef);
  if CopiedImageRef = nil then
    raise EfgBitmap.Create('Cannot create copy of bitmap. Cannot allocate CGImage.');
  try
    Result := TfgiOSBitmapHandle.Create(CopiedImageRef, 1.0);
  finally
    CFRelease(CopiedImageRef);
  end;
end;

function TfgiOSBitmapService.CreateHandleForNativeBitmap(const ANativeBitmap: IInterface;
  out ANewSize: TSize): TfgBitmapHandle;
begin
  { TODO -cTfgCanvas : Implement }
  Result := nil;
end;

function TfgiOSBitmapService.CreateCanvasForBitmap(const AHandle: TfgBitmapHandle): TfgCanvas;
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);

  Result := TfgiOSCanvas.CreateForBitmap(TfgiOSBitmapHandle(AHandle));
end;

class function TfgiOSBitmapService.DataFromImage(const AImage: UIImage; const APresentation: TfgImagePresentation;
  const AParams: TfgBitmapSaveParams): NSData;
var
  ImageId: id;
  DataId: id;
begin
  ImageId := NSObjectToId(AImage);
  case APresentation of
    TfgImagePresentation.JPEG:
      DataId := UIImageJPEGRepresentation(ImageId, AParams.Quality / 100);
    TfgImagePresentation.PNG:
      DataId := UIImagePNGRepresentation(ImageId);
  else
    raise EfgAssertError.CreateFmt(SUnknownValue, ['TfgImagePresentation']);
  end;

  Result := TNSData.Wrap(DataId);
end;

class function TfgiOSBitmapService.DefineImagePresentation(const AFileName: string): TfgImagePresentation;
var
  Extension: string;
begin
  Extension := ExtractFileExt(AFileName).ToLower;
  if (Extension = '.jpg') or (Extension = '.jpeg') then
    Result := TfgImagePresentation.JPEG
  else if Extension = '.png' then
    Result := TfgImagePresentation.PNG
  else
    Result := TfgImagePresentation.Unkown;
end;

function TfgiOSBitmapService.GetBitmapMaxSize: TSize;
begin
  Result.Width := Integer.MaxValue;
  Result.Height := Integer.MaxValue;
end;

function TfgiOSBitmapService.LoadFromFile(const AHandle: TfgBitmapHandle; const AFileName: string;
  out ANewSize: TSize): Boolean;
type
  TfgOwnership = (SystemCache, Our);

  function TryLoadUIImage(const AFileName: string; out AImage: UIImage; out AOwnership: TfgOwnership): Boolean;
  var
    FileName: NSString;
  begin
    FileName := StrToNSStr(AFileName);

    // Вначале пробуем загрузить файл из бандла.
    AImage := TUIImage.OCClass.imageNamed(FileName);
    // Вообще по документации написано, что метод может вернуть nil, если файла нет. Однако, это не так. Он всегда
    // возвращает инстанс, но если файла нет у него CGImage = nil.
    if (AImage = nil) or (AImage.CGImage = nil) then
    begin
      // В бандле нету изображения, поэтому считываем файл напрямую
      AImage := TUIImage.OCClass.imageWithContentsOfFile(FileName);
      if (AImage <> nil) and (AImage.CGImage = nil) then
        AImage := nil;
      AOwnership := TfgOwnership.Our;
    end
    else
      // https://stackoverflow.com/questions/1499793/release-a-retain-uiimage-property-loaded-via-imagenamed
      AOwnership := TfgOwnership.SystemCache;
    Result := AImage <> nil;
  end;

var
  Image: UIImage;
  NormalizedFileName: string;
  Handle: TfgiOSBitmapHandle;
  LImageRef: CGImageRef;
  Ownership: TfgOwnership;
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);

  NormalizedFileName := AFileName.Replace('\', '/');
  Result := TryLoadUIImage(NormalizedFileName, Image, Ownership);
  if Result then
  begin
    try
      LImageRef := CGImageCreateCopy(Image.CGImage);
    finally
      if Ownership = TfgOwnership.Our then
      begin
        Image.release;
        Image := nil;
      end;
    end;
    Handle := TfgiOSBitmapHandle(AHandle);
    Handle.SetImageRefWithoutRetain(LImageRef);
    ANewSize := Handle.Size;
  end
  else
    TfgLog.Warning(SCannotLoadBitmapFromFile, [NormalizedFileName]);
end;

function TfgiOSBitmapService.LoadFromStream(const AHandle: TfgBitmapHandle; const AStream: TStream;
  out ANewSize: TSize): Boolean;
var
  Image: UIImage;
  MemStream: TMemoryStream;
  Data: NSData;
  Handle: TfgiOSBitmapHandle;
  ImageRef: CGImageRef;
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);
  TfgAssert.IsNotNil(AStream, 'AStream');

  MemStream := TMemoryStream.Create;
  try
    MemStream.CopyFrom(AStream, AStream.Size);
    MemStream.Position := 0;
    Data := TNSData.Wrap(TNSData.alloc.initWithBytes(MemStream.Memory, MemStream.Size));
   // Data := TNSData.Wrap(TNSData.alloc.initWithBytesNoCopy(MemStream.Memory, MemStream.Size, False));
  finally
    MemStream.Free;
  end;

  try
    if Data.length > 0 then
    begin
      Image := TUIImage.Wrap(TUIImage.alloc.initWithData(Data));
      if Image = nil then
      begin
        TfgLog.Warning(SCannotLoadBitmapFromStream);
        Exit(False);
      end;
    end
    else
      Exit(False);
  finally
    Data.release;
  end;

  try
    Handle := TfgiOSBitmapHandle(AHandle);
    ImageRef := CGImageCreateCopy(Image.CGImage);
    Handle.ImageRef := ImageRef;
  finally
    Image.release;
    Image := nil;
  end;
  ANewSize := Handle.Size;
  Result := True;
end;

function TfgiOSBitmapService.SaveToFile(const AHandle: TfgBitmapHandle; const AFileName: string; const AParams: TfgBitmapSaveParams): Boolean;
var
  Data: NSData;
  Image: UIImage;
  ImageRef: CGImageRef;
  Stream: TStream;
  Presentation: TfgImagePresentation;
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);

  ImageRef := TfgiOSBitmapHandle(AHandle).ImageRef;
  Image := TUIImage.Wrap(TUIImage.alloc.initWithCGImage(ImageRef));
  if Image = nil then
  begin
    TfgLog.Error(SCannotSaveBitmapToStream);
    Exit(False);
  end;

  try
    Stream := TFileStream.Create(AFileName, fmCreate);
    try
      Presentation := DefineImagePresentation(AFileName);
      Data := DataFromImage(Image, Presentation, AParams);
      Stream.WriteBuffer(Data.bytes^, Data.length);
    finally
      Stream.Free;
    end;
  finally
    Image.release;
    Image := nil;
  end;
  Result := True;
end;

function TfgiOSBitmapService.SaveToStream(const AHandle: TfgBitmapHandle; const AStream: TStream;
  const AFormat: TfgImageFormat; const AParams: TfgBitmapSaveParams): Boolean;

  function FormatToImagePresentation(const AFormat: TfgImageFormat): TfgImagePresentation;
  begin
    case AFormat of
      TfgImageFormat.JPEG:
        Result := TfgImagePresentation.JPEG;
      TfgImageFormat.PNG:
        Result := TfgImagePresentation.PNG;
    else
      Result := TfgImagePresentation.Unkown;
    end;
  end;

var
  Data: NSData;
  Image: UIImage;
  ImageRef: CGImageRef;
  Presentation: TfgImagePresentation;
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);
  TfgAssert.IsNotNil(AStream, 'AStream');

  ImageRef := TfgiOSBitmapHandle(AHandle).ImageRef;
  Image := TUIImage.Wrap(TUIImage.alloc.initWithCGImage(ImageRef));
  if Image = nil then
  begin
    TfgLog.Error(SCannotSaveBitmapToStream);
    Exit(False);
  end;

  try
    Presentation := FormatToImagePresentation(AFormat);
    Data := DataFromImage(Image, Presentation, AParams);
    Result := AStream.Write(Data.bytes^, Data.length) = Abs(Data.length);
  finally
    Image.release;
    Image := nil;
  end;
end;

procedure TfgiOSBitmapService.SetScale(const AHandle: TfgBitmapHandle; const AScale: Single);
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);
  TfgAssert.StrickMoreThan(AScale, 0, 'The scale has to be greater than 0.');

  TfgiOSBitmapHandle(AHandle).Scale := AScale;
end;

procedure TfgiOSBitmapService.SetSize(const AHandle: TfgBitmapHandle; const AWidth, AHeight: Integer);
begin
  TfgAssert.IsNotNil(AHandle, 'AHandle');
  TfgAssert.IsClass(AHandle, TfgiOSBitmapHandle);
  TfgAssert.StrickMoreThan(AWidth, 0, 'The width has to be greater than 0.');
  TfgAssert.StrickMoreThan(AHeight, 0, 'The height has to be greater than 0.');

  TfgiOSBitmapHandle(AHandle).SetSize(AWidth, AHeight);
end;

{ TfgiOSBitmapHandle }

class constructor TfgiOSBitmapHandle.Create;
begin
  FColorSpaceRGB := CGColorSpaceCreateDeviceRGB;
end;

class destructor TfgiOSBitmapHandle.Destroy;
begin
  if FColorSpaceRGB <> nil then
  begin
    CGColorSpaceRelease(FColorSpaceRGB);
    FColorSpaceRGB := nil;
  end;
end;

constructor TfgiOSBitmapHandle.Create(const AImageRef: CGImageRef; const AScale: Single);
begin
  TfgAssert.IsNotNil(AImageRef, 'AImageRef');

  FImageRef := AImageRef;
  CFRetain(FImageRef);
  FScale := AScale;
end;


procedure TfgiOSBitmapHandle.ApplyTintColor(const ATintColor: TAlphaColor);
type
  PAlphaColorRecArray = ^TAlphaColorRecArray;
  TAlphaColorRecArray = array [0 .. MaxInt div 4 - 1] of TAlphaColorRec;

  function ModulatePixelSrcIn(const APixel: TAlphaColorRec {RGBA}; const AColor: TAlphaColor {BGRA}): TAlphaColorRec; inline;
  begin
    // В iOS используется другой формат хранения каналов точки, поэтому мы меняем естами B и R каналы местами
    Result.R := (APixel.A * TAlphaColorRec(AColor).B) div 255;
    Result.G := (APixel.A * TAlphaColorRec(AColor).G) div 255;
    Result.B := (APixel.A * TAlphaColorRec(AColor).R) div 255;
    Result.A := (APixel.A * TAlphaColorRec(AColor).A) div 255;
  end;

  procedure ApplyTint(const ABits: PAlphaColorRecArray; const APixelsCount: Integer; const AColor: TAlphaColor);
  var
    I: Integer;
  begin
    I := 0;
    while I < APixelsCount do
    begin
      ABits[I] := ModulatePixelSrcIn(ABits[I], AColor);
      Inc(I);
    end;
  end;

var
  Context: CGContextRef;
  Bits: PAlphaColorRecArray;
  NewImageRef: CGImageRef;
begin
  Context := CreateContext;
  if Context = nil then
    Exit;

  try
    Bits := PAlphaColorRecArray(CGBitmapContextGetData(Context));
    ApplyTint(Bits, CGBitmapContextGetWidth(Context) * CGBitmapContextGetHeight(Context), ATintColor);

    NewImageRef := CGBitmapContextCreateImage(Context);
    SetImageRef(NewImageRef);
  finally
    CGContextRelease(Context);
  end;
end;

constructor TfgiOSBitmapHandle.Create(const AWidth, AHeight: Integer; const AScale: Single);
begin
  FScale := AScale;
  SetSize(AWidth, AHeight);
end;

destructor TfgiOSBitmapHandle.Destroy;
begin
  ReleaseImageRef;
  inherited;
end;

procedure TfgiOSBitmapHandle.DrawOnto(const AContext: CGContextRef; const ASourceRect: TRect; const ADestRect: TRectF);
var
  LCropBitmap: CGImageRef;
begin
  if ASourceRect.Location.IsZero and (ASourceRect.Size = Size) then
    CGContextDrawImage(AContext, ADestRect, FImageRef)
  else
  begin
    LCropBitmap := CGImageCreateWithImageInRect(FImageRef, ASourceRect);
    try
      CGContextDrawImage(AContext, ADestRect, LCropBitmap);
    finally
      CGImageRelease(LCropBitmap);
    end;
  end;
end;

function TfgiOSBitmapHandle.CreateContext: CGContextRef;
var
  LSize: TSize;
begin
  LSize := Size;
  if LSize.IsZero then
    Exit(nil);
  Result := CreateNewContext(LSize);
  CGContextDrawImage(Result, CGRect.Create(0, 0, LSize.Width, LSize.Height), FImageRef);
end;

function TfgiOSBitmapHandle.CreateCopy(const ASourceRect: TRect; const ASize: TSize): CGImageRef;
var
  LContext: CGContextRef;
begin
  if ASourceRect.Location.IsZero and (ASourceRect.Size = Size) and (Size = ASize) then
    Result := CGImageCreateCopy(FImageRef)
  else
  begin
    LContext := CreateNewContext(ASize);
    try
      DrawOnto(LContext, ASourceRect, TRect.Create(TPoint.Zero, ASize.Width, ASize.Height));
      Result := CGBitmapContextCreateImage(LContext);
    finally
      CGContextRelease(LContext);
    end;
  end;
end;

function TfgiOSBitmapHandle.CreateNewContext(const ASize: TSize): CGContextRef;
const
  RGBAPixelSize = 4; // bytes
  RGBAComponentSize = 8; // bits
  BytesPerRowAlignment = 16; // bytes;
var
  LBytesPerRow: Integer;
  LValue: Integer;
begin
  LBytesPerRow := ASize.Width * RGBAPixelSize;
  LValue := LBytesPerRow mod BytesPerRowAlignment;
  Inc(LBytesPerRow, LValue);
  Result := CGBitmapContextCreate(nil, ASize.Width, ASize.Height, RGBAComponentSize, LBytesPerRow,
    FColorSpaceRGB, kCGImageAlphaPremultipliedLast);
end;

function TfgiOSBitmapHandle.GetNativeBitmap: IInterface;
begin
  Result := nil;
end;

function TfgiOSBitmapHandle.GetSize: TSize;
begin
  if FImageRef = nil then
    Result := TSize.Create(0, 0)
  else
    Result := TSize.Create(CGImageGetWidth(FImageRef), CGImageGetHeight(FImageRef));
end;

procedure TfgiOSBitmapHandle.ReleaseImageRef;
begin
  if FImageRef <> nil then
  begin
    CGImageRelease(FImageRef);
    FImageRef := nil;
  end;
end;

procedure TfgiOSBitmapHandle.SetImageRef(const Value: CGImageRef);
begin
  TfgAssert.IsNotNil(Value, 'Value');

  if Value <> FImageRef then
  begin
    ReleaseImageRef;
    FImageRef := Value;
    CFRetain(FImageRef);
  end;
end;

procedure TfgiOSBitmapHandle.SetImageRefWithoutRetain(const Value: CGImageRef);
begin
  TfgAssert.IsNotNil(Value, 'Value');

  if Value <> FImageRef then
  begin
    ReleaseImageRef;
    FImageRef := Value;
  end;
end;

procedure TfgiOSBitmapHandle.SetSize(const AWidth, AHeight: Integer);
var
  LContext: CGContextRef;
  LNewSize: TSize;
  LImageRef: CGImageRef;
begin
  LNewSize := TSize.Create(AWidth, AHeight);
  if LNewSize = Size then
    Exit;
  LContext := CreateNewContext(LNewSize);
  try
    LImageRef := CGBitmapContextCreateImage(LContext);
    SetImageRefWithoutRetain(LImageRef);
  finally
    CGContextRelease(LContext);
  end;
end;

{ TfgiOSCanvas }

constructor TfgiOSCanvas.CreateForContext(const AContext: CGContextRef; const AContextSize: TSizeF);
begin
  TfgAssert.IsNotNil(AContext, 'AContext');

  inherited Create;
  FContext := AContext;
  FContextSize := AContextSize;
  // Мы не берем скейл от канвы по формуле:
  // ANativeCanvas.getDensity / TJDisplayMetrics.DENSITY_DEFAULT
  // так как getDensity возвращает 0.
//  FScreenScale := TfgAndroidHelper.ScreenScale;
  FBrushState := [TfgBrushState.OutdateFill, TfgBrushState.OutdateStroke];
end;

constructor TfgiOSCanvas.CreateForBitmap(const ABitmapHandle: TfgiOSBitmapHandle);
begin
  TfgAssert.IsNotNil(ABitmapHandle, 'ABitmapHandle');

  inherited Create;
  FBitmapHandle := ABitmapHandle;
  // Мы не берем скейл от канвы по формуле:
  // ANativeCanvas.getDensity / TJDisplayMetrics.DENSITY_DEFAULT
  // так как getDensity возвращает 0.
//  FScreenScale := TfgAndroidHelper.ScreenScale;
  FBrushState := [TfgBrushState.OutdateFill, TfgBrushState.OutdateStroke];
end;

destructor TfgiOSCanvas.Destroy;
begin
  ReleaseGradient(FStrokeGradient);
  ReleaseGradient(FFillGradient);
  inherited;
end;

function TfgiOSCanvas.AdaptRectForStrokeThickness(const ARect: TRectF): TRectF;
//var
//  LHalfThickness: Single;
begin
  Result := ARect;
  // Viktor: Задел на будущее, когда мы опционально позволим управлять тем, как осуществляется рисование пером.
  // Варианты: по внутренней границе, посередине, по внешней границе.
//  if Stroke.Thickness <> 1.0 then
//  begin
//    LHalfThickness := Stroke.Thickness / 2;
//    Result.Inflate(-LHalfThickness, -LHalfThickness);
//  end;
end;

procedure TfgiOSCanvas.DoBeginPaint;
begin
  if IsBitmapCanvas then
  begin
    FContext := FBitmapHandle.CreateContext;
    NormalizeCoordinateSystem(FContext, FBitmapHandle.Scale, FBitmapHandle.Size.Height);
  end;
end;

procedure TfgiOSCanvas.DoEndPaint;
begin
  if IsBitmapCanvas then
  begin
    FBitmapHandle.SetImageRefWithoutRetain(CGBitmapContextCreateImage(FContext));
    CGContextRelease(FContext);
    FContext := nil;
  end;
end;

procedure TfgiOSCanvas.DoDrawArc(const ARect: TRectF; const StartAngle, SweepAngle: Single);
var
  LArcParameters: TfgArcParameters;
  LPath: CGMutablePathRef;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateStrokeBrushIfNeeded;

  LPath := CGPathCreateMutable;
  try
    LArcParameters := GetArcParameters(AdaptRectForStrokeThickness(ARect), StartAngle, SweepAngle);
    CGPathAddArc(LPath, @LArcParameters.Transform, 0, 0, LArcParameters.Radius, LArcParameters.StartAngle,
      LArcParameters.EndAngle, LArcParameters.ClockwiseMode);
    CGContextAddPath(FContext, LPath);
    if Stroke.Kind = TfgBrushKind.Gradient then
      DrawStrokeGradientPath(ARect)
    else
      CGContextStrokePath(FContext);
  finally
    CFRelease(LPath);
  end;
end;

procedure TfgiOSCanvas.DoDrawBitmap(const ABitmap: TfgBitmap; const ASourceRect: TRect; const ADestRect: TRectF);
begin
  TfgAssert.IsNotNil(FContext, 'FContext');
  TfgAssert.IsNotNil(ABitmap, 'ABitmap');
  TfgAssert.IsTrue(ABitmap.IsHandleCreated);
  TfgAssert.IsClass(ABitmap.Handle, TfgiOSBitmapHandle);

  CGContextSaveGState(FContext);
  try
    NormalizeCoordinateSystem(FContext, 1, Height);
    TfgiOSBitmapHandle(ABitmap.Handle).DrawOnto(FContext, ASourceRect, ADestRect);
  finally
    CGContextRestoreGState(FContext);
  end;
end;

procedure TfgiOSCanvas.DoDrawBitmapWithMask(const ABitmap: TfgBitmap; const ASourceRect: TRect; const ADestRect: TRectF;
  const AMask: TfgBitmap; const AMaskSourceRect: TRect; const AMaskDestRect: TRectF);
var
  LMaskedImage: CGImageRef;
  LMaskDestRect: TRectF;
begin
  TfgAssert.IsNotNil(ABitmap, 'ABitmap');
  TfgAssert.IsTrue(ABitmap.IsHandleCreated);
  TfgAssert.IsClass(ABitmap.Handle, TfgiOSBitmapHandle);
  TfgAssert.IsNotNil(AMask, 'AMask');
  TfgAssert.IsTrue(AMask.IsHandleCreated);
  TfgAssert.IsClass(AMask.Handle, TfgiOSBitmapHandle);

  if ADestRect.IntersectsWith(AMaskDestRect) then
  begin
    CGContextSaveGState(FContext);
    try
      NormalizeCoordinateSystem(FContext, 1, Height);
      LMaskDestRect := AMaskDestRect;
      LMaskDestRect.Offset(-ADestRect.Left, -ADestRect.Top);

      LMaskedImage := CreateMaskedImage(ADestRect.Size.Round, TfgiOSBitmapHandle(ABitmap.Handle), ASourceRect,
        TfgiOSBitmapHandle(AMask.Handle), AMaskSourceRect, LMaskDestRect);
      try
        CGContextDrawImage(FContext, ADestRect, LMaskedImage);
      finally
        CGImageRelease(LMaskedImage);
      end;
    finally
      CGContextRestoreGState(FContext);
    end;
  end
  else
    DoDrawBitmap(ABitmap, ASourceRect, ADestRect)
end;

function TfgiOSCanvas.CreateMaskedImage(const ASize: TSize; const ABitmap: TfgiOSBitmapHandle; const ASourceRect: TRect;
  const AMask: TfgiOSBitmapHandle; const AMaskSourceRect: TRect; const AMaskDestRect: TRectF): CGImageRef;
var
  LSource: CGImageRef;
  LMask: CGImageRef;
begin
  LSource := ABitmap.CreateCopy(ASourceRect, ASize);
  try
    LMask := CreateMask(AMask, AMaskSourceRect, AMaskDestRect, ASize);
    try
      Result := CGImageCreateWithMask(LSource, LMask);
    finally
      CGImageRelease(LMask);
    end;
  finally
    CGImageRelease(LSource);
  end;
end;

function TfgiOSCanvas.CreateMask(const AMask: TfgiOSBitmapHandle; const AMaskSourceRect: TRect;
  const AMaskDestRect: TRectF; const ASize: TSize): CGImageRef;
const
  GrayComponentSize = 8; // bits
var
  LColorSpaceGray: CGColorSpaceRef;
  LContext: CGContextRef;
begin
  LContext := nil;
  try
    LColorSpaceGray := CGColorSpaceCreateDeviceGray;
    try
      // Основа маски в оттенках серого. 8 бит на пиксель.
      LContext := CGBitmapContextCreate(nil, ASize.Width, ASize.Height, GrayComponentSize, 0,
        LColorSpaceGray, kCGImageAlphaNone);
    finally
      CGColorSpaceRelease(LColorSpaceGray);
    end;
    NormalizeCoordinateSystem(LContext, 1, ASize.Height);
    // Заливаем основу маски черным цветом. Черный цвет означает полностью прозрачный цвет.
    CGContextSetRGBFillColor(LContext, 0, 0, 0, 1);
    CGContextFillRect(LContext, CGRect.Create(0, 0, ASize.Width, ASize.Height));
    // Накладываем маску на основу. В пикселях отличных от черного впоследствии будет отрисовано максируемое изображение.
    AMask.DrawOnto(LContext, AMaskSourceRect, AMaskDestRect);
    Result := CGBitmapContextCreateImage(LContext);
  finally
    CGContextRelease(LContext);
  end;
end;

procedure TfgiOSCanvas.DoDrawCircle(const ACenter: TPointF; const ARadius: Single);
var
  LRect: TRectF;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateStrokeBrushIfNeeded;

  LRect := TRectF.Create(ACenter.X - ARadius, ACenter.Y - ARadius, ACenter.X + ARadius, ACenter.Y + ARadius);
  CGContextBeginPath(FContext);
  try
    CGContextAddEllipseInRect(FContext, AdaptRectForStrokeThickness(LRect));
  finally
    if Stroke.Kind = TfgBrushKind.Gradient then
      DrawStrokeGradientPath(LRect)
    else
      CGContextStrokePath(FContext);
  end;
end;

procedure TfgiOSCanvas.DoDrawEllipse(const ARect: TRectF);
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateStrokeBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    CGContextAddEllipseInRect(FContext, AdaptRectForStrokeThickness(ARect));
  finally
    if Stroke.Kind = TfgBrushKind.Gradient then
      DrawStrokeGradientPath(ARect)
    else
      CGContextStrokePath(FContext);
  end;
end;

procedure TfgiOSCanvas.DoDrawLine(const APt1, APt2: TPointF);
var
  LRect: TRectF;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateStrokeBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    {TODO -oViktor -cGeneral : учесть толщину пера}
    CGContextMoveToPoint(FContext, APt1.X, APt1.Y);
    CGContextAddLineToPoint(FContext, APt2.X, APt2.Y);
  finally
    if Stroke.Kind = TfgBrushKind.Gradient then
    begin
      LRect := TRectF.Create(APt1, APt2, True);
      DrawStrokeGradientPath(LRect);
    end
    else
      CGContextStrokePath(FContext);
  end;
end;

procedure TfgiOSCanvas.DoDrawLines(const APoints: TfgPoints);
var
  LRect: TRectF;
  I: Integer;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  if APoints = nil then
    Exit;
  UpdateStrokeBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    {TODO -oViktor -cGeneral : учесть толщину пера}
    CGContextMoveToPoint(FContext, APoints[0].X, APoints[0].Y);
    for I := 1 to High(APoints) do
      CGContextAddLineToPoint(FContext, APoints[I].X, APoints[I].Y);
  finally
    if Stroke.Kind = TfgBrushKind.Gradient then
    begin
      LRect := TRectF.Union(APoints);
      DrawStrokeGradientPath(LRect);
    end
    else
      CGContextStrokePath(FContext);
  end;
end;

procedure TfgiOSCanvas.DoDrawPath(const APath: TfgPath);
var
  LRect: TRectF;
  LPath: CGMutablePathRef;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateStrokeBrushIfNeeded;

  LPath := CGPathCreateMutable;
  try
    {TODO -oViktor -cGeneral : учесть толщину пера}
    FgPathToPath(APath, LPath);
    CGContextAddPath(FContext, LPath);
    if Stroke.Kind = TfgBrushKind.Gradient then
    begin
      LRect := APath.CalculateFrame;
      DrawStrokeGradientPath(LRect);
    end
    else
      CGContextStrokePath(FContext);
  finally
    CFRelease(LPath);
  end;
end;

procedure TfgiOSCanvas.DoDrawPoint(const APoint: TPointF);
begin
  DoDrawRect(TRectF.Create(APoint, 1, 1));
end;

procedure TfgiOSCanvas.DoDrawPoints(const APoints: TfgPoints);
var
  I: Integer;
begin
  for I := Low(APoints) to High(APoints) do
    DoDrawRect(TRectF.Create(APoints[I], 1, 1));
end;

procedure TfgiOSCanvas.DoDrawRect(const ARect: TRectF);
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateStrokeBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    CGContextAddRect(FContext, AdaptRectForStrokeThickness(ARect));
  finally
    if Stroke.Kind = TfgBrushKind.Gradient then
      DrawStrokeGradientPath(ARect)
    else
      CGContextStrokePath(FContext);
  end;
end;

procedure TfgiOSCanvas.DoFillCircle(const ACenter: TPointF; const ARadius: Single);
var
  LRect: TRectF;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateFillBrushIfNeeded;

  LRect := TRectF.Create(ACenter.X - ARadius, ACenter.Y - ARadius, ACenter.X + ARadius, ACenter.Y + ARadius);
  CGContextBeginPath(FContext);
  try
    CGContextAddEllipseInRect(FContext, LRect);
  finally
    if Fill.Kind = TfgBrushKind.Gradient then
      DrawFillGradientPath(LRect)
    else
      CGContextDrawPath(FContext, kCGPathFill);
  end;
end;

procedure TfgiOSCanvas.DoFillColor(const AColor: TAlphaColor);
var
  LColor: TAlphaColorF;
  LRect: CGRect;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');
  if AColor = TAlphaColorRec.Null then
    Exit;

  CGContextSaveGState(FContext);
  try
    LColor := TAlphaColorF.Create(AColor);
    CGContextSetRGBFillColor(FContext, LColor.R, LColor.G, LColor.B, LColor.A);
    LRect := CGRect.Create(0, 0, Width, Height);
    CGContextFillRect(FContext, LRect);
  finally
    CGContextRestoreGState(FContext);
  end;
end;

procedure TfgiOSCanvas.DoFillEllipse(const ARect: TRectF);
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateFillBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    CGContextAddEllipseInRect(FContext, ARect);
  finally
    if Fill.Kind = TfgBrushKind.Gradient then
      DrawFillGradientPath(ARect)
    else
      CGContextDrawPath(FContext, kCGPathFill);
  end;
end;

procedure TfgiOSCanvas.DoFillPath(const APath: TfgPath);
var
  LRect: TRectF;
  LPath: CGMutablePathRef;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateFillBrushIfNeeded;

  LPath := CGPathCreateMutable;
  try
    FgPathToPath(APath, LPath);
    CGContextAddPath(FContext, LPath);
    if Fill.Kind = TfgBrushKind.Gradient then
    begin
      LRect := APath.CalculateFrame;
      DrawFillGradientPath(LRect);
    end
    else
      CGContextDrawPath(FContext, kCGPathFill);
  finally
    CFRelease(LPath);
  end;
end;

procedure TfgiOSCanvas.DoFillPolygon(const APolygon: TfgPoints);
var
  LRect: TRectF;
  I: Integer;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  if APolygon = nil then
    Exit;
  UpdateFillBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    CGContextMoveToPoint(FContext, APolygon[0].X, APolygon[0].Y);
    for I := 1 to High(APolygon) do
      CGContextAddLineToPoint(FContext, APolygon[I].X, APolygon[I].Y);
    CGContextClosePath(FContext);
  finally
    if Fill.Kind = TfgBrushKind.Gradient then
    begin
      LRect := TRectF.Union(APolygon);
      DrawFillGradientPath(LRect);
    end
    else
      CGContextDrawPath(FContext, kCGPathFill);
  end;
end;

procedure TfgiOSCanvas.DoFillRect(const ARect: TRectF);
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateFillBrushIfNeeded;

  CGContextBeginPath(FContext);
  try
    CGContextAddRect(FContext, ARect);
  finally
    if Fill.Kind = TfgBrushKind.Gradient then
      DrawFillGradientPath(ARect)
    else
      CGContextDrawPath(FContext, kCGPathFill);
  end;
end;

procedure TfgiOSCanvas.DoFillRoundRect(const ARect: TRectF; const RX, RY: Single);
var
  LPath: CGPathRef;
begin
  TfgAssert.IsNotNil(FContext, 'FContext');

  UpdateFillBrushIfNeeded;

  LPath := CGPathCreateWithRoundedRect(ARect, RX, RY, nil);
  try
    CGContextAddPath(FContext, LPath);
  finally
    CGPathRelease(LPath);
  end;
  if Fill.Kind = TfgBrushKind.Gradient then
    DrawFillGradientPath(ARect)
  else
    CGContextDrawPath(FContext, kCGPathFill);
end;

procedure TfgiOSCanvas.DoFillText(const ARect: TRectF; const AText: string; const WordWrap: Boolean;
  const AHorizontalAlign: TfgHorizontalAlignment; const AVerticalAlign: TfgVerticalAlignment);
begin
  TfgiOSTextRender.FillText(Self, ARect, AText, WordWrap, AHorizontalAlign, AVerticalAlign);
end;

function TfgiOSCanvas.DoMeasureText(const AText: string; const AMaxSize: TSizeF; const AWordWrap: Boolean): TSizeF;
begin
  Result := TfgiOSTextRender.MeasureText(Self, AText, AMaxSize, AWordWrap);
end;

procedure TfgiOSCanvas.DrawFillGradientPath(const ARect: TRectF);
var
  LStartPoint: CGPoint;
  LStoptPoint: CGPoint;
begin
  CGContextSaveGState(FContext);
  try
    CGContextClip(FContext);
    case Fill.Gradient.Style of
      TfgGradientStyle.Linear:
      begin
        LStartPoint.x := ARect.Left + ARect.Width * Fill.Gradient.StartPoint.X;
        LStartPoint.y := ARect.Top + ARect.Height * Fill.Gradient.StartPoint.Y;
        LStoptPoint.x := ARect.Left + ARect.Width * Fill.Gradient.StopPoint.X;
        LStoptPoint.y := ARect.Top + ARect.Height * Fill.Gradient.StopPoint.Y;
        CGContextDrawLinearGradient(FContext, FFillGradient, LStartPoint, LStoptPoint, 0);
//          kCGGradientDrawsBeforeStartLocation or kCGGradientDrawsAfterEndLocation);
      end;
      TfgGradientStyle.Radial:
        TfgAssert.Fail('not implemented');
    else
      TfgAssert.Fail('Unsupported gradient style: ' + Integer(Fill.Gradient.Style).ToString);
    end;
  finally
    CGContextRestoreGState(FContext);
  end;
end;

procedure TfgiOSCanvas.DrawStrokeGradientPath(const ARect: TRectF);
var
  LStartPoint: CGPoint;
  LStoptPoint: CGPoint;
begin
  CGContextSaveGState(FContext);
  try
    CGContextReplacePathWithStrokedPath(FContext);
    CGContextClip(FContext);
    case Stroke.Gradient.Style of
      TfgGradientStyle.Linear:
      begin
        LStartPoint.x := ARect.Left + ARect.Width * Stroke.Gradient.StartPoint.X;
        LStartPoint.y := ARect.Top + ARect.Height * Stroke.Gradient.StartPoint.Y;
        LStoptPoint.x := ARect.Left + ARect.Width * Stroke.Gradient.StopPoint.X;
        LStoptPoint.y := ARect.Top + ARect.Height * Stroke.Gradient.StopPoint.Y;
        CGContextDrawLinearGradient(FContext, FStrokeGradient, LStartPoint, LStoptPoint, 0);
//          kCGGradientDrawsBeforeStartLocation or kCGGradientDrawsAfterEndLocation);
      end;
      TfgGradientStyle.Radial:
        TfgAssert.Fail('not implemented');
    else
      TfgAssert.Fail('Unsupported gradient style: ' + Integer(Stroke.Gradient.Style).ToString);
    end;
  finally
    CGContextRestoreGState(FContext);
  end;
end;

procedure TfgiOSCanvas.FgPathToPath(const ASource: TfgPath; const ADest: CGMutablePathRef);
var
  LCommand: TfgPathCommand;
  LArcParameters: TfgArcParameters;
begin
  for LCommand in ASource do
    case LCommand.Kind of
      TfgPathCommandKind.MoveTo:
        CGPathMoveToPoint(ADest, nil, LCommand.MovePoint.X, LCommand.MovePoint.Y);
      TfgPathCommandKind.LineTo:
        CGPathAddLineToPoint(ADest, nil, LCommand.LinePoint.X, LCommand.LinePoint.Y);
      TfgPathCommandKind.Close:
        CGPathCloseSubpath(ADest);
      TfgPathCommandKind.CurveTo:
        CGPathAddCurveToPoint(ADest, nil, LCommand.CurveControlPoint1.X, LCommand.CurveControlPoint1.Y,
          LCommand.CurveControlPoint2.X, LCommand.CurveControlPoint2.Y,
          LCommand.CurveEndPoint.X, LCommand.CurveEndPoint.Y);
      TfgPathCommandKind.QuadraticCurve:
        CGPathAddQuadCurveToPoint(ADest, nil, LCommand.QCurveControlPoint.X, LCommand.QCurveControlPoint.Y,
          LCommand.QCurveEndPoint.X, LCommand.QCurveEndPoint.Y);
      TfgPathCommandKind.Arc:
      begin
        LArcParameters := GetArcParameters(LCommand.ArcRect, LCommand.ArcStartAngle, LCommand.ArcSweepAngle);
        CGPathAddArc(ADest, @LArcParameters.Transform, 0, 0, LArcParameters.Radius, LArcParameters.StartAngle,
          LArcParameters.EndAngle, LArcParameters.ClockwiseMode);
      end;
    else
      TfgAssert.Fail('Unsupported command kind: ' + Integer(LCommand.Kind).ToString);
    end;
end;

procedure TfgiOSCanvas.FillBrushChanged(const AFill: TfgBrush);
begin
  Include(FBrushState, TfgBrushState.OutdateFill);
end;

procedure TfgiOSCanvas.FontChanged(const AFont: TfgFont);
begin
  Include(FBrushState, TfgBrushState.OutdateFont);
end;

procedure TfgiOSCanvas.StrokeBrushChanged(const AStroke: TfgStrokeBrush);
begin
  Include(FBrushState, TfgBrushState.OutdateStroke);
end;

function TfgiOSCanvas.GetArcParameters(const ARect: TRectF; const AStartAngle, ASweepAngle: Single): TfgArcParameters;
var
  LCenter: TPointF;
begin
  LCenter := ARect.CenterPoint;
  Result.Radius := ARect.Width / 2;
  Result.StartAngle := DegToRad(-AStartAngle);
  Result.EndAngle := DegToRad(-AStartAngle - ASweepAngle);
  Result.ClockwiseMode := ASweepAngle > 0;
  Result.Transform := CGAffineTransformMakeTranslation(LCenter.X, LCenter.Y);
  Result.Transform := CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, ARect.Height / ARect.Width), Result.Transform);
end;

function TfgiOSCanvas.GetHeight: Single;
begin
  if IsBitmapCanvas then
    Result := FBitmapHandle.Size.Height
  else
    Result := FContextSize.Height;
end;

function TfgiOSCanvas.GetWidth: Single;
begin
  if IsBitmapCanvas then
    Result := FBitmapHandle.Size.Width
  else
    Result := FContextSize.Width;
end;

function TfgiOSCanvas.IsBitmapCanvas: Boolean;
begin
  Result := FBitmapHandle <> nil;
end;

procedure TfgiOSCanvas.MakeNativeGradientFromFgGradient(const ASource: TfgGradient; var ADest: CGGradientRef);
const
  ComponentsPerColor = 4;
var
  LColor: TAlphaColorF;
  LColorSpace: CGColorSpaceRef;
  LPointsCount: Integer;
  LColorsList: TArray<CGFloat>;
  LOffsetsList: TArray<CGFloat>;
  LColorIndex: Integer;
  I: Integer;
begin
  TfgAssert.IsNotNil(ASource, 'ASource');

  ReleaseGradient(ADest);
  LPointsCount := ASource.Count;
  if LPointsCount = 0 then
    Exit;
  SetLength(LColorsList, LPointsCount * ComponentsPerColor);
  SetLength(LOffsetsList, LPointsCount);
  for I := 0 to LPointsCount - 1 do
  begin
    LColor := TAlphaColorF.Create(ASource.Colors[I]);
    LColorIndex := I * ComponentsPerColor;
    LColorsList[LColorIndex] := LColor.R;
    LColorsList[LColorIndex + 1] := LColor.G;
    LColorsList[LColorIndex + 2] := LColor.B;
    LColorsList[LColorIndex + 3] := LColor.A;
    LOffsetsList[I] := ASource.Offsets[I];
  end;
  LColorSpace := CGColorSpaceCreateDeviceRGB;
  try
    ADest := CGGradientCreateWithColorComponents(LColorSpace, @LColorsList[0], @LOffsetsList[0], LPointsCount);
  finally
    CGColorSpaceRelease(LColorSpace);
  end;
end;

procedure TfgiOSCanvas.NormalizeCoordinateSystem(const AContext: CGContextRef; const AScale, AHeight: Single);
var
  LScaleMatrix: CGAffineTransform;
  LTranslationMatrix: CGAffineTransform;
begin
  LScaleMatrix := CGAffineTransformMakeScale(AScale, -AScale);
  CGContextConcatCTM(AContext, LScaleMatrix);
  LTranslationMatrix := CGAffineTransformMakeTranslation(0, -AHeight / AScale);
  CGContextConcatCTM(AContext, LTranslationMatrix);
end;

procedure TfgiOSCanvas.ReleaseGradient(var ASource: CGGradientRef);
begin
  if ASource <> nil then
  begin
    CGGradientRelease(ASource);
    ASource := nil;
  end;
end;

procedure TfgiOSCanvas.UpdateFillBrushIfNeeded;
var
  LColor: TAlphaColorF;
begin
  if not (TfgBrushState.OutdateFill in FBrushState) then
    Exit;
  case Fill.Kind of
    TfgBrushKind.Solid:
    begin
      LColor := TAlphaColorF.Create(Fill.ColorLink.Color);
      CGContextSetRGBFillColor(FContext, LColor.R, LColor.G, LColor.B, LColor.A);
    end;
    TfgBrushKind.Gradient:
      MakeNativeGradientFromFgGradient(Fill.Gradient, FFillGradient);
  end;

  Exclude(FBrushState, TfgBrushState.OutdateFill);
end;

procedure TfgiOSCanvas.UpdateStrokeBrushIfNeeded;
var
  LColor: TAlphaColorF;
  LDashArray: TArray<CGFloat>;
begin
  if not (TfgBrushState.OutdateStroke in FBrushState) then
    Exit;

  case Stroke.Kind of
    TfgBrushKind.Solid:
    begin
      LColor := TAlphaColorF.Create(Stroke.ColorLink.Color);
      CGContextSetRGBStrokeColor(FContext, LColor.R, LColor.G, LColor.B, LColor.A);
    end;
    TfgBrushKind.Gradient:
      MakeNativeGradientFromFgGradient(Stroke.Gradient, FStrokeGradient);
  end;
  case Stroke.Join of
    TfgStrokeJoin.Miter:
      CGContextSetLineJoin(FContext, kCGLineJoinMiter);
    TfgStrokeJoin.Round:
      CGContextSetLineJoin(FContext, kCGLineJoinRound);
    TfgStrokeJoin.Bevel:
      CGContextSetLineJoin(FContext, kCGLineJoinBevel);
  end;

  if Stroke.Dash <> TfgStrokeDash.Solid then
  begin
    LDashArray := CreateNativeDashPattern;
    if LDashArray <> nil then
      CGContextSetLineDash(FContext, Stroke.DashOffset * Stroke.Thickness, @LDashArray[0], Length(LDashArray));
  end
  else
    CGContextSetLineDash(FContext, 0, nil, 0);
  case Stroke.Cap of
    TfgStrokeCap.Flat:
      CGContextSetLineCap(FContext, kCGLineCapSquare);
    TfgStrokeCap.Round:
      CGContextSetLineCap(FContext, kCGLineCapRound);
    TfgStrokeCap.Butt:
      CGContextSetLineCap(FContext, kCGLineCapButt);
  end;

  CGContextSetLineWidth(FContext, Stroke.Thickness);

  Exclude(FBrushState, TfgBrushState.OutdateStroke);
end;

function TfgiOSCanvas.CreateNativeDashPattern: TArray<CGFloat>;
begin
  Result := CreateDashPattern;
end;

{ TfgiOSTextRender }

class procedure TfgiOSTextRender.FillText(const ACanvas: TfgiOSCanvas; const ARect: TRectF; const AText: string;
  const AWordWrap: Boolean; const AHorizontalAlign: TfgHorizontalAlignment; const AVerticalAlign: TfgVerticalAlignment);
var
  LFrame: CTFrameRef;
  LTextSettings: TTextSettings;
begin
  CGContextSaveGState(ACanvas.FContext);
  try
    PrepareContextCoordinates(ACanvas, ARect);

    LTextSettings.Font := ACanvas.Font;
    LTextSettings.Color := ACanvas.Fill.ColorLink.Color;
    LTextSettings.WordWrap := AWordWrap;
    LTextSettings.HorizontalAlign := AHorizontalAlign;
    LTextSettings.VerticalAlign := AVerticalAlign;

    LFrame := CreateFrame(ACanvas.FContext, AText, ARect.Size, LTextSettings);
    try
      CTFrameDraw(LFrame, ACanvas.FContext);
    finally
      CFRelease(LFrame);
    end;
  finally
    CGContextRestoreGState(ACanvas.FContext);
  end;
end;

class function TfgiOSTextRender.MeasureText(const ACanvas: TfgiOSCanvas; const AText: string; const AMaxSize: TSizeF;
  const AWordWrap: Boolean): TSizeF;
var
  LTextSettings: TTextSettings;
  LFrameSetter: CTFramesetterRef;
begin
  CGContextSaveGState(ACanvas.FContext);
  try
    LTextSettings.Font := ACanvas.Font;
    LTextSettings.Color := TAlphaColors.Black;
    LTextSettings.WordWrap := AWordWrap;
    LTextSettings.HorizontalAlign := TfgHorizontalAlignment.Left;
    LTextSettings.VerticalAlign := TfgVerticalAlignment.Top;

    LFrameSetter := CreateFrameSetter(AText, LTextSettings);
    try
      Result := MeasureTextSize(LFrameSetter, AText, AMaxSize.Width);
    finally
      CFRelease(LFrameSetter);
    end;
  finally
    CGContextRestoreGState(ACanvas.FContext);
  end;
end;

class function TfgiOSTextRender.MeasureTextSize(const AFrameSetter: CTFramesetterRef; const AText: string;
  const AMaxWidth: Single): TSizeF;
var
  LFitRange: CFRange;
begin
  Result := CTFramesetterSuggestFrameSizeWithConstraints(AFrameSetter, CFRange.Create(0, AText.Length), nil,
    CGSize.Create(AMaxWidth, Single.MaxValue), @LFitRange);
end;

class procedure TfgiOSTextRender.PrepareContextCoordinates(const ACanvas: TfgiOSCanvas; const ARect: TRectF);
const
  CGAffineTransformIdentity: CGAffineTransform = (
    a: 1;
    b: 0;
    c: 0;
    d: 1;
    tx: 0;
    ty: 0;
  );
begin
  CGContextClipToRect(ACanvas.FContext, ARect);
  CGContextSetTextMatrix(ACanvas.FContext, CGAffineTransformIdentity);
  CGContextTranslateCTM(ACanvas.FContext, ARect.Left, ARect.Bottom);
  CGContextScaleCTM(ACanvas.FContext, 1, -1);
end;

class function TfgiOSTextRender.CreateFrame(const AContext: CGContextRef; const AText: string; const AFrameSize: TSizeF; const ATextSettings: TTextSettings): CTFrameRef;
var
  LFillPath: CGMutablePathRef;
  LFrameSetter: CTFramesetterRef;
  LTextSize: TSizeF;
  LMaxWidth: Single;
begin
  LFrameSetter := CreateFrameSetter(AText, ATextSettings);
  try
    if ATextSettings.WordWrap then
      LMaxWidth := AFrameSize.Width
    else
      LMaxWidth := Single.MaxValue;
    LTextSize := MeasureTextSize(LFrameSetter, AText, LMaxWidth);
    SetupHorizontalAlignment(AContext, AFrameSize, LTextSize, ATextSettings.HorizontalAlign);
    SetupVerticalAlignment(AContext, AFrameSize, LTextSize, ATextSettings.VerticalAlign);
    LFillPath := CGPathCreateMutable;
    try
      CGPathAddRect(LFillPath, nil, CGRect.Create(0, 0, LTextSize.Width, LTextSize.Height));
      Result := CTFramesetterCreateFrame(LFrameSetter, CFRange.Empty, LFillPath, nil);
    finally
      CFRelease(LFillPath);
    end;
  finally
    CFRelease(LFrameSetter);
  end;
end;

class function TfgiOSTextRender.CreateFrameSetter(const AText: string; const ATextSettings: TTextSettings): CTFramesetterRef;
var
  LAttributes: TTextAttributes;
begin
  LAttributes := CreateAttributes(AText);
  try
    SetupTextColor(LAttributes, ATextSettings.Color);
    SetupFont(LAttributes, ATextSettings.Font);
    SetupParagraph(LAttributes, ATextSettings.WordWrap, ATextSettings.HorizontalAlign);
    {TODO -oViktor -cGeneral : Отключать лигатуры?}
    Result := CTFramesetterCreateWithAttributedString(LAttributes.Handle);
  finally
    CFRelease(LAttributes.Handle);
  end;
end;

class procedure TfgiOSTextRender.SetupTextColor(const AAttributes: TTextAttributes; const AFontColor: TAlphaColor);
var
  LColorSpace: CGColorSpaceRef;
  LColorComponents: TArray<CGFloat>;
  LColor: TAlphaColorF;
  LNativeColor: CGColorRef;
begin
  LColorSpace := CGColorSpaceCreateDeviceRGB;
  try
    LColor := TAlphaColorF.Create(AFontColor);
    LColorComponents := [LColor.R, LColor.G, LColor.B, LColor.A];
    LNativeColor := CGColorCreate(LColorSpace, @LColorComponents[0]);
    try
      CFAttributedStringSetAttribute(AAttributes.Handle, AAttributes.Range, kCTForegroundColorAttributeName, LNativeColor);
    finally
      CGColorRelease(LNativeColor);
    end;
  finally
    CGColorSpaceRelease(LColorSpace);
  end;
end;

class procedure TfgiOSTextRender.SetupFont(const AAttributes: TTextAttributes; const AFont: TfgFont);
var
  LFontRef: CTFontRef;
  LUnderline: CFNumberRef;
  LValue: Integer;
begin
  LFontRef := FontToCTFontRef(AFont);
  if LFontRef <> nil then
  try
    CFAttributedStringSetAttribute(AAttributes.Handle, AAttributes.Range, kCTFontAttributeName, LFontRef);
  finally
    CFRelease(LFontRef);
  end;
  if TFontStyle.fsUnderline in AFont.Style then
  begin
    LValue := kCTUnderlineStyleSingle;
    LUnderline := CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, @LValue);
    try
      CFAttributedStringSetAttribute(AAttributes.Handle, AAttributes.Range, kCTUnderlineStyleAttributeName, LUnderline);
    finally
      CFRelease(LUnderline);
    end;
  end;
end;

class procedure TfgiOSTextRender.SetupParagraph(const AAttributes: TTextAttributes; const AWordWrap: Boolean;
  const AHorizontalAlign: TfgHorizontalAlignment);
var
  LParagraphStyle: CTParagraphStyleRef;
  LParagraphSettings: array [0..2] of CTParagraphStyleSetting;
  LHorizontalAlign: Byte;
  LWrappingMode: Byte;
  LWritingDirection: Byte;
begin
  case AHorizontalAlign of
    TfgHorizontalAlignment.Center:
      LHorizontalAlign := kCTTextAlignmentCenter;
    TfgHorizontalAlignment.Left:
      LHorizontalAlign := kCTTextAlignmentLeft;
    TfgHorizontalAlignment.Right:
      LHorizontalAlign := kCTTextAlignmentRight;
  else
    TfgAssert.Fail(Format('Unknown a horizontal alignment value %d', [Integer(AHorizontalAlign)]));
    LHorizontalAlign := kCTTextAlignmentLeft;
  end;
  LParagraphSettings[0].spec := kCTParagraphStyleSpecifierAlignment;
  LParagraphSettings[0].valueSize := SizeOf(LHorizontalAlign);
  LParagraphSettings[0].value := @LHorizontalAlign;

  if AWordWrap then
    LWrappingMode := kCTLineBreakByWordWrapping
  else
    LWrappingMode := kCTLineBreakByClipping;
  LParagraphSettings[1].spec := kCTParagraphStyleSpecifierLineBreakMode;
  LParagraphSettings[1].valueSize := SizeOf(LWrappingMode);
  LParagraphSettings[1].value := @LWrappingMode;

  if TfgSystemInfo.Locale.GetLayoutDirection = TfgLayoutDirection.RightToLeft then
    LWritingDirection := kCTWritingDirectionRightToLeft
  else
    LWritingDirection := kCTWritingDirectionLeftToRight;
  LParagraphSettings[2].spec := kCTParagraphStyleSpecifierBaseWritingDirection;
  LParagraphSettings[2].valueSize := SizeOf(LWritingDirection);
  LParagraphSettings[2].value := @LWritingDirection;

  LParagraphStyle := CTParagraphStyleCreate(@LParagraphSettings[0], Length(LParagraphSettings));
  try
    CFAttributedStringSetAttribute(AAttributes.Handle, AAttributes.Range, kCTParagraphStyleAttributeName, LParagraphStyle);
  finally
    CFRelease(LParagraphStyle);
  end;
end;

class function TfgiOSTextRender.CreateAttributes(const AText: string): TTextAttributes;
var
  LTextString: CFStringRef;
begin
  LTextString := CFStringCreateWithCharacters(nil, PChar(AText), AText.Length);
  try
    Result.Range := CFRange.Create(0, CFStringGetLength(LTextString));
    Result.Handle := CFAttributedStringCreateMutable(nil, 0);
    CFAttributedStringReplaceString(Result.Handle, CFRange.Empty, LTextString);
  finally
    CFRelease(LTextString);
  end;
end;

class procedure TfgiOSTextRender.SetupHorizontalAlignment(const AContext: CGContextRef; const AFrameSize,
  ATextSize: TSizeF; const AHorizontalAlign: TfgHorizontalAlignment);
begin
  case AHorizontalAlign of
    TfgHorizontalAlignment.Left:;
    TfgHorizontalAlignment.Center:
      CGContextTranslateCTM(AContext, (AFrameSize.Width - ATextSize.Width) / 2, 0);
    TfgHorizontalAlignment.Right:
      CGContextTranslateCTM(AContext, AFrameSize.Width - ATextSize.Width, 0);
  else
    raise EfgAssertError.CreateFmt(SUnknownValue, ['TfgHorizontalAlignment']);
  end;
end;

class procedure TfgiOSTextRender.SetupVerticalAlignment(const AContext: CGContextRef; const AFrameSize,
  ATextSize: TSizeF; const AVerticalAlign: TfgVerticalAlignment);
begin
  case AVerticalAlign of
    TfgVerticalAlignment.Top:
      CGContextTranslateCTM(AContext, 0, AFrameSize.Height - ATextSize.Height);
    TfgVerticalAlignment.Center:
      CGContextTranslateCTM(AContext, 0, (AFrameSize.Height - ATextSize.Height) / 2);
    TfgVerticalAlignment.Bottom:;
  else
    raise EfgAssertError.CreateFmt(SUnknownValue, ['TfgVerticalAlignment']);
  end;
end;

{ TfgiOSGraphicsRender }

constructor TfgiOSGraphicsImageRender.Create(const ASize: TSizeF);
begin
  FRender := TUIGraphicsImageRenderer.Wrap(TUIGraphicsImageRenderer.Alloc.initWithSize(CGSize.Create(ASize)));
end;

function TfgiOSGraphicsImageRender.Render(const ARenderCallback: TfgiOSGraphicsRenderCallback): UIImage;
begin
  TfgAssert.IsTrue(Assigned(ARenderCallback), 'ARenderCallback');

  FCallback := ARenderCallback;
  try
    Result := FRender.imageWithActions(RenderBlock);
  finally
    FCallback := nil
  end;
end;

class function TfgiOSGraphicsImageRender.Render(const ASize: TSizeF; const ARenderCallback: TfgiOSGraphicsRenderCallback): UIImage;
var
  Render: TfgiOSGraphicsImageRender;
begin
  Render := TfgiOSGraphicsImageRender.Create(ASize);
  try
    Result := Render.Render(ARenderCallback);
  finally
    Render.Free;
  end;
end;

procedure TfgiOSGraphicsImageRender.RenderBlock(rendererContext: UIGraphicsImageRendererContext);
begin
  FCallback(rendererContext);
end;

end.
