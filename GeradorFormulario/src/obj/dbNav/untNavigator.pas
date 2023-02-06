unit untNavigator;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Data.DB;

type
  INavigator = interface
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    procedure CreateRecord;
    procedure EditRecord;
    procedure SaveRecord;
    procedure DeleteRecord;
    procedure CancelRecord;
    function GetDataSource: TDataSource;
    procedure SetDataSource(ADataSource: TDataSource);
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TNavigator = class(TInterfacedObject, INavigator)
  private
    FDataSource: TDataSource;
  public
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    procedure CreateRecord;
    procedure EditRecord;
    procedure SaveRecord;
    procedure DeleteRecord;
    procedure CancelRecord;
    function GetDataSource: TDataSource;
    procedure SetDataSource(ADataSource: TDataSource);
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TDBNavigator = class(TControl)
  private
    FNavigator: TNavigator;
    FFirstBtn: TButton;
    FLastBtn: TButton;
    FNextBtn: TButton;
    FPrevBtn: TButton;
    FInsertBtn: TButton;
    FEditBtn: TButton;
    FSaveBtn: TButton;
    FDeleteBtn: TButton;
    FCancelBtn: TButton;
    procedure FirstBtnClick(Sender: TObject);
    procedure LastBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetNavigator(ANavigator: TNavigator);
  end;

implementation

{ TNavigator }

procedure TNavigator.CancelRecord;
begin
  if DataSource.DataSet.State in [dsInsert, dsEdit] then
    DataSource.DataSet.Cancel;
end;

procedure TNavigator.CreateRecord;
begin
  DataSource.DataSet.Append;
end;

procedure TNavigator.DeleteRecord;
begin
  DataSource.DataSet.Delete;
end;

procedure TNavigator.EditRecord;
begin
  DataSource.DataSet.Edit;
end;

procedure TNavigator.First;
begin
  DataSource.DataSet.First;
end;

procedure TNavigator.Last;
begin
  DataSource.DataSet.Last;
end;

procedure TNavigator.Next;
begin
  DataSource.DataSet.Next;
end;

procedure TNavigator.Prior;
begin
  DataSource.DataSet.Prior;
end;

procedure TNavigator.SaveRecord;
begin
  if DataSource.DataSet.State in [dsInsert, dsEdit] then
    DataSource.DataSet.Post;
end;

function TNavigator.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;

procedure TNavigator.SetDataSource(ADataSource: TDataSource);
begin
  FDataSource := ADataSource;
end;

{ TDBNavigator }

constructor TDBNavigator.Create(AOwner: TComponent);
begin
  inherited;

  FFirstBtn := TButton.Create(Self);
  FFirstBtn.Caption := 'First';
  FFirstBtn.OnClick := FirstBtnClick;
  FFirstBtn.Parent := TWinControl(Self);

  FLastBtn := TButton.Create(Self);
  FLastBtn.Caption := 'Last';
  FLastBtn.OnClick := LastBtnClick;
  FLastBtn.Parent := TWinControl(Self);

  FNextBtn := TButton.Create(Self);
  FNextBtn.Caption := 'Next';
  FNextBtn.OnClick := NextBtnClick;
  FNextBtn.Parent := TWinControl(Self);

  FPrevBtn := TButton.Create(Self);
  FPrevBtn.Caption := 'Prev';
  FPrevBtn.OnClick := PrevBtnClick;
  FPrevBtn.Parent := TWinControl(Self);

  FInsertBtn := TButton.Create(Self);
  FInsertBtn.Caption := 'Insert';
  FInsertBtn.OnClick := InsertBtnClick;
  FInsertBtn.Parent := TWinControl(Self);

  FEditBtn := TButton.Create(Self);
  FEditBtn.Caption := 'Edit';
  FEditBtn.OnClick := EditBtnClick;
  FEditBtn.Parent := TWinControl(Self);

  FSaveBtn := TButton.Create(Self);
  FSaveBtn.Caption := 'Save';
  FSaveBtn.OnClick := SaveBtnClick;
  FSaveBtn.Parent := TWinControl(Self);

  FDeleteBtn := TButton.Create(Self);
  FDeleteBtn.Caption := 'Delete';
  FDeleteBtn.OnClick := DeleteBtnClick;
  FDeleteBtn.Parent := TWinControl(Self);

  FCancelBtn := TButton.Create(Self);
  FCancelBtn.Caption := 'Cancel';
  FCancelBtn.OnClick := CancelBtnClick;
  FCancelBtn.Parent := TWinControl(Self);
end;

procedure TDBNavigator.FirstBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.First;
end;

procedure TDBNavigator.LastBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.Last;
end;
procedure TDBNavigator.NextBtnClick(Sender: TObject);
begin
  FNavigator.Next;
end;

procedure TDBNavigator.PrevBtnClick(Sender: TObject);
begin
  FNavigator.Prior;
end;

procedure TDBNavigator.InsertBtnClick(Sender: TObject);
begin
  FNavigator.CreateRecord;
end;

procedure TDBNavigator.EditBtnClick(Sender: TObject);
begin
  FNavigator.EditRecord;
end;

procedure TDBNavigator.SaveBtnClick(Sender: TObject);
begin
  FNavigator.SaveRecord;
end;

procedure TDBNavigator.DeleteBtnClick(Sender: TObject);
begin
  FNavigator.DeleteRecord;
end;

procedure TDBNavigator.CancelBtnClick(Sender: TObject);
begin
  FNavigator.CancelRecord;
end;

procedure TDBNavigator.SetNavigator(ANavigator: TNavigator);
begin
  FNavigator := ANavigator;
end;

end.

