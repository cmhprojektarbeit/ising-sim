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
iter = 10000;

% number of repeats
times = 10;

% initializing of the lattice, p equals the percentage of positive spins
p = 0.5;

mag = Simulate(beta_range, h_range, bound, times, iter, N, p);

imagesc(h_range,beta_range,mag);
xlabel({'Feldstärke des externen Magnetfeldes';})
% xlabel({'Feldstärke des externen Magnetfeldes';
% "";
% "(Nach " + string(times) + " Iterationen, gemittelt über " + string(numb) + " Wiederholungen";
% "mit den Parametern N = " + string(N) + ", p = " + string(p) + " und Randbedingung " + string(bound) + ")"})
ylabel('inverse Temperatur')

h = colorbar;
ylabel(h, 'Magnetisierung');

colormap(jet)

set(gca,'FontSize',15)
% fig = gcf;
% fig.Position = [200 100 1120 840];

function mag = Simulate(beta_range, h_range, bound, times, iter, N, p)
    mag = zeros(size(beta_range,2),size(h_range,2));
    b_counter = 1;
    for b=beta_range
        h_counter = 1;
        for h=h_range
            m=0;
            for j=1:times
                X=Init(N,p);
                for i=1:iter
                    X=IsingSim(X,h,b,bound);
                end
                m = m + IsingMagn(X);
            end
            % after simulation is done we calculate the magnetisation
            mag(b_counter,h_counter) = m/times;
            h_counter = h_counter + 1;
        end
        b_counter = b_counter + 1;
    end   
end