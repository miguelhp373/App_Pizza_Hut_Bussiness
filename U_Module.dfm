object module: Tmodule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 421
  Width = 374
  object Q_ConsultaCardapio: TFDQuery
    Active = True
    Connection = Connection
    SQL.Strings = (
      'SELECT titulo, descricao, preco, cod_imagem FROM TB_Cardapio')
    Left = 144
    Top = 88
  end
  object db_driver: TFDPhysSQLiteDriverLink
    Left = 40
    Top = 88
  end
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\migue\OneDrive\Documentos\Projetos\Mobile\App_' +
        'Pizza_Hut_Bussiness\DB\DataBase.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 168
  end
  object Q_CadastroProduto: TFDQuery
    Connection = Connection
    Left = 152
    Top = 168
  end
end
