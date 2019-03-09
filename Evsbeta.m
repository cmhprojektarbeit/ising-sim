% calculating dependence of magnetization and  energy for various values of beta

% chosing beta scales 
beta_start = 0.05;
beta_step = 0.05;
beta_finish = 1;
beta_range = beta_start:beta_step:beta_finish;

% magnetisation parameter
h = 0;

% lattice size
N = 50;

% boundary (1 = perodic)
bound = 1;

% number of iterations
iter = 20000;

% number of repeats
times = 5;

% initializing of the lattice, p equals the percentage of positive spins
p = 0.5;

energy = Simulate(beta_range, h,bound, iter, times, N, p);
plot(beta_range,energy,'o');
title("")
xlabel({"inverse Temperatur";})
% xlabel({"inverse Temperatur";
% "";
% "(Nach " + string(times) + " Iterationen, gemittelt über " + string(iter) + " Wiederholungen";
% "mit den Parametern h = " + string(h) + ", N = " + string(N) + ", p = " + string(p) + " und Randbedingung " + string(bound) + ")"})
ylabel("Energie")

hold on

h = 0.5;
energy = Simulate(beta_range, h, bound, iter, times, N, p);
plot(beta_range,energy,'o');

h = 1;
energy = Simulate(beta_range, h, bound, iter, times, N, p);
plot(beta_range,energy,'o');

hold off
legend('h = 0', 'h = 0.5', 'h = 1')
set(gca,'FontSize',13)

% fig = gcf;
% fig.Position = [200 100 1120 840];

function energy = Simulate(beta_range, h,bound, iter, times, N, p)
    energy = zeros(size(beta_range,2),1);
    counter = 1;
    for s=beta_range
        e=0;
        for j=1:times
            X=Init(N,p);
            for i=1:iter
                X=IsingSim(X,h,s,bound);
            end
            e=e+IsingEnergy(X,s,h);
        end
        % after simulation is done we calculate the magnetisation
        energy(counter)=e/times;
        counter = counter + 1;
    end
end
