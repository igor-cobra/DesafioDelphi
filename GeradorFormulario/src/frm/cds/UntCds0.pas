unit UntCds0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask,
  Datasnap.DBClient;

type
  dsType = (cdsBrowse, cdsInsert, cdsEdit);

  TfrmCdsCad0 = class(TForm)
    pnlBottom: TPanel;
    dbgDadosComp: TDBGrid;
    dsDadosComp: TDataSource;
    grpDadosComp: TGroupBox;
    lbl: TLabel;
    fldLABELCAPTION: TEdit;
    lbl1: TLabel;
    fldTIPOCOMPONENTE: TEdit;
    lbl2: TLabel;
    fldLARGURACOMPONENTE: TEdit;
    lbl3: TLabel;
    fldALTURACOMPONENTE: TEdit;
    lbl4: TLabel;
    fldITENS: TEdit;
    cdsDadosComp: TClientDataSet;
    cdsDadosCompLABELCAPTION: TStringField;
    cdsDadosCompTIPOCOMPONENTE: TStringField;
    cdsDadosCompLARGURACOMPONENTE: TIntegerField;
    cdsDadosCompALTURACOMPONENTE: TIntegerField;
    cdsDadosCompITENS: TStringField;
    dbnDadosComp: TDBNavigator;
    btnPreview: TButton;
    procedure FormCreate(Sender: TObject);
    procedure dbnDadosCompClick(Sender: TObject; Button: TNavigateBtn);
    procedure dsDadosCompDataChange(Sender: TObject; Field: TField);
    procedure btnPreviewClick(Sender: TObject);
  private
    dsEstado: dsType;
    procedure HabilitaCampos(bHabilita: Boolean);
    procedure LimpaFields;
    function ValidaDados: Boolean;
    function ComponentePossuiItems(Componente: TComponent): Boolean;
  public
    { Public declarations }
  end;

var
  frmCdsCad0: TfrmCdsCad0;

implementation

uses
  System.Rtti, UntClassForm0;

{$R *.dfm}

procedure TfrmCdsCad0.btnPreviewClick(Sender: TObject);
var
  TFrmCustom: TFormDinamico;
begin
  tFrmCustom := TFormDinamico.Create(cdsDadosComp);
  tFrmCustom.ShowForm;
end;

function TfrmCdsCad0.ComponentePossuiItems(Componente: TComponent): Boolean;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
begin
  Result := False;
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(Componente.ClassType);
    Prop := RttiType.GetProperty('Items');
    if Prop <> nil then
      Result := True;
  finally
    Context.Free;
  end;
end;

