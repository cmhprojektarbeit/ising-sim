% calculating dependence of magnetization and energy for various values of beta

% inverse temperature
beta = 0.1;

% magnetisation
h_start=-1.0;
h_step=0.1;
h_finish=1.0;
h_range=h_start:h_step:h_finish;

% lattice size
N = 50;

% boundary (1 = perodic)
bound = 1;

% number of iterations
iter = 10000;

% number of repeats
times = 50; 

% initializing of the lattice, p equals the percentage of positive spins
p = 0.5;

mag = Simulate(beta, h_range, bound, iter, times, N, p);

plot(h_start:h_step:h_finish,mag,'*');
xlabel({'Feldstärke des externen Magnetfeldes';})
% xlabel({'Feldstärke des externen Magnetfeldes';
% "";
% "(Nach " + string(times) + " Iterationen, gemittelt über " + string(numb) + " Wiederholungen";
% "mit den Parametern beta = " + string(beta) + ", N = " + string(N) + ", p = " + string(p) + " und Randbedingung " + string(bound) + ")"})
ylabel(strcat('Magnetisierung'))

hold on

beta = 0.442;
mag = Simulate(beta, h_range, bound, iter, times, N, p);
plot(h_range,mag,'*');

beta = 1;
mag = Simulate(beta, h_range, bound, iter, times, N, p);
plot(h_range,mag,'*');

hold off
set(gca,'FontSize',13)
legend('beta = 0.1', 'beta = 0.442', 'beta = 1')

% fig = gcf;
% fig.Position = [200 100 1120 840];

function mag = Simulate(beta, h_range, bound, iter, times, N, p)
    mag = zeros(size(h_range,2),1);
    counter = 1;
    for s=h_range
        m=0;
        for j=1:times
            X=Init(N,p);
            for i=1:iter
                X=IsingSim(X,s,beta,bound);
            end
            m = m + IsingMagn(X);
        end
        % after simulation is done we calculate the magnetisation
        mag(counter)=m/times;
        counter = counter + 1;
    end
end