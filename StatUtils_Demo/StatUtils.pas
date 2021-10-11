// Librairie de fonctions statistiques. Definitions � la fin de l'unit�.

unit StatUtils;

interface

procedure Sort(var Values: array of Extended); // Tri d'une liste
function Empty(Values: array of Extended): Boolean; // V�rifie si une liste est vide
function Min(Values: array of Extended): Extended; // Minimum d'une liste
function Max(Values: array of Extended): Extended; // Maximum d'une liste
function Sigma(Values: array of Extended): Extended; // Sigma (somme) d'une liste
function Medium(Values: array of Extended): Extended; // Moyenne d'une liste
function Median(Values: array of Extended): Extended; // Mediane d'une liste
function Freq(Values: array of Extended; Value: Extended): Extended; // Fr�quence d'un �l�ment dans une liste
function Range(Values: array of Extended): Extended; // Etendue d'une liste
procedure Add(var Values: array of Extended; Value: Extended); // Ajoute Value � chaque �l�ment de la liste
procedure Mul(var Values: array of Extended; Value: Extended); // Multiplie Value � chaque �l�ment de la liste

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

{ D�finitions et explications :

Sort : effectue un Quicksort sur la liste pass�e en param�tre var.

Empty : renvoie True si la liste pass�e est vide, False sinon.

Min : renvoie l'�l�ment le plus petit de la liste. Effectue un simple tri de la
liste, et prend le premier �l�ment, qui est th�oriquement le plus petit apr�s le
tri.

Max : m�me principe que pour Min, mais en prenant le dernier �l�ment de la liste
apr�s le tri.

Sigma : renvoie la somme des �l�ments de la liste pass�e en param�tre. S'appelle
sigma car il effectue une op�ration sigma (boucle) pour calculer la somme.

Medium : renvoie la moyenne des �l�ments de la liste (Sigma / Nombre d'�l�ments).

Median : renvoie la m�diane de la liste :
 - Si le nombre d'�l�ments de la liste (N) est impair, alors on prend simplement
  l'�l�ment du milieu de la liste d'index : (D�but de liste + Fin de liste / 2).
 - Si N est pair, on fait la moyenne des 2 �l�ments du milieu.

Freq : renvoie la fr�quence de l'�l�ment pass� en param�tre Value dans la liste
pass�e en param�tre Values. La fr�quence est comprise entre 0 et 1, et est
calcul�e de la fa�on suivante : (Nombre d'�l�ments Value / Nombre d'�l�ments).
De plus, la somme des fr�quences de chaque �l�ment de la liste est �gale � 1.

Range : renvoie l'�tendue de la liste : |plus petit �l�ment - plus grand �l�ment|.

Add : ajoute � chaque �l�ment de la liste un nombre r�el quelconque. Pour
soustraire, il suffit d'ajouter l'oppos� du nombre � soustraire.

Mul : multiplie chaque �l�ment de la liste par un nombre r�el quelconque. Pour
diviser, il suffit de multiplier l'inverse du nombre � diviser.

}
