function [y]=IsingSim(X,h,beta,bound)
% X - array of length n times n 
% h - magnetization parameter

% bound -conditions on the boundary 
%  1 - toroidal (periodic) boundary
%  2 - all spins +1 at the boundary
%  3 - empty boundary

n=size(X,1);
m=size(X,2); % the length of the lattice

if bound==1 
    % pick the vertex at random 
    i=floor(rand(1)*n + 1);
    j=floor(rand(1)*m + 1);
    % remember the spin for phase bounddary
%     spinold=X(i,j);
    % chosing the neighbours for the vertex according to the boundary
    % conditions
    up=mod(i,n)+1; down=mod(i+n-2,n)+1;
    right=mod(j,m)+1; left=mod(j+m-2,m)+1;
    % calculating the probability
    S=X(up,j)+X(down,j)+X(i,right)+X(i,left);
    
    
    % probability to move in +1 at the current vertex
    p=exp(beta*S + h)/(exp(beta*S + h)+exp(-beta*S - h));
    
    if rand(1)<p
        X(i,j)=1;
    else
        X(i,j)=-1;
    end
%     spinnew=X(i,j);
    
    % calculate the phase boundary change
%     if spinold*spinnew==-1
%     
%         switch s
%             case 4
%                 if spinnew==-1
%                     ph=ph+4
%                 end
%                 if spinnew==+1
%                     ph=ph-4;
%                 end
%             case 2
%             case 0
%             case -2
%             case -4
%         otherwise
%             disp('fatal error')
%         end
%     
%     end
% if spinold*spinnew==-1
%     ph = ph - S*spinnew;
% end

end

% at the boundary all spins +1 
if bound==2
    Xnew=-1*ones(n+2,m+2);
    % nesting array into a configuration with +1 boundary
    Xnew(2:end-1,2:end-1)=X;
    % picking the vertex at random
    i=floor(rand(1)*n+1) +1;
    j=floor(rand(1)*m+1) +1;
%     spinold=Xnew(i,j);

    % chosing the neighbours for the vertex according to the boundary
    % conditions
    
    up=i+1; down=i-1;
    right=j+1; left=j-1;
   
       

    % calculating the parameter p
    S=Xnew(up,j)+Xnew(down,j)+Xnew(i,right)+Xnew(i,left);

    p=exp(beta*S + h)/(exp(beta*S + h)+exp(-beta*S - h));
    
    if rand(1)<p
        Xnew(i,j)=1;
    else
        Xnew(i,j)=-1;
    end
%     spinnew=Xnew(i,j);
    X=Xnew(2:end-1,2:end-1);
    
%     if spinold*spinnew==-1
%          ph = ph - S*spinnew;
%     end
end

if bound==3
    Xnew=zeros(n+2,m+2);
    % nesting array into a configuration with +1 boundary
    Xnew(2:end-1,2:end-1)=X;
    
    % picking the vertex at random
    i=floor(rand(1)*n+1) +1;
    j=floor(rand(1)*m+1) +1;
%     spinold=Xnew(i,j);

    % chosing the neighbours for the vertex according to the boundary
    % conditions
    
    up=i+1; down=i-1;
    right=j+1; left=j-1;
   
    % calculating the parameter p
    S=Xnew(up,j)+Xnew(down,j)+Xnew(i,right)+Xnew(i,left);

    p=exp(beta*S + h)/(exp(beta*S + h)+exp(-beta*S - h));
    
    if rand(1)<p
        Xnew(i,j)=1;
    else
        Xnew(i,j)=-1;
    end
%     spinnew=Xnew(i,j);
    X=Xnew(2:end-1,2:end-1);
    
%     if spinold*spinnew==-1
%          ph = ph - S*spinnew;
%     end
end

y=X;






end