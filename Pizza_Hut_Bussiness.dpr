program Pizza_Hut_Bussiness;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_Splash in 'U_Splash.pas' {FrSplash},
  U_Menu in 'U_Menu.pas' {FrMenu},
  U_Home in 'U_Home.pas' {FrHome},
  U_Cardapio in 'U_Cardapio.pas' {FrCardapio},
  U_Module in 'U_Module.pas' {module: TDataModule},
  U_NovoProduto in 'U_NovoProduto.pas' {FNovoProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrSplash, FrSplash);
  Application.CreateForm(Tmodule, module);
  Application.CreateForm(TFrHome, FrHome);
  Application.Run;
end.
