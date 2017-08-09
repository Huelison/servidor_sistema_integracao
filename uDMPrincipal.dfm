object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 150
  Width = 215
  object fdConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Huelison\faculdade\TCC\projeto\dados\ADMINISTR' +
        'ADOR.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object fdTransacao: TFDTransaction
    Connection = fdConexao
    Left = 120
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 72
    Top = 80
  end
end
