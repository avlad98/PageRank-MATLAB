% Vlad Andrei-Alexandru, 311CB

function [Q R] = Gram_Schmidt(A)
%Descompune matricea A in Q*R folosind algoritmul Gram_Schmidt
[n m] = size(A);
Q = zeros(n);
R = zeros(n); 

%Calculeaza primul R folosind norma
R(1,1) = norm( A(1:n,1) );
%Calculeaza Q1
Q(1:n,1) = A(1:n,1)/R(1,1);

for i=2:n 
  suma=0;
  
  for k=1:i-1 
	  R(k,i)=(Q(1:n,k))'*A(1:n,i);
  	suma=suma+Q(1:n,k)*R(k,i); 
  end
  
  R(i,i)=norm(A(1:n,i)-suma);
  Q(1:n,i)=(A(1:n,i)-suma)/R(i,i);
end
 
end