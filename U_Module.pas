unit U_Module;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, FMX.ImgList,
  System.IOUtils;

type
  Tmodule = class(TDataModule)
    Q_ConsultaCardapio: TFDQuery;
    db_driver: TFDPhysSQLiteDriverLink;
    Connection: TFDConnection;
    Q_CadastroProduto: TFDQuery;
    ImageList1: TImageList;
    ConsultaPreco: TFDQuery;
    AtualizaProduto: TFDQuery;
    DeletaItem: TFDQuery;
    CarrinhoOperacoes: TFDQuery;
    cadastra_pedido: TFDQuery;
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  module: Tmodule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tmodule.ConnectionBeforeConnect(Sender: TObject);
begin
  //Connection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'DataBase.db');
end;

end.
