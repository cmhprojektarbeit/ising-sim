% Ising simulation with different parameters
% parameters of interaction

% chosing beta scales 
beta=0.2;

% magnetisation parameter
h = 0.4;

% lattice size
N = 50;

% boundary (1 = perodic)
bound = 1;

% number of iterations
iter = 30000;

% initializing of the lattice, p equals the percentage of positive spins
p = 0.5;

fig_count = 1;
X=Init(N,p);
figure(fig_count);
colormap(gray);
imagesc(X);
M=IsingMagn(X);
xlabel({strcat("iterations = 0 ,  magnetisation = ", num2str(M))});
pbaspect([1 1 1])
fig = gcf;
fig.Position = [200 100 560 550];
set(gca,'FontSize',18)
% calculating current phase boundary

for i=1:iter
    X=IsingSim(X,h,beta,bound);
%     if mod(i,N^2)==0
    if mod(i,8*N^2)==0 || i == 10000
        E=IsingEnergy(X,beta,h);
        M=IsingMagn(X);
        fig_count = fig_count + 1;
        figure(fig_count)
        fig = gcf;
        fig.Position = [200 100 560 550];      
        colormap(gray);
        imagesc(X);
        set(gca,'FontSize',18)
        pbaspect([1 1 1])
        xlabel({strcat("iterations = ", num2str(i), " ,  magnetisation = ", num2str(M))});
       % title(['Energy of the system = ',num2str(E),'  Mean Magnetisation = ', num2str(M), ' Number of iterations = ',num2str(i), ' Phasencountour = ',num2str(ph)]);
        pause(0.1);
    end
end


