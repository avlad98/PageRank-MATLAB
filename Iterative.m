% Vlad Andrei-Alexandru, 311CB

function R = Iterative(nume, d, eps)
  % Functia care calculeaza matricea R folosind algoritmul iterativ.
  % Intrari:
  % -> nume: numele fisierului din care se citeste;
  % -> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
  % -> eps: eroarea care apare in algoritm.
  % Iesiri:
  % -> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

fgraf = fopen(nume, 'r'); 
cardWeb = fscanf(fgraf, '%d', 1);

%Initializare matrici cu O(nr_pag_web)
A = zeros(cardWeb);
K = zeros(cardWeb);

for i = 1:cardWeb
  %Citeste nr de pagini web din fisier
  ord = fscanf(fgraf, '%d', 1);
  %Citeste numarul de linkuri catre alte pagino
  n = fscanf(fgraf, '%d', 1);
  %Citeste vectorul de noduri
  V = fscanf(fgraf, '%d', n);
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

 %Initializare Rant (R(0))
 Rant(1:cardWeb,1) = 1/cardWeb;

 %Initializare Rurm cu zerouri
 Rurm = zeros(cardWeb,1);

 %Vector coloana 1
 vect_col_1 = ones(cardWeb,1);

  while(eps <= norm(Rant - Rurm))
   Rurm = Rant;
   Rant = d*M*Rant + (vect_col_1/cardWeb)*(1-d);   
  end
 
 R = Rant;

fclose(fgraf);
end 