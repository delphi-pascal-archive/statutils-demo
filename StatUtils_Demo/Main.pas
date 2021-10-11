unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StatUtils, StdCtrls, Math, ExtCtrls, Menus, ImgList;

type
  TMainForm = class(TForm)
    InfoBox: TGroupBox;
    ListBox: TGroupBox;
    List: TListBox;
    ListOptionsBtn: TButton;
    QuitBtn: TButton;
    MinLbl: TLabel;
    MaxLbl: TLabel;
    MoyLbl: TLabel;
    MedLbl: TLabel;
    RangeLbl: TLabel;
    SigmaLbl: TLabel;
    FreqLbl: TLabel;
    Bevel1: TBevel;
    FloatingChk: TCheckBox;
    ListOptionsPopup: TPopupMenu;
    NewListBtn: TMenuItem;
    N1: TMenuItem;
    SortBtn: TMenuItem;
    AddBtn: TMenuItem;
    MulBtn: TMenuItem;
    DivBtn: TMenuItem;
    SubBtn: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure NewListBtnClick(Sender: TObject);
    procedure ListClick(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure ListOptionsBtnClick(Sender: TObject);
    procedure SortBtnClick(Sender: TObject);
    procedure AlgebricBtns(Sender: TObject);
    procedure ListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure UpdateListBox;
  end;

var
  MainForm: TMainForm;
  Data: array of Extended; // La série statistique

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject); // Création de la fiche
begin
 DoubleBuffered := True;
 InfoBox.DoubleBuffered := True;  // On évite les scintillements
 ListBox.DoubleBuffered := True;
 List.DoubleBuffered := True;
 randomize; // On va avoir besoin de nombres aléatoires pour l'exemple
 NewListBtnClick(self); // On commence en créant une nouvelle liste
end;

procedure TMainForm.NewListBtnClick(Sender: TObject); // Nouvelle liste
Var
 I, T: Integer;
 S: String;
begin
 if InputQuery('Parameters', 'Enter the size of the list:', S) then
  begin // On demande le nombre d'éléments
   T := StrToIntDef(S, 20); // Si erreur de format, 20 éléments
   if T > 10000 then T := 10000; // Maximum 10.000 (après, on risque des erreurs de débordement de pile)
  end
 else T := 20; // Si "Annuler", on prend 20 éléments
 SetLength(Data, T); // On redimensionne le tableau
 for I := 0 to Length(Data) - 1 do // Pour chaque élément du tableau
  begin
   Data[I] := (random(10000) + 1); // Valeur aléatoire
   if FloatingChk.Checked then Data[I] := Data[I] / 100;
   // Si on a les nombres flottants activés, on divise par 100 pour un nombre flottant aléatoire
  end;

 UpdateListBox; // On met à jour la liste

 MinLbl.Caption := Format('Minimum: %f', [RoundTo(StatUtils.Min(Data), -2)]);
 MaxLbl.Caption := Format('Maximum: %f', [RoundTo(StatUtils.Max(Data), -2)]);
 RangeLbl.Caption := Format('Scale: %f', [RoundTo(StatUtils.Range(Data), -2)]);
 MoyLbl.Caption := Format('Average: %f', [RoundTo(StatUtils.Medium(Data), -2)]);
 MedLbl.Caption := Format('Mediane: %f', [RoundTo(StatUtils.Median(Data), -2)]);
 SigmaLbl.Caption := Format('Sigma: %f', [RoundTo(StatUtils.Sigma(Data), -2)]);
 FreqLbl.Caption := 'Element frequency: [none]';
 // On affiche toutes les informations de la liste (fonctions dans StatUtils)
end;

procedure TMainForm.UpdateListBox; // Mise à jour de la liste
Var
 I: Integer;
begin
 List.Items.BeginUpdate; // On commence la mise à jour
 List.Items.Clear; // On vide la liste
 for I := 0 to Length(Data) - 1 do List.Items.Add(FloatToStr(RoundTo(Data[I], -2)));
 // Pour chaque élément, on ajoute le nombre
 List.Items.EndUpdate; // On termine la mise à jour
end;

procedure TMainForm.ListClick(Sender: TObject); // Clic sur un élément de la liste
Var
 F: Single;
begin
 F := RoundTo(StatUtils.Freq(Data, Data[List.ItemIndex]), -2); // On récupère la fréquence du nombre
 if F <> 0 then FreqLbl.Caption := Format('Element frequency: %f', [F])
  else FreqLbl.Caption := 'Element frequency (< 0.01)';
 // On affiche la fréquence de l'élément choisi dans la liste
end;

procedure TMainForm.QuitBtnClick(Sender: TObject); // Bouton quitter
begin
 Close; // On quitte
end;

procedure TMainForm.ListOptionsBtnClick(Sender: TObject); // Clic sur bouton Options
Var
 P: TPoint;
begin
 GetCursorPos(P); // On récupère la position de la souris
 ListOptionsPopup.Popup(P.X, P.Y); // On faire surgir le menu à cet emplacement
end;

procedure TMainForm.SortBtnClick(Sender: TObject); // Clic sur "Trier"
begin
 Sort(Data); // On trie la liste (StatUtils)
 UpdateListBox; // On affiche la liste
end;

procedure TMainForm.AlgebricBtns(Sender: TObject); // Clic sur un des 4 boutons "ajouter", "multiplier"
Var
 S: String;
 T: Integer;
begin
 if InputQuery('Valeur de x', 'Saisissez la valeur de x :', S) then
  begin // On demande la valeur à ajouter/soustraire/multiplier/diviser
   try
    T := StrToInt(S); // On récupère la valeur
   except
    raise Exception.Create('Veuillez rentrer un nombre valide.');
    // Si pas un nombre, on envoie un message
   end;
   case TMenuItem(Sender).Tag of // Selon le tag du menu (regardez le popupmenu)
    1: Add(Data, T); // 1 : on ajoute
    2: Add(Data, -T); // 2 : on retranche
    3: Mul(Data, T); // 3 : on multiplie
    4: Mul(Data, 1/T); // 4 : on divise (multiplie par l'inverse)
   end;
  end;
 UpdateListBox; // On met à jour
end;

procedure TMainForm.ListDrawItem(Control: TWinControl; Index: Integer; // Dessin d'un élément dans la liste
  Rect: TRect; State: TOwnerDrawState);
begin
 case Odd(Index) of // Selon la parité de l'élément en cours de dessin
  False: List.Canvas.Brush.Color := rgb(200, 200, 200); // Pair : couleur grisâtre
  True: List.Canvas.Brush.Color := rgb(220, 220, 220); // Impair : couleur plus blanche
 end;
 List.Canvas.Rectangle(Rect); // On applique la couleur
 List.Canvas.TextRect(Rect, Rect.TopLeft.X + 2, Rect.TopLeft.Y + 1, List.Items.Strings[Index]);
 // On écrit la valeur de l'élément en cours
end;

end.
