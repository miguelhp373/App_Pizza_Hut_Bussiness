unit U_Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrHome = class(TForm)
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Button2: TButton;
    layout10: TLayout;
    Rectangle3: TRectangle;
    Button3: TButton;
    Layout5: TLayout;
    Rectangle4: TRectangle;
    Button4: TButton;
    Layout6: TLayout;
    Layout1: TLayout;
    Layout7: TLayout;
    Rectangle5: TRectangle;
    Button5: TButton;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout4: TLayout;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrHome: TFrHome;

implementation

{$R *.fmx}

uses U_menu, U_Cardapio, U_Pedidos;

procedure TFrHome.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFrHome.Button2Click(Sender: TObject);
begin
  Application.CreateForm(TFrMenu,FrMenu);
  FrMenu.Show;
end;

procedure TFrHome.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TFrHome.Button4Click(Sender: TObject);
begin
  Application.CreateForm(TFrCardapio,FrCardapio);
  FrCardapio.Show;
end;

procedure TFrHome.Button5Click(Sender: TObject);
begin
  Application.CreateForm(TFrPedidos,FrPedidos);
  FrPedidos.show;
end;

procedure TFrHome.FormCreate(Sender: TObject);
begin
  BorderIcons := [];
end;

end.
