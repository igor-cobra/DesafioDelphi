unit UntClassSql0;

interface

uses
  System.Classes, System.SysUtils;

type
  TSQLOperation = (soSelect, soInsert, soUpdate, soDelete);

  TSQLBuilder = class
  private
    FTabela: string;
    FCampos: TStringList;
    FCondicoes: TStringList;
    function GerarCampos: string; //gera uma string que representa uma lista de campos separados por vírgulas a partir dos campos armazenados em FCampos
    function GerarCondicoes: string; //gera uma string que representa uma lista de condições separadas por "AND" a partir das condições armazenadas em FCondicoes.
    function GerarGroupBy: string; //gera uma string que representa a cláusula "GROUP BY" a partir dos campos armazenados em FCampos
    function PossuiFuncoesAgregadas: Boolean; //verifica se existe pelo menos uma função agregada entre os campos armazenados em FCampos
    function CamposNaoAgregados: string; //retorna o primeiro campo que não é uma função agregada
  public
    constructor Create(sTabela: string);
    destructor Destroy; override;
    function GerarSQL(Operation: TSQLOperation): TStringList; //gera uma lista de strings que representa uma consulta SQL completa, dependendo da operação informada (select, insert, update, delete).
    property Tabela: string read FTabela write FTabela;
    property Campos: TStringList read FCampos write FCampos;
    property Condicoes: TStringList read FCondicoes write FCondicoes;
  end;

implementation

{ TSQLBuilder }

constructor TSQLBuilder.Create(sTabela: string);
begin
  FTabela := sTabela;
  FCampos := TStringList.Create;
  FCondicoes := TStringList.Create;
end;

destructor TSQLBuilder.Destroy;
begin
  FCampos.Free;
  FCondicoes.Free;
  inherited;
end;

function TSQLBuilder.GerarCampos: string;
var
  iCont: Integer;
begin
  Result := '';
  for iCont := 0 to FCampos.Count - 1 do begin
    Result := Result + FCampos[iCont];
    if iCont < FCampos.Count - 1 then
      Result := Result + ', ';
  end;
end;

function TSQLBuilder.GerarCondicoes: string;
var
  iCont: Integer;
begin
  Result := '';
  for iCont := 0 to FCondicoes.Count - 1 do begin
    Result := Result + FCondicoes[iCont];
    if iCont < FCondicoes.Count - 1 then
      Result := Result + ' AND ';
  end;
end;

function TSQLBuilder.GerarGroupBy: string;
var
  sCampos: string;
begin
  Result := '';
  if PossuiFuncoesAgregadas then begin
    sCampos := CamposNaoAgregados;
    if sCampos <> '' then
      Result := ' GROUP BY ' + sCampos;
  end;
end;

function TSQLBuilder.GerarSQL(Operation: TSQLOperation): TStringList;
var
  Campos, Valores, Condicoes, GroupBy: string;
  iCont: Integer;
begin
  Result := TStringList.Create;
  Campos := GerarCampos;
  Condicoes := GerarCondicoes;
  GroupBy := GerarGroupBy;
  case Operation of
    soSelect:
      begin
        if Campos <> '' then begin
          Result.Add('SELECT ' + Campos);
          Result.Add('FROM ' + FTabela);
        end else begin
          Result.Add('SELECT *');
          Result.Add('FROM ' + FTabela);
        end;

        if Condicoes <> '' then
          Result.Add('WHERE ' + Condicoes);

        if GroupBy <> '' then
          Result.Add(GroupBy);
      end;
    soInsert:
      begin
        Valores := '';
        for iCont := 0 to FCampos.Count - 1 do begin
          Valores := Valores + ':' + FCampos[iCont];
          if iCont < FCampos.Count - 1 then
            Valores := Valores + ', ';
        end;
        Result.Add('INSERT INTO ' + FTabela + ' (' + Campos + ') VALUES (' + Valores + ')');
      end;
    soUpdate:
      begin
        Result.Add('UPDATE ' + FTabela + ' SET ' + Campos + ' WHERE ' + Condicoes);
      end;
    soDelete:
      begin
        Result.Add('DELETE FROM ' + FTabela + ' WHERE ' + Condicoes);
      end;
  end;
end;

function TSQLBuilder.PossuiFuncoesAgregadas: Boolean;
var
  iCont: Integer;
begin
  Result := False;
  for iCont := 0 to FCampos.Count - 1 do
    if AnsiPos('(', FCampos[iCont]) > 0 then begin
      Result := True;
      Break;
    end;
end;

function TSQLBuilder.CamposNaoAgregados: string;
var
  iCont: Integer;
begin
  Result := '';
  for iCont := 0 to FCampos.Count - 1 do begin
    if AnsiPos('(', FCampos[iCont]) = 0 then begin
      Result := Result + FCampos[iCont] + ', ';
    end;
  end;
  Result := Copy(Result, 1, Length(Result) - 2);
end;

end.

