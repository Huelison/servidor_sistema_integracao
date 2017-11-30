object frmVinculaFunc: TfrmVinculaFunc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '.:: Vincula'#231#227'o de motorista/Usu'#225'rio ::.'
  ClientHeight = 254
  ClientWidth = 447
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 11
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Label2: TLabel
    Left = 16
    Top = 38
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 16
    Top = 66
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object dbComboUsuario: TDBLookupComboBox
    Left = 57
    Top = 62
    Width = 376
    Height = 21
    DataField = 'UID'
    DataSource = dsMotorista
    KeyField = 'uid'
    ListField = 'email'
    ListSource = dsUsuario
    TabOrder = 0
    OnClick = dbComboUsuarioClick
  end
  object edtId: TDBEdit
    Left = 57
    Top = 8
    Width = 48
    Height = 21
    DataField = 'ID'
    DataSource = dsMotorista
    Enabled = False
    TabOrder = 1
  end
  object edtNome: TDBEdit
    Left = 57
    Top = 35
    Width = 376
    Height = 21
    DataField = 'NOME'
    DataSource = dsMotorista
    Enabled = False
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 121
    Width = 447
    Height = 133
    Align = alBottom
    DataSource = dsMotorista
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UID'
        Visible = True
      end>
  end
  object btnSalvar: TButton
    Left = 128
    Top = 90
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 217
    Top = 90
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
  object cdsDataSet: TClientDataSet
    PersistDataPacket.Data = {
      4C0000009619E0BD0100000018000000020000000000030000004C0005656D61
      696C010049000000010005574944544802000200640003756964010049000000
      01000557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 32
    object cdsDataSetemail: TStringField
      FieldName = 'email'
      Size = 100
    end
    object cdsDataSetuid: TStringField
      FieldName = 'uid'
      Size = 100
    end
  end
  object dsMotorista: TDataSource
    DataSet = dmPrincipal.qMotoristas
    OnStateChange = dsMotoristaStateChange
    Left = 384
    Top = 80
  end
  object dsUsuario: TDataSource
    DataSet = cdsDataSet
    Left = 320
    Top = 80
  end
end
