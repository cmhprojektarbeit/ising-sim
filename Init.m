% define start spins
function A=Init(n,p)

    shiftlist = randperm(n*n);
    
    A = cat(2,ones(1,round(n*n*p)),ones(1,round(n*n*(1-p)))-2);
    A = A(shiftlist);
    A = reshape(A,[n,n]);
%     A = 2*(rand(n)>p*ones(n))-1;

end