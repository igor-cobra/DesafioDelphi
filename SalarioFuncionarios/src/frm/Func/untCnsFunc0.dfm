object FrmCnsFunc0: TFrmCnsFunc0
  Left = 0
  Top = 0
  Caption = 'FrmCnsFunc0'
  ClientHeight = 391
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 272
    Width = 622
    Height = 119
    Align = alBottom
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 1
    object lblIdFuncionario: TLabel
      Left = 136
      Top = 15
      Width = 72
      Height = 13
      Caption = 'Id. Funcion'#225'rio'
    end
    object lblExemplo: TLabel
      Left = 214
      Top = 34
      Width = 61
      Height = 13
      Caption = 'EX: 1;3;4;10'
    end
    object lblResultado: TLabel
      Left = 433
      Top = 88
      Width = 48
      Height = 13
      Caption = 'Resultado'
    end
    object rgFiltrarFunc: TRadioGroup
      Left = 16
      Top = 6
      Width = 113
      Height = 51
      Caption = 'Filtrar Funcion'#225'rios'
      ItemIndex = 0
      Items.Strings = (
        'N'#227'o'
        'Sim')
      TabOrder = 0
      OnClick = rgFiltrarFuncClick
    end
    object fldListaFuncionario: TEdit
      Left = 214
      Top = 15
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object rgTipoCalculo: TRadioGroup
      Left = 16
      Top = 63
      Width = 113
      Height = 51
      Caption = 'Tipo de C'#225'lculo'
      ItemIndex = 0
      Items.Strings = (
        'Somar'
        'M'#233'dia')
      TabOrder = 1
    end
    object fldResultado: TEdit
      Left = 487
      Top = 88
      Width = 121
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 4
    end
    object btnCalcular: TButton
      Left = 260
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Calcular'
      TabOrder = 3
      OnClick = btnCalcularClick
    end
  end
  object dbgFuncionario: TDBGrid
    Left = 0
    Top = 0
    Width = 622
    Height = 272
    Align = alClient
    DataSource = dsFuncionario
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = dbgFuncionarioDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_FUNCIONARIO'
        Title.Alignment = taRightJustify
        Title.Caption = 'C'#243'd.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NM_FUNCIONARIO'
        Title.Caption = 'Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 450
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_SALARIO'
        Title.Alignment = taRightJustify
        Title.Caption = 'Sal'#225'rio'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object cdsFuncionario: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 504
    Top = 248
    object cdsFuncionarioID_FUNCIONARIO: TIntegerField
      FieldName = 'ID_FUNCIONARIO'
    end
    object cdsFuncionarioNM_FUNCIONARIO: TStringField
      FieldName = 'NM_FUNCIONARIO'
      Size = 100
    end
    object cdsFuncionarioVL_SALARIO: TFloatField
      FieldName = 'VL_SALARIO'
      DisplayFormat = '#,##0.00'
    end
  end
  object dsFuncionario: TDataSource
    DataSet = cdsFuncionario
    Left = 576
    Top = 248
  end
end
