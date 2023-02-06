unit UntDbNavigator;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Data.DB,
  untNavigator;

type
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

{ TDBNavigator }

constructor TDBNavigator.Create(AOwner: TComponent);
begin
  inherited;

  FFirstBtn := TButton.Create(Self);
  FFirstBtn.Parent := TWinControl(Self);
  FFirstBtn.Caption := 'First';
  FFirstBtn.OnClick := FirstBtnClick;

  FLastBtn := TButton.Create(Self);
  FLastBtn.Parent := TWinControl(Self);
  FLastBtn.Caption := 'Last';
  FLastBtn.OnClick := LastBtnClick;

  FNextBtn := TButton.Create(Self);
  FNextBtn.Parent := TWinControl(Self);
  FNextBtn.Caption := 'Next';
  FNextBtn.OnClick := NextBtnClick;

  FPrevBtn := TButton.Create(Self);
  FPrevBtn.Parent := TWinControl(Self);
  FPrevBtn.Caption := 'Prev';
  FPrevBtn.OnClick := PrevBtnClick;

  FInsertBtn := TButton.Create(Self);
  FInsertBtn.Parent := TWinControl(Self);
  FInsertBtn.Caption := 'Insert';
  FInsertBtn.OnClick := InsertBtnClick;

  FEditBtn := TButton.Create(Self);
  FEditBtn.Parent := TWinControl(Self);
  FEditBtn.Caption := 'Edit';
  FEditBtn.OnClick := EditBtnClick;

  FSaveBtn := TButton.Create(Self);
  FSaveBtn.Parent := TWinControl(Self);
  FSaveBtn.Caption := 'Save';
  FSaveBtn.OnClick := SaveBtnClick;

  FDeleteBtn := TButton.Create(Self);
  FDeleteBtn.Parent := TWinControl(Self);
  FDeleteBtn.Caption := 'Delete';
  FDeleteBtn.OnClick := DeleteBtnClick;

  FCancelBtn := TButton.Create(Self);
  FCancelBtn.Parent := TWinControl(Self);
  FCancelBtn.Caption := 'Cancel';
  FCancelBtn.OnClick := CancelBtnClick;
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
  if Assigned(FNavigator) then
    FNavigator.Next;
end;

procedure TDBNavigator.PrevBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.Prior;
end;

procedure TDBNavigator.InsertBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.CreateRecord;
end;

procedure TDBNavigator.EditBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.EditRecord;
end;

procedure TDBNavigator.SaveBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.SaveRecord;
end;

procedure TDBNavigator.DeleteBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.DeleteRecord;
end;

procedure TDBNavigator.CancelBtnClick(Sender: TObject);
begin
  if Assigned(FNavigator) then
    FNavigator.CancelRecord;
end;

procedure TDBNavigator.SetNavigator(ANavigator: TNavigator);
begin
  FNavigator := ANavigator;
end;

end.

