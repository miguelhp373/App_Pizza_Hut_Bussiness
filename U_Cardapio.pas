unit U_Cardapio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, System.ImageList,
  FMX.ImgList, FMX.TabControl;

type
  TFrCardapio = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    Rectangle2: TRectangle;
    Button1: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Consulta_Cardapio_ListView;
  end;

var
  FrCardapio: TFrCardapio;

implementation

{$R *.fmx}

uses U_Module, U_NovoProduto;

procedure TFrCardapio.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TFNovoProduto,FNovoProduto);
  FNovoProduto.Show;
end;

procedure TFrCardapio.Consulta_Cardapio_ListView;
begin
    with module.Q_ConsultaCardapio do
      begin
          close;
          SQL.Clear;
          sql.Add('SELECT titulo, descricao, preco, cod_imagem FROM TB_Cardapio');
          Active:= true;

          Open;
      end;
end;

procedure TFrCardapio.FormCreate(Sender: TObject);
begin
  BorderIcons := [];
  Active:= false;
  Consulta_Cardapio_ListView; // executa ao abrir a tela a consulta
end;

procedure TFrCardapio.ListView1Change(Sender: TObject);
begin
  //adicionar as variaveis o valor que vai ser passado na segunda aba
  TabControl1.Next()
end;

procedure TFrCardapio.SpeedButton1Click(Sender: TObject);
begin
  close;
end;

procedure TFrCardapio.SpeedButton2Click(Sender: TObject);
begin
  Active:= false;
  Consulta_Cardapio_ListView;//atualiza listview
end;

end.
