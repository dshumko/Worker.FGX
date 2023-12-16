{*********************************************************************
 *
 * Данный модуль сгенерирован автоматически!
 *
 * НЕ ВНОСИТЕ изменения в этот файл, так как они будут потеряны после обновления ассетов в 
 * Project -> FGX Assets Manager.
 *
 * Используйте эти константы вместо того, чтобы вписывать названия ассетов в коде. Это поможет вам поймать
 * ситуации изменения ассетов (удаление, переименование) в дизайнере на этапе компиляции.
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
      COLORS_BIDSIGNALIEN = 'Colors\bidSignAlien';                              // #FFFFFF00
      COLORS_BIDSIGNNOBODY = 'Colors\bidSignNobody';                            // #FFFFFFFF
      COLORS_BIDSIGNOWN = 'Colors\bidSignOwn';                                  // #FF43A047
      COLORS_BIDSIGNOWNLATE = 'Colors\bidSignOwnLate';                          // #FFF44336
      COLORS_BTNGREEN = 'Colors\btnGreen';                                      // #FF4CAF50
      COLORS_BTNRED = 'Colors\btnRed';                                          // #FFF44336
      COLORS_CUSTOMEROFF = 'Colors\customerOff';                                // #FF9E9E9E
      COLORS_CUSTOMERPAYMENTSOUT = 'Colors\customerPaymentsOut';                // #FFF44336
      TEXT_DISABLED_TEXT = 'Text\Disabled Text';                                // #61000000
      TEXT_DIVIDERS = 'Text\Dividers';                                          // #1F000000
      TEXT_HINT_TEXT = 'Text\Hint Text';                                        // #61000000
      TEXT_ICON = 'Text\Icon';                                                  // #8A000000
      TEXT_SECONDARY_TEXT = 'Text\Secondary Text';                              // #8A000000
      TEXT_TEXT = 'Text\Text';                                                  // #FF000000
      THEME_DARK_BACKGROUND = 'Theme Dark\Background';                          // #FF121212
      THEME_DARK_ERROR = 'Theme Dark\Error';                                    // #FFCF6679
      THEME_DARK_ON_ERROR = 'Theme Dark\On Error';                              // #FF000000
      THEME_DARK_ON_PRIMARY_DISABLED_TEXT = 'Theme Dark\On Primary\Disabled Text';// #61000000
      THEME_DARK_ON_PRIMARY_DIVIDERS = 'Theme Dark\On Primary\Dividers';        // #85000000
      THEME_DARK_ON_PRIMARY_HINT_TEXT = 'Theme Dark\On Primary\Hint Text';      // #61000000
      THEME_DARK_ON_PRIMARY_ICON = 'Theme Dark\On Primary\Icon';                // #8A000000
      THEME_DARK_ON_PRIMARY_SECONDARY_TEXT = 'Theme Dark\On Primary\Secondary Text';// #8A000000
      THEME_DARK_ON_PRIMARY_TEXT = 'Theme Dark\On Primary\Text';                // #DE000000
      THEME_DARK_ON_SECONDARY_DISABLED_TEXT = 'Theme Dark\On Secondary\Disabled Text';// #61000000
      THEME_DARK_ON_SECONDARY_DIVIDERS = 'Theme Dark\On Secondary\Dividers';    // #1F000000
      THEME_DARK_ON_SECONDARY_HINT_TEXT = 'Theme Dark\On Secondary\Hint Text';  // #61000000
      THEME_DARK_ON_SECONDARY_ICON = 'Theme Dark\On Secondary\Icon';            // #8A000000
      THEME_DARK_ON_SECONDARY_SECONDARY_TEXT = 'Theme Dark\On Secondary\Secondary Text';// #8A000000
      THEME_DARK_ON_SECONDARY_TEXT = 'Theme Dark\On Secondary\Text';            // #DE000000
      THEME_DARK_PRIMARY_COLOR = 'Theme Dark\Primary\Color';                    // #FFFF8D40
      THEME_DARK_PRIMARY_DARK_PRIMARY = 'Theme Dark\Primary\Dark Primary';      // #FF662900
      THEME_DARK_PRIMARY_LIGHT_PRIMARY = 'Theme Dark\Primary\Light Primary';    // #FFFF6600
      THEME_DARK_SECONDARY_COLOR = 'Theme Dark\Secondary\Color';                // #FFE65C00
      THEME_DARK_SECONDARY_DARK_PRIMARY = 'Theme Dark\Secondary\Dark Primary';  // #FF662900
      THEME_DARK_SECONDARY_LIGHT_PRIMARY = 'Theme Dark\Secondary\Light Primary';// #FFFF8D40
      THEME_DARK_SURFACE = 'Theme Dark\Surface';                                // #FF121212
      THEME_DARK_TEXT_DISABLED_TEXT = 'Theme Dark\Text\Disabled Text';          // #BEFF8F3B
      THEME_DARK_TEXT_DIVIDERS = 'Theme Dark\Text\Dividers';                    // #8A979797
      THEME_DARK_TEXT_HINT_TEXT = 'Theme Dark\Text\Hint Text';                  // #80FFFFFF
      THEME_DARK_TEXT_ICON = 'Theme Dark\Text\Icon';                            // #FFFFFFFF
      THEME_DARK_TEXT_SECONDARY_TEXT = 'Theme Dark\Text\Secondary Text';        // #B3FFFFFF
      THEME_DARK_TEXT_TEXT = 'Theme Dark\Text\Text';                            // #FFFFFFFF
      THEME_LIGHT_BACKGROUND = 'Theme Light\Background';                        // #FFFFFFFF
      THEME_LIGHT_ERROR = 'Theme Light\Error';                                  // #FFB00020
      THEME_LIGHT_ON_ERROR = 'Theme Light\On Error';                            // #FFFFFFFF
      THEME_LIGHT_ON_PRIMARY_DISABLED_TEXT = 'Theme Light\On Primary\Disabled Text';// #80FFFFFF
      THEME_LIGHT_ON_PRIMARY_DIVIDERS = 'Theme Light\On Primary\Dividers';      // #1FFFFFFF
      THEME_LIGHT_ON_PRIMARY_HINT_TEXT = 'Theme Light\On Primary\Hint Text';    // #80FFFFFF
      THEME_LIGHT_ON_PRIMARY_ICON = 'Theme Light\On Primary\Icon';              // #FFFFFFFF
      THEME_LIGHT_ON_PRIMARY_SECONDARY_TEXT = 'Theme Light\On Primary\Secondary Text';// #B3FFFFFF
      THEME_LIGHT_ON_PRIMARY_TEXT = 'Theme Light\On Primary\Text';              // #FFFFFFFF
      THEME_LIGHT_ON_SECONDARY_DISABLED_TEXT = 'Theme Light\On Secondary\Disabled Text';// #80FFFFFF
      THEME_LIGHT_ON_SECONDARY_DIVIDERS = 'Theme Light\On Secondary\Dividers';  // #1FFFFFFF
      THEME_LIGHT_ON_SECONDARY_HINT_TEXT = 'Theme Light\On Secondary\Hint Text';// #80FFFFFF
      THEME_LIGHT_ON_SECONDARY_ICON = 'Theme Light\On Secondary\Icon';          // #FF040404
      THEME_LIGHT_ON_SECONDARY_SECONDARY_TEXT = 'Theme Light\On Secondary\Secondary Text';// #B3FFFFFF
      THEME_LIGHT_ON_SECONDARY_TEXT = 'Theme Light\On Secondary\Text';          // #FF040404
      THEME_LIGHT_PRIMARY_COLOR = 'Theme Light\Primary\Color';                  // #FFFF6600
      THEME_LIGHT_PRIMARY_DARK_PRIMARY = 'Theme Light\Primary\Dark Primary';    // #FF662900
      THEME_LIGHT_PRIMARY_LIGHT_PRIMARY = 'Theme Light\Primary\Light Primary';  // #FFFF8D40
      THEME_LIGHT_SECONDARY_COLOR = 'Theme Light\Secondary\Color';              // #FFE65C00
      THEME_LIGHT_SECONDARY_DARK_COLOR = 'Theme Light\Secondary\Dark Color';    // #FF662900
      THEME_LIGHT_SECONDARY_LIGHT_COLOR = 'Theme Light\Secondary\Light Color';  // #FFFF8D40
      THEME_LIGHT_SURFACE = 'Theme Light\Surface';                              // #FFFFFFFF
      THEME_LIGHT_TEXT_DISABLED_TEXT = 'Theme Light\Text\Disabled Text';        // #61000000
      THEME_LIGHT_TEXT_DIVIDERS = 'Theme Light\Text\Dividers';                  // #1F000000
      THEME_LIGHT_TEXT_HINT_TEXT = 'Theme Light\Text\Hint Text';                // #61000000
      THEME_LIGHT_TEXT_ICON = 'Theme Light\Text\Icon';                          // #8A000000
      THEME_LIGHT_TEXT_SECONDARY_TEXT = 'Theme Light\Text\Secondary Text';      // #8A000000
      THEME_LIGHT_TEXT_TEXT = 'Theme Light\Text\Text';                          // #FF000000
    end;

    TfgBitmaps = record
    const
      ICONS_ADD = 'Icons\add';                                                  
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
      ICONS_MENU = 'Icons\menu';                                                
      ICONS_PHONE = 'Icons\phone';                                              
      ICONS_PHOTO_CAMERA = 'Icons\photo camera';                                
      ICONS_REMOVE = 'Icons\remove';                                            
      ICONS_ROUND_MASK = 'Icons\round mask';                                    
      ICONS_SEARCH = 'Icons\search';                                            
      ICONS_SUNNY = 'Icons\Sunny';                                              
      M1 = 'm1';                                                                
      M2 = 'm2';                                                                
      M3 = 'm3';                                                                
      M4 = 'm4';                                                                
      M5 = 'm5';                                                                
      THEME_DARK_ICONS_ARROW_BACK = 'Theme Dark\Icons\arrow back';              
      THEME_DARK_ICONS_CHEVRON_LEFT = 'Theme Dark\Icons\chevron left';          
      THEME_DARK_ICONS_CHEVRON_RIGHT = 'Theme Dark\Icons\chevron right';        
      THEME_DARK_ICONS_CLOSE = 'Theme Dark\Icons\close';                        
      THEME_DARK_ICONS_MENU = 'Theme Dark\Icons\menu';                          
      THEME_LIGHT_ICONS_ARROW_BACK = 'Theme Light\Icons\arrow back';            
      THEME_LIGHT_ICONS_CHEVRON_LEFT = 'Theme Light\Icons\chevron left';        
      THEME_LIGHT_ICONS_CHEVRON_RIGHT = 'Theme Light\Icons\chevron right';      
      THEME_LIGHT_ICONS_CLOSE = 'Theme Light\Icons\close';                      
      THEME_LIGHT_ICONS_MENU = 'Theme Light\Icons\menu';                        
    end;
  public
    /// <summary>Идентификаторы ресурсов с цветами.</summary>
    class var Color: TfgColors;

    /// <summary>Идентификаторы ресурсов с картинками.</summary>
    class var Bitmap: TfgBitmaps;
  end;

var
  R: TfgAssetsConstants;

implementation

end.
