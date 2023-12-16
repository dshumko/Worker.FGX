
program MobWorker;

uses
  System.SysUtils,
  FGX.Application,
  FGX.Forms,
  Form.Main in 'Form.Main.pas' {FormMain: TfgForm},
  ServiceUnit.mwClasses in 'ServiceUnit.mwClasses.pas',
  ServiceUnit.API in 'ServiceUnit.API.pas',
  ServiceUnit.Settings in 'ServiceUnit.Settings.pas',
  ServiceUnit.Utils in 'ServiceUnit.Utils.pas',
  ServiceUnit.BookMarks in 'ServiceUnit.BookMarks.pas',
  Base.BaseForm in 'Base\Base.BaseForm.pas' {mwBaseForm: TfgForm},
  Base.BaseApiForm in 'Base\Base.BaseApiForm.pas' {mwBaseApiForm: TfgForm},
  Base.BaseListViewForm in 'Base\Base.BaseListViewForm.pas' {mwBaseListViewForm: TfgForm},
  Frame.FormLogin in 'Frame\Frame.FormLogin.pas' {mwFormLogin: TfgForm},
  Frame.FormStreets in 'Frame\Frame.FormStreets.pas' {mwFormStreets: TfgForm},
  Frame.FormHouse in 'Frame\Frame.FormHouse.pas' {mwFormHouse: TfgForm},
  Frame.FormHouses in 'Frame\Frame.FormHouses.pas' {mwFormHouses: TfgForm},
  Frame.FormPromotions in 'Frame\Frame.FormPromotions.pas' {mwFormPromotions: TfgForm},
  Frame.FormContacts in 'Frame\Frame.FormContacts.pas' {mwFormContacts: TfgForm},
  Frame.FormBookMarks in 'Frame\Frame.FormBookMarks.pas' {mwFormBookMarks: TfgForm},
  Frame.FormBids in 'Frame\Frame.FormBids.pas' {mwBidList: TfgForm},
  Frame.FormBidInfo in 'Frame\Frame.FormBidInfo.pas' {mwFormBidInfo: TfgForm},
  Frame.FormCustomers in 'Frame\Frame.FormCustomers.pas' {mwFormCustomers: TfgForm},
  Frame.FormCustomer in 'Frame\Frame.FormCustomer.pas' {mwFormCustomer: TfgForm},
  Frame.FormEquipment in 'Frame\Frame.FormEquipment.pas' {mwFormEquipment: TfgForm},
  Form.FormBidClose in 'Form\Form.FormBidClose.pas' {mwFormBidClose: TfgForm},
  Form.BidPhoto in 'Form\Form.BidPhoto.pas' {mwFormBidPhoto: TfgForm},
  Form.Materials in 'Form\Form.Materials.pas' {mwFormMaterials: TfgForm},
  Form.MaterialAddRemove in 'Form\Form.MaterialAddRemove.pas' {mwMaterialAddRemove: TfgForm},
  Form.NewAbonent in 'Form\Form.NewAbonent.pas' {mwFormNewAbonent: TfgForm},
  Form.ServiceAdd in 'Form\Form.ServiceAdd.pas' {mwServiceAdd: TfgForm},
  Form.DiscountAdd in 'Form\Form.DiscountAdd.pas' {mwDiscountAdd: TfgForm},
  Form.EquipmentAdd in 'Form\Form.EquipmentAdd.pas' {mwEquipmentAdd: TfgForm},
  Frame.FormMap in 'Frame\Frame.FormMap.pas' {mwFormMap: TfgForm},
  Form.Works in 'Form\Form.Works.pas' {mwFormWorks: TfgForm},
  Assets.Consts in 'Assets.Consts.pas',
  Frame.LanPopup in 'Frame\Frame.LanPopup.pas' {FrameLanPopUp: TfgFrame},
  Form.ShowHtml in 'Form\Form.ShowHtml.pas' {fmShowHtml: TfgForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := false;
  Application.Initialize;
  FormatSettings.DecimalSeparator := '.';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;

end.
