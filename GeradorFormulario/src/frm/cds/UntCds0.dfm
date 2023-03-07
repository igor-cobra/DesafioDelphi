object frmCdsCad0: TfrmCdsCad0
  Left = 0
  Top = 0
  Caption = 'frmCdsCad0'
  ClientHeight = 524
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 253
    Width = 698
    Height = 271
    Align = alBottom
    TabOrder = 1
    object grpDadosComp: TGroupBox
      Left = 24
      Top = 30
      Width = 545
      Height = 211
      Caption = 'Componentes'
      TabOrder = 0
      object lbl: TLabel
        Left = 64
        Top = 32
        Width = 65
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Caption Label'
        FocusControl = fldLABELCAPTION
        ParentBiDiMode = False
      end
      object lbl1: TLabel
        Left = 45
        Top = 91
        Width = 84
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Tipo Componente'
        FocusControl = fldTIPOCOMPONENTE
        ParentBiDiMode = False
      end
      object lbl2: TLabel
        Left = 275
        Top = 64
        Width = 101
        Height = 13
        Caption = 'Largura Componente'
        FocusControl = fldLARGURACOMPONENTE
      end
      object lbl3: TLabel
        Left = 36
        Top = 64
        Width = 93
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Altura Componente'
        FocusControl = fldALTURACOMPONENTE
        ParentBiDiMode = False
      end
      object lbl4: TLabel
        Left = 35
        Top = 118
        Width = 94
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Itens Componentes'
        FocusControl = fldITENS
        ParentBiDiMode = False
      end
      object fldLABELCAPTION: TEdit
        Left = 135
        Top = 29
        Width = 381
        Height = 21
        Enabled = False
        TabOrder = 0
      end
      object fldTIPOCOMPONENTE: TEdit
        Left = 135
        Top = 88
        Width = 381
        Height = 21
        Enabled = False
        TabOrder = 3
      end
      object fldLARGURACOMPONENTE: TEdit
        Left = 382
        Top = 61
        Width = 134
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        NumbersOnly = True
        TabOrder = 2
      end
      object fldALTURACOMPONENTE: TEdit
        Left = 135
        Top = 61
        Width = 134
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        NumbersOnly = True
        TabOrder = 1
      end
      object fldITENS: TEdit
        Left = 135
        Top = 115
        Width = 381
        Height = 21
        Enabled = False
        TabOrder = 4
      end
      object dbnDadosComp: TDBNavigator
        Left = 144
        Top = 160
        Width = 207
        Height = 25
        DataSource = dsDadosComp
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
        TabOrder = 5
        OnClick = dbnDadosCompClick
      end
    end
    object btnPreview: TButton
      Left = 600
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Preview Tela'
      TabOrder = 1
      OnClick = btnPreviewClick
    end
  end
  object dbgDadosComp: TDBGrid
    Left = 0
    Top = 0
    Width = 698
    Height = 253
    TabStop = False
    Align = alClient
    DataSource = dsDadosComp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'LABELCAPTION'
        Title.Caption = 'Label Caption'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOCOMPONENTE'
        Title.Caption = 'Tipo Componente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LARGURACOMPONENTE'
        Title.Caption = 'Largura Componente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ALTURACOMPONENTE'
        Title.Caption = 'Altura Componente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITENS'
        Title.Caption = 'Itens'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end>
  end
  object dsDadosComp: TDataSource
    DataSet = cdsDadosComp
    OnDataChange = dsDadosCompDataChange
    Left = 616
    Top = 208
  end
  object cdsDadosComp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 544
    Top = 208
    object cdsDadosCompLABELCAPTION: TStringField
      FieldName = 'LABELCAPTION'
      Size = 25
    end
    object cdsDadosCompTIPOCOMPONENTE: TStringField
      FieldName = 'TIPOCOMPONENTE'
      Size = 25
    end
    object cdsDadosCompLARGURACOMPONENTE: TIntegerField
      FieldName = 'LARGURACOMPONENTE'
    end
    object cdsDadosCompALTURACOMPONENTE: TIntegerField
      FieldName = 'ALTURACOMPONENTE'
    end
    object cdsDadosCompITENS: TStringField
      FieldName = 'ITENS'
      Size = 200
    end
  end
end