procedure TfrmCdsCad0.dbnDadosCompClick(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbFirst:
      cdsDadosComp.First;
    nbPrior:
      cdsDadosComp.Prior;
    nbNext:
      cdsDadosComp.Next;
    nbLast:
      cdsDadosComp.Last;
    nbInsert:
      begin
        LimpaFields;
        HabilitaCampos(True);
        dsEstado := cdsInsert;
      end;
    nbDelete:
      cdsDadosComp.Delete;
    nbEdit:
      begin
        HabilitaCampos(True);
        dsEstado := cdsEdit;
      end;
    nbPost:
      begin
        if ValidaDados then begin
          cdsDadosComp.Edit;

          cdsDadosCompLABELCAPTION.AsString := fldLABELCAPTION.Text;
          cdsDadosCompTIPOCOMPONENTE.AsString := fldTIPOCOMPONENTE.Text;
          cdsDadosCompLARGURACOMPONENTE.AsInteger := StrToIntDef(fldLARGURACOMPONENTE.Text, 0);
          cdsDadosCompALTURACOMPONENTE.AsInteger := StrToIntDef(fldALTURACOMPONENTE.Text, 0);
          cdsDadosCompITENS.AsString := fldITENS.Text;

          cdsDadosComp.Post;
          HabilitaCampos(False);
        end;
      end;
    nbCancel:
      cdsDadosComp.Cancel;
    nbRefresh:
      cdsDadosComp.Refresh;
    nbApplyUpdates:
      begin
        fldLABELCAPTION.Text := cdsDadosCompLABELCAPTION.AsString;
        fldTIPOCOMPONENTE.Text := cdsDadosCompTIPOCOMPONENTE.AsString;
        fldLARGURACOMPONENTE.Text := cdsDadosCompLARGURACOMPONENTE.AsString;
        fldALTURACOMPONENTE.Text := cdsDadosCompALTURACOMPONENTE.AsString;
        fldITENS.Text := cdsDadosCompITENS.AsString;
        cdsDadosComp.ApplyUpdates(-1);
      end;
    nbCancelUpdates:
      begin
        fldLABELCAPTION.Text := cdsDadosCompLABELCAPTION.AsString;
        fldTIPOCOMPONENTE.Text := cdsDadosCompTIPOCOMPONENTE.AsString;
        fldLARGURACOMPONENTE.Text := cdsDadosCompLARGURACOMPONENTE.AsString;
        fldALTURACOMPONENTE.Text := cdsDadosCompALTURACOMPONENTE.AsString;
        fldITENS.Text := cdsDadosCompITENS.AsString;

        cdsDadosComp.CancelUpdates;
      end;
  end;
end;

procedure TfrmCdsCad0.dsDadosCompDataChange(Sender: TObject; Field: TField);
begin
  if dsEstado = cdsBrowse then begin
    fldLABELCAPTION.Text := cdsDadosCompLABELCAPTION.AsString;
    fldTIPOCOMPONENTE.Text := cdsDadosCompTIPOCOMPONENTE.AsString;
    fldLARGURACOMPONENTE.Text := cdsDadosCompLARGURACOMPONENTE.AsString;
    fldALTURACOMPONENTE.Text := cdsDadosCompALTURACOMPONENTE.AsString;
    fldITENS.Text := cdsDadosCompITENS.AsString;
  end;
end;

procedure TfrmCdsCad0.FormCreate(Sender: TObject);
begin
  frmCdsCad0.Caption := 'Gerador de Cadastro';
  cdsDadosComp.Close;
  cdsDadosComp.CreateDataSet;

  dsEstado := cdsBrowse;
  HabilitaCampos(False);
end;

procedure TfrmCdsCad0.HabilitaCampos(bHabilita: Boolean);
begin
  fldLABELCAPTION.Enabled := bHabilita;
  fldTIPOCOMPONENTE.Enabled := bHabilita;
  fldLARGURACOMPONENTE.Enabled := bHabilita;
  fldALTURACOMPONENTE.Enabled := bHabilita;
  fldITENS.Enabled := bHabilita;
end;

procedure TfrmCdsCad0.LimpaFields;
begin
  fldLABELCAPTION.Text := '';
  fldTIPOCOMPONENTE.Text := '';
  fldLARGURACOMPONENTE.Text := '';
  fldALTURACOMPONENTE.Text := '';
  fldITENS.Text := '';
end;

function TfrmCdsCad0.ValidaDados: Boolean;
var
  Componente: TComponent;
begin
  Result := True;

  if fldLABELCAPTION.Text = '' then begin
    ShowMessage('O label deve ser informado.');
    Result := False;
    Exit;
  end;

  if (fldLARGURACOMPONENTE.Text = '') or (fldALTURACOMPONENTE.Text = '') then begin
    ShowMessage('O componente precisa ter uma largura e altura informada.');
    Result := False;
    Exit;
  end;

  if fldTIPOCOMPONENTE.text = '' then begin
    ShowMessage('O tipo do componente deve ser informado.');
    Result := False;
    Exit;
  end;

  Componente := FindComponent(fldTIPOCOMPONENTE.Text);
  if Componente = nil then begin
    ShowMessage('O componente inserido não existe.');
    Result := False;
    Exit;
  end;

  if ComponentePossuiItems(Componente) and (fldITENS.Text = '') then begin
    ShowMessage('O componente possui a propriedade items, portanto algum deve ser informado');
    Result := False;
    Exit;
  end;
end;

end.

