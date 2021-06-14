unit U_Splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrSplash = class(TForm)
    logo_center: TImage;
    Timer1: TTimer;
    Layout1: TLayout;
    Label1: TLabel;
    Layout2: TLayout;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrSplash: TFrSplash;

implementation

{$R *.fmx}

uses U_Home;

procedure TFrSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FrSplash := nil;
end;

procedure TFrSplash.FormCreate(Sender: TObject);
begin
    Timer1.Interval := 4000;
    Timer1.Enabled := true;
    logo_center.Opacity := 0;

    logo_center.Align := TAlignLayout.None;
    logo_center.AnimateFloat('Opacity', 1, 0.4);
end;

procedure TFrSplash.Timer1Timer(Sender: TObject);
begin
    Timer1.Enabled := false;

    if NOT Assigned(FrHome) then
    Application.CreateForm(TFrHome, FrHome);

    Application.MainForm := FrHome;
    FrHome.Show;

    frsplash.Close;
end;

end.
