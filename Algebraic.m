% Vlad Andrei-Alexandru, 311CB

function R = Algebraic (nume, d) 
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

fgraf = fopen(nume, 'r');
cardWeb = fscanf(fgraf, '%d', 1);

%Initializare matrici cu O(nr_pag_web)
A = zeros(cardWeb);
K = zeros(cardWeb);

for i = 1:cardWeb
  %Citeste nr de pagini web din fisier
  ord = fscanf(fgraf,'%d',1);
  %Citeste numarul de linkuri catre alte pagino
  n = fscanf(fgraf,'%d',1);
  %Citeste vectorul de noduri
  V = fscanf(fgraf,'%d',n);
  %Elimin paginile care se repeta
  V = unique(V);
  %Caut indexul paginii curente in vectorul de pagini
  index = find(ord == V);
  %Elimin pagina curenta din vector 
  V(index) = [];
  %Completare matrice K
  K(ord,ord) = numel(V);
  %Si matrice de adiacenta
  A(ord,V) = 1;  
end 
 
%Calculez matricea M cu ajutorul algoritmului Gram-Schmidt
M = (Inversa(K) * A)';
%Matricea identitate
I = eye(cardWeb);
%Vector coloana 1
vect_col_1 = ones(cardWeb,1);

%Calculez R(t) folosind inversa
Rt = Inversa(I-d*M);
R = (1-d)*Rt*vect_col_1/cardWeb;

fclose(fgraf);
end