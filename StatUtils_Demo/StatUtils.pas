// Librairie de fonctions statistiques. Definitions à la fin de l'unité.

unit StatUtils;

interface

procedure Sort(var Values: array of Extended); // Tri d'une liste
function Empty(Values: array of Extended): Boolean; // Vérifie si une liste est vide
function Min(Values: array of Extended): Extended; // Minimum d'une liste
function Max(Values: array of Extended): Extended; // Maximum d'une liste
function Sigma(Values: array of Extended): Extended; // Sigma (somme) d'une liste
function Medium(Values: array of Extended): Extended; // Moyenne d'une liste
function Median(Values: array of Extended): Extended; // Mediane d'une liste
function Freq(Values: array of Extended; Value: Extended): Extended; // Fréquence d'un élément dans une liste
function Range(Values: array of Extended): Extended; // Etendue d'une liste
procedure Add(var Values: array of Extended; Value: Extended); // Ajoute Value à chaque élément de la liste
procedure Mul(var Values: array of Extended; Value: Extended); // Multiplie Value à chaque élément de la liste

implementation

procedure Sort(Var Values: array of Extended);
var
 T: Extended;

 function Part(M, N: Int64):Int64;
 var
  I, J: Int64;
  V: Extended;
 Begin
  V := Values[M];
  I := M - 1;
  J := N + 1;
  while True do
   begin
    repeat Dec(J) until Values[J] <= V;
    repeat Inc(I) until Values[I] >= V;
    if (I < J)
     then
      begin
       T := Values[I];
       Values[I] := Values[J];
       Values[J] := T;
      end
     else
      begin
       Result := J;
       Exit;
      end;
    end;
 end;

 procedure DoSort(M, N: Int64);
 var
  P: Int64;
 begin
  if M < N then
   begin
    P := Part(M, N);
    DoSort(M, P);
    DoSort(P + 1, N);
   end;
 end;
 
begin
  if Empty(Values) then Exit;
  DoSort(Low(Values),High(Values));
end;

function Empty(Values: array of Extended): Boolean;
begin
 Result := (Length(Values) = 0);
end;

function Min(Values: array of Extended): Extended;
begin
 Sort(Values);
 Result := Values[0];
end;

function Max(Values: array of Extended): Extended;
begin
 Sort(Values);
 Result := Values[Length(Values) - 1];
end;

function Sigma(Values: array of Extended): Extended;
Var
 I: Cardinal;
begin
 Result := 0;
 if Empty(Values) then Exit;
 for I := 0 to Length(Values) - 1 do Result := Result + Values[I];
end;

function Medium(Values: array of Extended): Extended;
begin
 Result := 0;
 if Empty(Values) then Exit;
 Result := Sigma(Values) / Length(Values);
end;

function Median(Values: array of Extended): Extended;
begin
 Result := 0;
 if Empty(Values) then Exit;
 Sort(Values);
 case Odd(Length(Values)) of
  False: Result := (Values[(Low(Values) + High(Values)) div 2]  + Values[((Low(Values) + High(Values)) div 2) + 1]) / 2;
  True: Result := Values[(Low(Values) + High(Values)) div 2];
 end;
end;

function Freq(Values: array of Extended; Value: Extended): Extended;
Var
 I: Cardinal;
 F: Int64;
begin
 F := 0;
 Result := 0;
 if Empty(Values) then Exit;
 for I := 0 to Length(Values) - 1 do
  if Values[I] = Value then Inc(F);
 Result := F / Length(Values);
end;

function Range(Values: array of Extended): Extended;
begin
 Sort(Values);
 Result := Abs(Values[0] - Values[Length(Values) - 1]);
end;

procedure Add(var Values: array of Extended; Value: Extended);
Var
 I: Cardinal;
begin
 for I := 0 to Length(Values) - 1 do
  Values[I] := Values[I] + Value;
end;

procedure Mul(var Values: array of Extended; Value: Extended);
Var
 I: Cardinal;
begin
 for I := 0 to Length(Values) - 1 do
  Values[I] := Values[I] * Value;
end;

end.

{ Définitions et explications :

Sort : effectue un Quicksort sur la liste passée en paramètre var.

Empty : renvoie True si la liste passée est vide, False sinon.

Min : renvoie l'élément le plus petit de la liste. Effectue un simple tri de la
liste, et prend le premier élément, qui est théoriquement le plus petit après le
tri.

Max : même principe que pour Min, mais en prenant le dernier élément de la liste
après le tri.

Sigma : renvoie la somme des éléments de la liste passée en paramètre. S'appelle
sigma car il effectue une opération sigma (boucle) pour calculer la somme.

Medium : renvoie la moyenne des éléments de la liste (Sigma / Nombre d'éléments).

Median : renvoie la médiane de la liste :
 - Si le nombre d'éléments de la liste (N) est impair, alors on prend simplement
  l'élément du milieu de la liste d'index : (Début de liste + Fin de liste / 2).
 - Si N est pair, on fait la moyenne des 2 éléments du milieu.

Freq : renvoie la fréquence de l'élément passé en paramètre Value dans la liste
passée en paramètre Values. La fréquence est comprise entre 0 et 1, et est
calculée de la façon suivante : (Nombre d'éléments Value / Nombre d'éléments).
De plus, la somme des fréquences de chaque élément de la liste est égale à 1.

Range : renvoie l'étendue de la liste : |plus petit élément - plus grand élément|.

Add : ajoute à chaque élément de la liste un nombre réel quelconque. Pour
soustraire, il suffit d'ajouter l'opposé du nombre à soustraire.

Mul : multiplie chaque élément de la liste par un nombre réel quelconque. Pour
diviser, il suffit de multiplier l'inverse du nombre à diviser.

}
