% Vlad Andrei-Alexandru, 311CB

function INV = Inversa(A)
%Descompune matricea A in Q*R folosind algoritmul Gram_Schmidt
[Q R] = Gram_Schmidt(A);

Q = Q';
[n m] = size(R); 
INV = zeros(n, n); 

for i=1:n 
	%Rezolva SST
  INV(1:n,i) = SST( R, Q(1:n,i));
end

end