program StatUtilsExample;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  StatUtils in 'StatUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Exemple StatUtils';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
