unit untCnsFunc0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Datasnap.DBClient,
  untClassFunc0;

type
  TFrmCnsFunc0 = class(TForm)
    pnlBottom: TPanel;
    dbgFuncionario: TDBGrid;
    cdsFuncionario: TClientDataSet;
    cdsFuncionarioID_FUNCIONARIO: TIntegerField;
    cdsFuncionarioNM_FUNCIONARIO: TStringField;
    cdsFuncionarioVL_SALARIO: TFloatField;
    dsFuncionario: TDataSource;
    rgFiltrarFunc: TRadioGroup;
    lblIdFuncionario: TLabel;
    fldListaFuncionario: TEdit;
    lblExemplo: TLabel;
    rgTipoCalculo: TRadioGroup;
    fldResultado: TEdit;
    btnCalcular: TButton;
    lblResultado: TLabel;
    procedure dbgFuncionarioDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rgFiltrarFuncClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCalcularClick(Sender: TObject);
  private
    Funcionario: TFuncionario;
    function ValidarListaFuncionario: Boolean;
    function ValidarIdsInformados: Boolean;
  public
    { Public declarations }
  end;

var
  FrmCnsFunc0: TFrmCnsFunc0;

const
  //Para facilitar qual botão foi informado no RadioGroup
  RG_FILTRO_NAO = 0;
  RG_FILTRO_SIM = 1;
  RG_CALCULO_SOMAR = 0;
  RG_CALCULO_MEDIA = 1;

implementation

{$R *.dfm}

procedure TFrmCnsFunc0.btnCalcularClick(Sender: TObject);
var
  Ids: TArray<Integer>;
  nValor: Real;
begin
  if not ValidarListaFuncionario then
    Exit;
  if rgFiltrarFunc.ItemIndex = RG_FILTRO_NAO then begin
    Ids := Funcionario.GetIds;
  end else begin
    if not ValidarIdsInformados then
      Exit;
    Ids := Funcionario.GetIds(fldListaFuncionario.Text);
  end;

  if rgTipoCalculo.ItemIndex = RG_CALCULO_SOMAR then
    nValor := Funcionario.GetSalario(Ids, tpSoma)
  else
    nValor := Funcionario.GetSalario(Ids, tpMedia);

  fldResultado.Text := FormatFloat('#,###0.00', nValor);
end;

procedure TFrmCnsFunc0.dbgFuncionarioDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color := clGradientInactiveCaption
  else
    TDBGrid(Sender).Canvas.Brush.Color := clWindow;
end;

procedure TFrmCnsFunc0.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Funcionario.Free;
end;

procedure TFrmCnsFunc0.FormCreate(Sender: TObject);
begin
  FrmCnsFunc0.Caption := 'Funcionários'; //nome de exibição do form
  Funcionario := TFuncionario.Create(cdsFuncionario); //Classe onde será gerado e manipulado os dados dos funcionários
end;

procedure TFrmCnsFunc0.rgFiltrarFuncClick(Sender: TObject);
begin
  fldListaFuncionario.Enabled := rgFiltrarFunc.ItemIndex = RG_FILTRO_SIM; //O campo para filtrar os funcionários estará habilitado somente precisar filtrar
end;

function TFrmCnsFunc0.ValidarIdsInformados: Boolean;
var
  sIds: TArray<string>;
  sLista: string;
  iCont: Integer;
  Id: Integer;
begin
  Result := True;
  //Caso tenha de filtrar os Ids
  if rgFiltrarFunc.ItemIndex = RG_FILTRO_SIM then begin
    if Trim(fldListaFuncionario.Text) = '' then begin
      ShowMessage('Deve ser informado pelo menos um funcionário.');
    end;

    sLista := fldListaFuncionario.Text;
    sIds := sLista.Split([';']);
    for iCont := 0 to High(sIds) do begin
      if not Funcionario.ExisteId(sIds[iCont]) then begin
        ShowMessage(Format('O ID %s não foi encontrado.', [sIds[iCont]]));
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TFrmCnsFunc0.ValidarListaFuncionario: Boolean;
var
  iCont: Integer;
begin
  Result := True;
  //Valida se os caracteres informados são os válidos
  for iCont := 1 to Length(fldListaFuncionario.Text) do begin
    if not CharInSet(fldListaFuncionario.Text[iCont], ['0'..'9', ';']) then begin
      ShowMessage('O campo de IDs possui caracteres inválidos.');
      Result := False;
      Exit;
    end;
  end;
end;

end.

