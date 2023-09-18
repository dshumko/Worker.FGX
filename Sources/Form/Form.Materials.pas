unit Form.Materials;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, Generics.Collections,
  FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types, Base.BaseListViewForm, FGX.NavigationBar.Types,
  FGX.AutocompleteEdit.Types, FGX.CollectionView, FGX.Edit,
  FGX.AutocompleteEdit, FGX.SearchEdit, FGX.StaticLabel, FGX.ActivityIndicator,
  FGX.NavigationBar, FGX.Image, FGX.CardPanel, FGX.Button.Types, FGX.Button,
  ServiceUnit.mwClasses, ServiceUnit.API, XSuperObject;

type
  TmwFormMaterials = class(TmwBaseListViewForm)
    lvContent_StyleSecondary: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    pnLabels: TfgLayout;
    lbSecPrimary: TfgLabel;
    lbSecSecondary: TfgLabel;
    imSecondary: TfgImage;
    lvAvailable: TfgCollectionView;
    lvAvailable_Styles: TfgCollectionViewStyles;
    lvAvailable_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    fgLayout1: TfgLayout;
    fgLabel1: TfgLabel;
    fgLabel2: TfgLabel;
    fgImage1: TfgImage;
    fgLayout2: TfgLayout;
    lbHeaderPrimary: TfgLabel;
    lvAvailable_Style2: TfgCollectionViewStyle;
    fgCollectionViewStyle1: TfgCollectionViewStyle;
    procedure fgFormCreate(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvContentGetItemCount(Sender: TObject): Integer;
    function lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvAvailableBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    function lvAvailableGetItemCount(Sender: TObject): Integer;
    function lvAvailableGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure lvAvailableTapItem(Sender: TObject; const AIndex: Integer);
    procedure lvContentTapItem(Sender: TObject; const AIndex: Integer);
    procedure nbFormNavigationIconTap(Sender: TObject);
    procedure fgFormShow(Sender: TObject);
    procedure seSearchChanging(Sender: TObject); override;
  private
    FObjectId: Integer;
    FCurrentList: TObjectList<TmwMaterialItem>;
    FSelectedList: TObjectList<TmwMaterialItem>;
  protected
    procedure ThreadApiCall(API: TmwAPI); override;
    procedure ThreadFillData(API: TmwAPI); override;
  public
    procedure SetParams(Values: array of Variant); virtual;
  end;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Math,
  FGX.Application, FGX.Dialogs, FGX.Log, FGX.Animation, FGX.Animation.Types,
  ServiceUnit.Utils, Form.MaterialAddRemove;

{ TmwFormMaterials }

procedure TmwFormMaterials.lvAvailableBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  if AStyle <> 'Style-Empty' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FCurrentList[AIndex].name;
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := RoundTo(FCurrentList[AIndex].rest.ToSingle, -2)
      .ToString;
  end;
end;

function TmwFormMaterials.lvAvailableGetItemCount(Sender: TObject): Integer;
begin
  if FCurrentList <> nil then
    Result := FCurrentList.Count
  else
    Result := 0;
end;

function TmwFormMaterials.lvAvailableGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FCurrentList[AIndex].name.ToLower) > 0) then
    Result := 'Style-Secondary'
  else
    Result := 'Style-Empty';
end;

procedure TmwFormMaterials.lvAvailableTapItem(Sender: TObject; const AIndex: Integer);
var
  fAddRemove: TmwMaterialAddRemove;
