unit untClassFunc0;

interface

uses
  Data.DB, Datasnap.DBClient, System.Classes, System.SysUtils, System.Math;

type
  TTipoCalculo = (tpSoma, tpMedia);

  RFuncionario = record
    id: Integer;
    nome: string;
    salario: Real;
  end;

  IFuncionario = interface
    function GetSalario(Ids: TArray<Integer>; tpCalculo: TTipoCalculo): Real;
    function GetIds(sIds: string = ''): TArray<Integer>;
    function ExisteId(sId: string): Boolean;
  end;

  //todas as valida��es e manipula��o dos dados ser�o feitas nessa classe
  TFuncionario = class(TInterfacedObject, IFuncionario)
  private
    Fcds: TClientDataSet;
    procedure SetDadosFuncionarios;
  public
    constructor Create(AClientDataSet: TClientDataSet);
    function GetSalario(Ids: TArray<Integer>; tpCalculo: TTipoCalculo): Real;
    function GetIds(sIds: string = ''): TArray<Integer>;
    function ExisteId(sId: string): Boolean;
  end;

implementation

{ TFuncionario }

constructor TFuncionario.Create(AClientDataSet: TClientDataSet);
begin
  Fcds := AClientDataSet;
  SetDadosFuncionarios;
end;

function TFuncionario.ExisteId(sId: string): Boolean;
begin
  //Utiliza a propriedade Filter do ClientDataSet, caso n�o esteja vazio o funcion�rio existe.
  //Foi desabilitado os controles para este processo de filtrar n�o seja vis�vel ao usu�rio
  try
    FCds.DisableControls;
    FCds.Filter := 'ID_FUNCIONARIO = ' + sId;
    FCds.Filtered := True;

    if not FCds.Eof then
      Result := True
    else
      Result := False;
  finally
    FCds.Filtered := False;
    FCds.EnableControls;
  end;
end;

function TFuncionario.GetIds(sIds: string = ''): TArray<Integer>;
var
  Ids: TArray<string>;
  iCont: Integer;
  iResult: TArray<Integer>;
begin
  if sIds = '' then begin
    try
      //Seleciona todos os ids
      SetLength(iResult, FCds.RecordCount - 1);
      FCds.First;
      FCds.DisableControls;
      for iCont := 0 to FCds.RecordCount - 1 do begin
        iResult[iCont] := FCds.FieldByName('ID_FUNCIONARIO').AsInteger;

        FCds.Next;
      end;
    finally
      FCds.First;
      FCds.EnableControls;
    end;
  end
  else begin
    //Seleciona os ids informados
    Ids := sIds.Split([';']);
    SetLength(iResult, Length(Ids));

    for iCont := 0 to High(Ids) do
      iResult[iCont] := StrToInt(Ids[iCont]);
  end;
end;

function TFuncionario.GetSalario(Ids: TArray<Integer>; tpCalculo: TTipoCalculo): Real;
var
  iCont: Integer;
  nResult: Real;
  Bookmark: TBookmark;
begin
  //Utiliza a lista de Ids para pegar o sal�rio dos funcion�rios, � utilizado o bookmark para deixar a posi��o da Grid selecionada
  //fazendo assim o usu�rio n�o perceber o processo caso ele tenha selecionado um usu�rio diferente
  try
    nResult := 0;
    Bookmark := FCds.Bookmark;
    FCds.DisableControls;
    FCds.First;

    for iCont := Low(Ids) to High(Ids) do begin
      FCds.Filter := 'ID_FUNCIONARIO = ' + Ids[iCont].ToString;
      FCds.Filtered := True;
      if not FCds.Eof then
        nResult := nResult + FCds.FieldByName('VL_SALARIO').AsFloat;
      FCds.Filtered := False;
    end;
  finally
    FCds.Bookmark := Bookmark;
    FCds.EnableControls;
  end;

  case tpCalculo of
    tpSoma:
      Result := nResult;
    tpMedia:
      Result := nResult / Length(Ids);
  end;
end;

procedure TFuncionario.SetDadosFuncionarios;
var
  Funcionario: RFuncionario;
  iCont: integer;
begin
  Fcds.Close;
  Fcds.CreateDataSet;
  FCds.DisableControls; //Desabilitar os controles do ClientDataSet ajudam a otimizar a execu��o dos processos

  {um Loop para gerar os dados dos funcion�rios, foi utilizado um Record para gerar os dados e inseridos o ClientDataSet.
   Para este caso em espec�fico n�o � muito �til, mas se adicionar alguma complexidade ao c�digo como pegar os dados de terceiros
   esse seria o recomendado, se fosse em REST eu utilizaria um objeto para manipular os dados de uma forma mais simples e f�cil
   de compreender}
  for iCont := 0 to Random(50) - 1 do begin
    //Inserindo os dados no Record
    Funcionario.id := iCont + 1;
    Funcionario.Nome := 'Funcion�rio[' + IntToStr(iCont + 1) + ']';
    Funcionario.Salario := RandomRange(13200, 132000) / 100;

    //Como n�o � necess�rio nenhuma valida��o, os dados j� s�o passados em seguida para o ClientDataSet
    FCds.Append;
    FCds.FieldByName('ID_FUNCIONARIO').AsInteger := Funcionario.Id;
    FCds.FieldByName('NM_FUNCIONARIO').AsString := Funcionario.Nome;
    FCds.FieldByName('VL_SALARIO').AsCurrency := Funcionario.Salario;
    FCds.Post;
  end;

  FCds.First;
  FCds.EnableControls;
end;

end.

