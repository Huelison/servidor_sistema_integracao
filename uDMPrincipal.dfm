object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 307
  Width = 393
  object fdConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Huelison\faculdade\TCC\projeto\dados\ADMINISTR' +
        'ADOR.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = fdTransacao
    Left = 32
    Top = 8
  end
  object fdTransacao: TFDTransaction
    Connection = fdConexao
    Left = 40
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 56
  end
  object qClientes: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'select  id,nome,fone,endereco from clifor'
      'where leite_rota is not null'
      'order by id')
    Left = 124
    Top = 16
    object qClientesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object qClientesFONE: TStringField
      FieldName = 'FONE'
      Origin = 'FONE'
      Size = 15
    end
    object qClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Required = True
      Size = 40
    end
  end
  object qRotas: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'select id, descricao, transportador from rotas_leite rl')
    Left = 124
    Top = 72
    object qRotasID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qRotasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 40
    end
    object qRotasTRANSPORTADOR: TStringField
      FieldName = 'TRANSPORTADOR'
      Origin = 'TRANSPORTADOR'
      Required = True
      Size = 7
    end
  end
  object qRotasClientes: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'select id from clifor where leite_rota =:pRota')
    Left = 124
    Top = 122
    ParamData = <
      item
        Name = 'PROTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qRotasClientesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object qColetas: TFDQuery
    ObjectView = False
    Connection = fdConexao
    Transaction = fdTransacao
    SQL.Strings = (
      'select * from agl_tiket_entrada')
    Left = 180
    Top = 48
    object qColetasCLIFOR: TIntegerField
      FieldName = 'CLIFOR'
      Origin = 'CLIFOR'
      Required = True
    end
    object qColetasPRODUTO: TIntegerField
      FieldName = 'PRODUTO'
      Origin = 'PRODUTO'
      Required = True
    end
    object qColetasDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
      Required = True
    end
    object qColetasTIKET: TIntegerField
      FieldName = 'TIKET'
      Origin = 'TIKET'
    end
    object qColetasQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Required = True
    end
    object qColetasPER_DESCONTO: TCurrencyField
      FieldName = 'PER_DESCONTO'
      Origin = 'PER_DESCONTO'
    end
    object qColetasALIZAROL: TStringField
      FieldName = 'ALIZAROL'
      Origin = 'ALIZAROL'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qColetasHORA: TTimeField
      FieldName = 'HORA'
      Origin = 'HORA'
    end
    object qColetasTEMPERATURA: TBCDField
      FieldName = 'TEMPERATURA'
      Origin = 'TEMPERATURA'
      Precision = 18
      Size = 2
    end
    object qColetasCAMINHAO: TIntegerField
      FieldName = 'CAMINHAO'
      Origin = 'CAMINHAO'
    end
    object qColetasROTA: TIntegerField
      FieldName = 'ROTA'
      Origin = 'ROTA'
    end
    object qColetasID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object qMotoristas: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'select  * from motoristas'
      'order by id')
    Left = 132
    Top = 184
    object qMotoristasID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qMotoristasNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object qMotoristasCAMINHAO: TStringField
      FieldName = 'CAMINHAO'
      Origin = 'CAMINHAO'
      Size = 7
    end
    object qMotoristasEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 250
    end
    object qMotoristasUID: TStringField
      FieldName = 'UID'
      Origin = 'UID'
      Size = 250
    end
    object qMotoristasCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Required = True
      Size = 18
    end
  end
  object qCaminhoes: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      ''
      'select id, placa from transportadores')
    Left = 124
    Top = 240
    object qCaminhoesID: TStringField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 7
    end
    object qCaminhoesPLACA: TStringField
      FieldName = 'PLACA'
      Origin = 'PLACA'
      Size = 7
    end
  end
end
