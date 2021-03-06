% calculating dependence of magnetization and  energy for various values of beta

% inverse temperature
beta_start=0.025;% 0.025
beta_finish=1;
beta_step=0.025; % 0.025
beta_range = beta_start:beta_step:beta_finish;

% magnetisation
h_start=-1;
h_finish=1;
h_step=0.05; % 0.05
h_range=h_start:h_step:h_finish;

% lattice size
N = 50;

% boundary (1 = perodic)
bound = 1;

% number of iterations
iter = 20000;

% number of repeats
times = 10; 

% initializing of the lattice, p equals the percentage of positive spins
p = 0.5;

energy = Simulate(beta_range, h_range, bound, times, iter, N, p);

imagesc(h_range,beta_range,energy);
 
xlabel({'Feldst�rke des externen Magnetfeldes';})
% xlabel({'Feldst�rke des externen Magnetfeldes';
% "";
% "(Nach " + string(times) + " Iterationen, gemittelt �ber " + string(numb) + " Wiederholungen";
% "mit den Parametern N = " + string(N) + ", p = " + string(p) + " und Randbedingung " + string(bound) + ")"})
ylabel('inverse Temperatur')

h = colorbar;
ylabel(h, 'Energie');

colormap(jet)
set(gca,'FontSize',13)

% fig = gcf;
% fig.Position = [200 100 1120 840];

function energy = Simulate(beta_range, h_range, bound, times, iter, N, p)
    energy = zeros(size(beta_range,2),size(h_range,2));
    b_counter = 1;
    for b=beta_range
        h_counter = 1;
        for h=h_range
            e=0;
            for j=1:times
                X=Init(N,p);
                for i=1:iter
                    X=IsingSim(X,h,b,bound);
                end
                e = e + IsingEnergy(X,b,h);
            end
            % after simulation is done we calculate the magnetisation
            energy(b_counter,h_counter) = e/times;
            h_counter = h_counter + 1;
        end
        b_counter = b_counter + 1;    
    end   
end