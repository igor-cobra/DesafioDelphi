object frmGerSql0: TfrmGerSql0
  Left = 0
  Top = 0
  Caption = 'frmGerSql0'
  ClientHeight = 557
  ClientWidth = 884
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
    Top = 368
    Width = 884
    Height = 189
    Align = alBottom
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    object lblComando: TLabel
      Left = 1
      Top = 1
      Width = 882
      Height = 13
      Align = alTop
      Caption = 'Comando Gerado'
      ExplicitWidth = 83
    end
    object mmoComando: TMemo
      Left = 1
      Top = 14
      Width = 882
      Height = 174
      Align = alClient
      CharCase = ecUpperCase
      TabOrder = 0
    end
  end
  object pnlBody: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 368
    Align = alClient
    TabOrder = 0
    object pnlBoddyLeft: TPanel
      Left = 1
      Top = 1
      Width = 192
      Height = 366
      Align = alLeft
      TabOrder = 0
      object lblTabelas: TLabel
        Left = 1
        Top = 1
        Width = 190
        Height = 13
        Align = alTop
        Caption = 'Tabelas'
        ExplicitWidth = 37
      end
      object lblColunas: TLabel
        Left = 1
        Top = 35
        Width = 190
        Height = 13
        Align = alTop
        Caption = 'Colunas'
        ExplicitWidth = 38
      end
      object fldTabela: TEdit
        Left = 1
        Top = 14
        Width = 190
        Height = 21
        Align = alTop
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object mmoCampos: TMemo
        Left = 1
        Top = 48
        Width = 190
        Height = 317
        Align = alClient
        CharCase = ecUpperCase
        TabOrder = 1
      end
    end
    object pnlBodyRight: TPanel
      Left = 691
      Top = 1
      Width = 192
      Height = 366
      Align = alRight
      TabOrder = 2
      object btnGerarConsulta: TButton
        Left = 64
        Top = 64
        Width = 75
        Height = 25
        Caption = 'Gerar SQL'
        TabOrder = 0
        OnClick = btnGerarConsultaClick
      end
      object btnGerarInsert: TButton
        Left = 64
        Top = 95
        Width = 75
        Height = 25
        Caption = 'Gerar INSERT'
        TabOrder = 1
        OnClick = btnGerarInsertClick
      end
      object btnGerarUpdate: TButton
        Left = 64
        Top = 126
        Width = 75
        Height = 25
        Caption = 'Gerar UPDATE'
        TabOrder = 2
        OnClick = btnGerarUpdateClick
      end
      object btnGerarDelete: TButton
        Left = 64
        Top = 157
        Width = 75
        Height = 25
        Caption = 'Gerar DELETE'
        TabOrder = 3
        OnClick = btnGerarDeleteClick
      end
    end
    object pnlBodyBody: TPanel
      Left = 193
      Top = 1
      Width = 498
      Height = 366
      Align = alClient
      TabOrder = 1
      object lblCondicoes: TLabel
        Left = 1
        Top = 1
        Width = 496
        Height = 13
        Align = alTop
        Caption = 'Condi'#231#245'es'
        ExplicitWidth = 49
      end
      object mmoCondicoes: TMemo
        Left = 1
        Top = 14
        Width = 496
        Height = 351
        Align = alClient
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
  end
end
