function y=IsingEnergy(X,beta,h)
% calculating the current energy of the system 

    n=size(X,1);
    m=size(X,2);
    H=0;
    for i=1:n
        for j=1:m 
            % taking always the up and right neighboor, because of duplicate number
            % of edeges when counting
             up=mod(i,n)+1;
             right=mod(j,m)+1;
             StateEnergy=X(i,right)+X(up,j);
             H=H-beta*X(i,j)*StateEnergy-h*X(i,j);


        end
    end

    y=H;



end