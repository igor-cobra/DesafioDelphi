unit untClassFunc0;

interface

uses
  Data.DB, Datasnap.DBClient, System.Classes, System.SysUtils, System.Math;

type
  RFuncionario = record
    id: Integer;
    nome: string;
    salario: Real;
  end;

  IFuncionario = interface
    function GetSalarioTotal(Ids: TArray<Integer>): Real;
    function GetMediaSalario(Ids: TArray<Integer>): Real;
    function GetTodosIds: TArray<Integer>;
    function GetIds(const sIds: string): TArray<Integer>;
    function ExisteId(iId: Integer): Boolean;
  end;

  TFuncionario = class(TInterfacedObject, IFuncionario)
  private
    Fcds: TClientDataSet;
    procedure SetDadosFuncionarios;
  public
    constructor Create(AClientDataSet: TClientDataSet);
    function GetSalarioTotal(Ids: TArray<Integer>): Real;
    function GetMediaSalario(Ids: TArray<Integer>): Real;
    function GetTodosIds: TArray<Integer>;
    function GetIds(const sIds: string): TArray<Integer>;
    function ExisteId(iId: Integer): Boolean;
  end;

implementation

{ TFuncionario }

constructor TFuncionario.Create(AClientDataSet: TClientDataSet);
begin
  Fcds := AClientDataSet;
  SetDadosFuncionarios;
end;

function TFuncionario.ExisteId(iId: Integer): Boolean;
begin
  FCds.DisableControls;
  FCds.Filter := 'ID_FUNCIONARIO = ' + IntToStr(iId);
  FCds.Filtered := True;

  if not FCds.Eof then
    Result := True
  else
    Result := False;

  FCds.Filtered := False;
  FCds.EnableControls;
end;

function TFuncionario.GetIds(const sIds: string): TArray<Integer>;
var
  Ids: TArray<string>;
  iCont: Integer;
begin
  Ids := sIds.Split([';']);
  SetLength(Result, Length(Ids));

  for iCont := 0 to High(Ids) do
    Result[iCont] := StrToIntDef(Ids[iCont], -1);
end;

function TFuncionario.GetMediaSalario(Ids: TArray<Integer>): Real;
var
  iCont: Integer;
  nResult: Currency;
  Bookmark: TBookmark;
begin
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

  FCds.Bookmark := Bookmark;
  FCds.EnableControls;

  Result := nResult / Length(Ids);
end;

function TFuncionario.GetSalarioTotal(Ids: TArray<Integer>): Real;
var
  iCont: Integer;
  Bookmark: TBookmark;
begin
  Result := 0;
  Bookmark := FCds.Bookmark;
  FCds.DisableControls;
  FCds.First;

  for iCont := Low(Ids) to High(Ids) do begin
    FCds.Filter := 'ID_FUNCIONARIO = ' + Ids[iCont].ToString;
    FCds.Filtered := True;
    if not FCds.Eof then
      Result := Result + FCds.FieldByName('VL_SALARIO').AsFloat;
    FCds.Filtered := False;
  end;

  FCds.Bookmark := Bookmark;
  FCds.EnableControls;
end;

function TFuncionario.GetTodosIds: TArray<Integer>;
var
  iCont: Integer;
begin
  SetLength(Result, FCds.RecordCount - 1);
  FCds.First;
  FCds.DisableControls;

  for iCont := 0 to FCds.RecordCount - 1 do begin
    Result[iCont] := FCds.FieldByName('ID_FUNCIONARIO').AsInteger;

    FCds.Next;
  end;

  FCds.First;
  FCds.EnableControls;
end;

procedure TFuncionario.SetDadosFuncionarios;
var
  Funcionario: RFuncionario;
  iCont: integer;
begin
  Fcds.Close;
  Fcds.CreateDataSet;
  FCds.DisableControls;

  for iCont := 0 to Random(50) - 1 do begin
    Funcionario.id := iCont + 1;
    Funcionario.Nome := 'Funcionário[' + IntToStr(iCont + 1) + ']';
    Funcionario.Salario := RandomRange(13200, 132000) / 100;

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

