function y=IsingMagn(X)
% calculating mean magnetization

[n,m]=size(X);
M=sum(sum(X))/(n*m); % summing all the spins and diving through the size of the lattice 
y=M;

end