begin
  inherited;
  if FCurrentList[AIndex].rest.ToSingle = 0 then
    Exit;
  lvAvailable.Opacity := 0.3;
  lvContent.Opacity := 0.3;
  edSearch.Opacity := 0.3;
  fAddRemove := TmwMaterialAddRemove.Create(Application);
  fAddRemove.SetParams(FCurrentList[AIndex].id, FCurrentList[AIndex].name, FCurrentList[AIndex].rest,
    FCurrentList[AIndex].rest.ToSingle, 0, True, FCurrentList[AIndex].int.ToBoolean);
  fAddRemove.OnApplyParameters :=
      procedure(const AId: Integer; const ADirection: Boolean; const ACount: Single; const AInt: Boolean)
    var
      item: TmwMaterialItem;
      i: Integer;
      rest: Single;
      found: Boolean;
      name: string;
      wh_id: Integer;
    begin
      lvAvailable.Opacity := 1;
      lvContent.Opacity := 1;
      edSearch.Opacity := 1;
      wh_id := -1;
      if ACount > 0 then
      begin
        for i := 0 to FCurrentList.Count - 1 do
        begin
          if FCurrentList[i].id = AId then
          begin
            rest := FCurrentList[i].rest.ToSingle - ACount;
            FCurrentList[i].rest := rest.ToString;
            name := FCurrentList[i].name;
            wh_id := FCurrentList[i].wh_id;
            Break;
          end;
        end;
        found := false;
        for i := 0 to FSelectedList.Count - 1 do
        begin
          if FSelectedList[i].id = AId then
          begin
            rest := FSelectedList[i].rest.ToSingle + ACount;
            FSelectedList[i].rest := rest.ToString;
            found := True;
            Break;
          end;
        end;
        if (not found) and (ACount > 0) then
        begin
          item := TmwMaterialItem.Create;
          item.id := AId;
          item.name := name;
          item.rest := RoundTo(ACount, -2).ToString;
          item.int := AInt.ToInteger;
          item.wh_id := wh_id;
          FSelectedList.Add(item);
        end;
        lvContent.ReloadItems;
        lvAvailable.ReloadItems;
      end;
    end;
  TfgAnimationHelper.ShowModalForm(fAddRemove, [TfgAnimationOption.StartFromCurrent]);
end;

procedure TmwFormMaterials.fgFormCreate(Sender: TObject);
begin
  inherited;
  FCurrentList := TObjectList<TmwMaterialItem>.Create(True);
  FSelectedList := TObjectList<TmwMaterialItem>.Create(True);
end;

procedure TmwFormMaterials.fgFormDestroy(Sender: TObject);
begin
  inherited;
  FCurrentList.Free;
  FSelectedList.Free;
end;

procedure TmwFormMaterials.fgFormShow(Sender: TObject);
begin
  inherited;
  edSearch.OnChanging := seSearchChanging;
end;

procedure TmwFormMaterials.lvContentBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
begin
  inherited;
  if AStyle <> 'Style-Empty' then
  begin
    AItem.GetControlByLookupName<TfgLabel>('primary').Text := FSelectedList[AIndex].name;
    AItem.GetControlByLookupName<TfgLabel>('secondary').Text := RoundTo(FSelectedList[AIndex].rest.ToSingle,
      -2).ToString;
  end;
end;

function TmwFormMaterials.lvContentGetItemCount(Sender: TObject): Integer;
begin
  if FSelectedList <> nil then
    Result := FSelectedList.Count
  else
    Result := 0;
end;

function TmwFormMaterials.lvContentGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  if edSearch.Text.IsEmpty or (Pos(edSearch.Text.ToLower, FSelectedList[AIndex].name.ToLower) > 0) then
    Result := 'Style-Secondary'
  else
    Result := 'Style-Empty';
end;

procedure TmwFormMaterials.lvContentTapItem(Sender: TObject; const AIndex: Integer);
var
  fAddRemove: TmwMaterialAddRemove;
