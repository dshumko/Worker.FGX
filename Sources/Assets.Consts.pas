{*********************************************************************
 *
 * Даннный модуль сгенерирован автоматически!
 *
 * НЕ ВНОСИТЕ изменения в этот файл, так как они будут потеряны после обновления ассетов в 
 * Project -> FGX Assets Manager.
 *
 * Используйте эти константы вместо того, чтобы вписывать названия ассетов в коде. Это поможет вам поймать
 * ситуации изменения ассетов (удаление, переименование) в дизайнере на этапе комплияции.
 *
 *********************************************************************}

unit Assets.Consts;

interface

{$SCOPEDENUMS ON}

type

  /// <summary>Константы с идентификаторами ресурсов приложения.</summary>
  TfgAssetsConstants = record
  private type

    TfgColors = record
    const
      COLORS_BIDSIGNALIEN = 'Colors\bidSignAlien';
      COLORS_BIDSIGNNOBODY = 'Colors\bidSignNobody';
      COLORS_BIDSIGNOWN = 'Colors\bidSignOwn';
      COLORS_BIDSIGNOWNLATE = 'Colors\bidSignOwnLate';
      COLORS_BTNGREEN = 'Colors\btnGreen';
      COLORS_BTNRED = 'Colors\btnRed';
      COLORS_CUSTOMEROFF = 'Colors\customerOff';
      COLORS_CUSTOMERPAYMENTSOUT = 'Colors\customerPaymentsOut';
    end;

    TfgBitmaps = record
    const
      ICONS_ADD = 'Icons\add';
      ICONS_ARROW_BACK = 'Icons\arrow back';
      ICONS_BOOKMARK = 'Icons\bookmark';
      ICONS_BOOKMARK_BORDER = 'Icons\bookmark border';
      ICONS_BOOKMARK_BIG = 'Icons\bookmark-big';
      ICONS_BUSINESS = 'Icons\business';
      ICONS_CAMERA_ALT = 'Icons\camera alt';
      ICONS_CHEVRON_LEFT = 'Icons\chevron left';
      ICONS_CHEVRON_RIGHT = 'Icons\chevron right';
      ICONS_CLOSE = 'Icons\close';
      ICONS_DELETE_FOREVER = 'Icons\delete forever';
      ICONS_EDIT = 'Icons\edit';
      ICONS_ENGINEERING = 'Icons\engineering';
      ICONS_HOUSE = 'Icons\house';
      ICONS_LIBRARY = 'Icons\library';
      ICONS_LIST = 'Icons\list';
      ICONS_LOCAL_ACTIVITY = 'Icons\local activity';
      ICONS_MAP = 'Icons\map';
      ICONS_MAP_BIG = 'Icons\map-big';
      ICONS_PHONE = 'Icons\phone';
      ICONS_PHOTO_CAMERA = 'Icons\photo camera';
      ICONS_REMOVE = 'Icons\remove';
      ICONS_ROUND_MASK = 'Icons\round mask';
      ICONS_SEARCH = 'Icons\search';
      M1 = 'm1';
      M2 = 'm2';
      M3 = 'm3';
      M4 = 'm4';
      M5 = 'm5';
      MENU = 'menu';
    end;

    TfgThemeColors = record
    const
      BACKGROUND = 'Theme\Background';
      ERROR = 'Theme\Error';
      ON_ERROR = 'Theme\On Error';
      ON_PRIMARY_DISABLED_TEXT = 'Theme\On Primary\Disabled Text';
      ON_PRIMARY_DIVIDERS = 'Theme\On Primary\Dividers';
      ON_PRIMARY_HINT_TEXT = 'Theme\On Primary\Hint Text';
      ON_PRIMARY_ICON = 'Theme\On Primary\Icon';
      ON_PRIMARY_SECONDARY_TEXT = 'Theme\On Primary\Secondary Text';
      ON_PRIMARY_TEXT = 'Theme\On Primary\Text';
      ON_SECONDARY_DISABLED_TEXT = 'Theme\On Secondary\Disabled Text';
      ON_SECONDARY_DIVIDERS = 'Theme\On Secondary\Dividers';
      ON_SECONDARY_HINT_TEXT = 'Theme\On Secondary\Hint Text';
      ON_SECONDARY_ICON = 'Theme\On Secondary\Icon';
      ON_SECONDARY_SECONDARY_TEXT = 'Theme\On Secondary\Secondary Text';
      ON_SECONDARY_TEXT = 'Theme\On Secondary\Text';
      PRIMARY_COLOR = 'Theme\Primary\Color';
      PRIMARY_DARK_PRIMARY = 'Theme\Primary\Dark Primary';
      PRIMARY_LIGHT_PRIMARY = 'Theme\Primary\Light Primary';
      SECONDARY_COLOR = 'Theme\Secondary\Color';
      SECONDARY_DARK_COLOR = 'Theme\Secondary\Dark Color';
      SECONDARY_LIGHT_COLOR = 'Theme\Secondary\Light Color';
      SURFACE = 'Theme\Surface';
      TEXT_DISABLED_TEXT = 'Theme\Text\Disabled Text';
      TEXT_DIVIDERS = 'Theme\Text\Dividers';
      TEXT_HINT_TEXT = 'Theme\Text\Hint Text';
      TEXT_ICON = 'Theme\Text\Icon';
      TEXT_SECONDARY_TEXT = 'Theme\Text\Secondary Text';
      TEXT_TEXT = 'Theme\Text\Text';
    end;

    TfgTheme = record
      /// <summary>Идентификаторы ресурсов с цветами темы.</summary>
      class var Color: TfgThemeColors;
    end;
  public
    /// <summary>Идентификаторы ресурсов с цветами.</summary>
    class var Color: TfgColors;

    /// <summary>Идентификаторы ресурсов с картинками.</summary>
    class var Bitmap: TfgBitmaps;

    /// <summary>Идентификаторы ресурсов темы.</summary>
    class var Theme: TfgTheme;
  end;

var
  R: TfgAssetsConstants;

implementation

end.
