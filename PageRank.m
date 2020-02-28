% Vlad Andrei-Alexandru, 311CB

function [R1 R2] = PageRank(nume, d, eps)
  % Calculeaza indicii PageRank pentru cele 3 cerinte
  % Scrie fgraful de iesire nume.out

fgraf = fopen(nume, 'r'); 
cardWeb = fscanf(fgraf, '%d', 1); 

nume_out = strcat(nume, '.out'); 
fgraf_out = fopen(nume_out, 'w'); 
fprintf(fgraf_out, '%d \n', cardWeb);
 
%Calculeaza vectorul PageRank cu algoritmul Iterative
R1 = Iterative(nume, d, eps);
fprintf(fgraf_out, '%7.6f \n', R1); 
fprintf(fgraf_out, '\n'); 

%Calculeaza vectorul PageRank cu algoritmul Algebraic
R2 = Algebraic(nume, d);
fprintf(fgraf_out, '%7.6f \n', R2); 
fprintf(fgraf_out, '\n'); 
 
%Skip pana la val1 si val2 (ultimele 2 linii din fisierul de input)
for i = 1:cardWeb+1
  fgets(fgraf);
end

val1 = fscanf(fgraf, '%f', 1);
val2 = fscanf(fgraf, '%f', 1); 

n = cardWeb; 
index = [1:n];

%Sortare indici
for i = 1:n-1
  for j = i+1:n
    if(R2(index(i)) <= R2(index(j)))
      aux = index(i); 
      index(i) = index(j);
      index(j) = aux;
    end
  end 
end
   
%Afisare
for i = 1:n
  fprintf(fgraf_out, '%d ', i);
  fprintf(fgraf_out, '%d ', index(i));
  %Copiez PageRankul paginii curente
  newPR = R2(index(i));
  
  %Aplic functia data si calculez coeficientii a si b
  if(newPR < val1)
    rez = 0;
  else
    if(newPR > val2) 
      rez = 1;
    else
      a = 1/(val2-val1);
      b = -a * val1;		      
      rez = a*newPR + b;
    end
  end
    fprintf(fgraf_out, '%7.6f \n', rez );
end

fclose(fgraf);
fclose(fgraf_out);
end