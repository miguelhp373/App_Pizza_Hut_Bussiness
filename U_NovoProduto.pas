unit U_NovoProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Edit, FMX.ListBox;

type
  TFNovoProduto = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Label2: TLabel;
    Layout4: TLayout;
    nprod: TEdit;
    Layout5: TLayout;
    Layout6: TLayout;
    Label3: TLabel;
    dprod: TEdit;
    Layout7: TLayout;
    Layout8: TLayout;
    Label4: TLabel;
    Layout9: TLayout;
    Rectangle3: TRectangle;
    SpeedButton2: TSpeedButton;
    ComboBox1: TComboBox;
    Layout10: TLayout;
    Layout11: TLayout;
    Label5: TLabel;
    ppreco: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CadastraProduto;
  end;

var
  FNovoProduto: TFNovoProduto;

implementation

{$R *.fmx}

uses U_Module, U_Cardapio;

procedure TFNovoProduto.CadastraProduto;
begin
  try
    Active := false;
    with module.Q_CadastroProduto do
      begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO TB_Cardapio(titulo, descricao, preco, cod_imagem)VALUES(:Titulo_Prod,:Descricao_Prod, :Preco_prod, :Imagem_cod)');
        ParamByName('Titulo_Prod').AsString := nprod.Text ;
        ParamByName('Descricao_Prod').AsString := dprod.Text;
        ParamByName('Preco_prod').AsFloat :=  StrToFloat(ppreco.Text);
        ParamByName('Imagem_cod').AsInteger := strtoint(ComboBox1.Selected.Text);

        ExecSQL;
      end;

   SpeedButton1Click(SpeedButton1);
  except
    ShowMessage('Erro Ao Cadastrar, Tente Novamente.');
  end;

end;

procedure TFNovoProduto.FormCreate(Sender: TObject);
begin
BorderIcons := [];
end;

procedure TFNovoProduto.SpeedButton1Click(Sender: TObject);
begin
  close;
  Frcardapio.Consulta_Cardapio_ListView;
end;

procedure TFNovoProduto.SpeedButton2Click(Sender: TObject);
begin
    CadastraProduto;
end;

end.
