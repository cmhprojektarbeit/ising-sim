% calculating dependence of magnetization and energy for various values of beta

% chosing beta scales 
beta_start=0.05;
beta_finish=1;
beta_step=0.05;
beta_range = beta_start:beta_step:beta_finish;

% magnetisation parameter
h = 0.4;

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

mag = Simulate(beta_range, h,bound, iter, times, N, p);

plot(beta_start:beta_step:beta_finish,mag,'ro');
xlabel({'inverse Temperatur';})
% xlabel({'inverse Temperatur';
% "";
% "(Nach " + string(iter) + " Iterationen, gemittelt über " + string(times) + " Wiederholungen";
% "mit den Parametern beta = " + string(beta) + ", N = " + string(N) + ", p = " + string(p) + " und Randbedingung " + string(bound) + ")"})
ylabel('Magnetisierung')

hold on

iter = 20000;
mag = Simulate(beta_range, h, bound, iter, times, N, p);
plot(beta_range,mag,'o');

iter = 40000;
mag = Simulate(beta_range, h, bound, iter, times, N, p);
plot(beta_range,mag,'o');

hold off

set(gca,'FontSize',13)
legend('iter = 10000', 'iter = 20000', 'iter = 40000','Location','southeast')

% fig = gcf;
% fig.Position = [200 100 1120 840];

function mag = Simulate(beta_range, h,bound, iter, times, N, p)
    mag = zeros(size(beta_range,2),1);
    counter = 1;
    for s=beta_range
        m=0;
        for j=1:times
            X=Init(N,p);
            for i=1:iter
                X=IsingSim(X,h,s,bound);
            end
            m=m+IsingMagn(X);
        end
        % after simulation is done we calculate the magnetisation
        mag(counter)=m/times;
        counter = counter + 1;
    end
end