begin
  inherited;
  lvAvailable.Opacity := 0.3;
  lvContent.Opacity := 0.3;
  edSearch.Opacity := 0.3;
  fAddRemove := TmwMaterialAddRemove.Create(Application);
  fAddRemove.SetParams(FSelectedList[AIndex].id, FSelectedList[AIndex].name, FSelectedList[AIndex].rest,
    FSelectedList[AIndex].rest.ToSingle, 0, false, FSelectedList[AIndex].int.ToBoolean);
  fAddRemove.OnApplyParameters :=
      procedure(const AId: Integer; const ADirection: Boolean; const ACount: Single; const AInt: Boolean)
    var
      item: TmwMaterialItem;
      i: Integer;
      rest: Single;
      found: Boolean;
      name: string;
    begin
      lvAvailable.Opacity := 1;
      lvContent.Opacity := 1;
      edSearch.Opacity := 1;
      if ACount > 0 then
      begin
        for i := 0 to FSelectedList.Count - 1 do
        begin
          if FSelectedList[i].id = AId then
          begin
            rest := FSelectedList[i].rest.ToSingle - ACount;
            name := FSelectedList[i].name;
            if rest = 0 then
              FSelectedList.Delete(i)
            else
              FSelectedList[i].rest := rest.ToString;
            Break;
          end;
        end;
        found := false;
        for i := 0 to FCurrentList.Count - 1 do
        begin
          if FCurrentList[i].id = AId then
          begin
            rest := FCurrentList[i].rest.ToSingle + ACount;
            FCurrentList[i].rest := rest.ToString;
            found := True;
            Break;
          end;
        end;
        if not found then
        begin
          item := TmwMaterialItem.Create;
          item.id := AId;
          item.name := name;
          item.rest := RoundTo(ACount, -2).ToString;
          FCurrentList.Add(item);
        end;
        lvContent.ReloadItems;
        lvAvailable.ReloadItems;
      end;
    end;
  TfgAnimationHelper.ShowModalForm(fAddRemove, [TfgAnimationOption.StartFromCurrent]);
end;

procedure TmwFormMaterials.nbFormNavigationIconTap(Sender: TObject);
var
  aIDS, aWHIDs, aCounts: string;
  i: Integer;
begin
  aIDS := '';
  aWHIDs := '';
  aCounts := '';

  for i := 0 to FSelectedList.Count - 1 do
  begin
    aIDS := aIDS + ',' + FSelectedList[i].id.ToString;
    aCounts := aCounts + ',' + FSelectedList[i].rest;
    aWHIDs := aWHIDs + ',' + FSelectedList[i].wh_id.ToString;
  end;
  aIDS := aIDS.Trim([',']);
  aCounts := aCounts.Trim([',']);
  aWHIDs := aWHIDs.Trim([',']);
  SaveLocalBidMaterials(FObjectId, aIDS, aCounts, aWHIDs);
  inherited;
end;

procedure TmwFormMaterials.seSearchChanging(Sender: TObject);
begin
  inherited;
  lvAvailable.ReloadItems;
  lvContent.ReloadItems;
end;

procedure TmwFormMaterials.SetParams(Values: array of Variant);
begin
  if Length(Values) > 0 then
  begin
    FObjectId := Values[0];
  end;
end;

procedure TmwFormMaterials.ThreadApiCall(API: TmwAPI);
begin
  inherited;
  API.GetMaterials;
end;

procedure TmwFormMaterials.ThreadFillData(API: TmwAPI);
var
  x: ISuperObject;
  i: Integer;
  item, selItem: TmwMaterialItem;
  selMaterials: TmwLocalBidMaterials;
  arrIDs, arrCounts: TArray<string>;
  idx: Integer;
  ol: ISuperArray;
begin
  inherited;
  LoadLocalBidMaterials(FObjectId, selMaterials);
  if Assigned(selMaterials) then
  begin
    arrIDs := selMaterials.ids.Split([',']);
    arrCounts := selMaterials.counts.Split([',']);
  end;
  ol := API.ResultJson['struct'].AsArray;
  if ol.Length > 0 then
  begin
    for i := 0 to ol.Length - 1 do
    begin
      x := ol.O[i];
      item := TmwMaterialItem.Create;
      item.LoadFromJSON(x);
      idx := TGenericsUtils.AScan(arrIDs, item.id.ToString);
      if idx >= 0 then
      begin
        selItem := TmwMaterialItem.Create;
        selItem.id := item.id;
        selItem.name := item.name;
        selItem.rest := arrCounts[idx];
        selItem.wh_id := item.wh_id;
        selItem.int := item.int;
        item.rest := RoundTo(item.rest.ToSingle - selItem.rest.ToSingle, -2).ToString;
        ol.Add(selItem.AsJsonObj);
        FSelectedList.Add(selItem);
      end;
      FCurrentList.Add(item)
    end;
  end;
end;

end.
