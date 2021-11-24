function Ax = myMV(z)

global w;
N = sqrt(length(z));  %block size
h = 1/(N+1);

% Create vector for each unknown variable and sum them into final result

% (4-w^2*h^2)*Uij 
Ax_1 = (4-w^2*h^2)*z(1:N^2);

% - Uij-1
Ax_2 = zeros(N^2,1);
for i=[1:N]
    Ax_2(1+(i-1)*N:i*N) = -[z(1+(i-1)*N:i*N-1);0];  % all Uij except where j = N
end

% - Uij+1
Ax_3 = zeros(N^2,1);
for i=[1:N]
    Ax_3(1+(i-1)*N:i*N) = -[0;z(2+(i-1)*N:i*N)];  % all Uij except where j = 1
end

% - Ui-1j
Ax_4 = -[z(1:N^2-N);zeros(N,1)];  % all Uij except last N

% - Ui+1j
Ax_5 = -[zeros(N,1);z(N+1:N^2)];  % all Uij except first N


Ax = Ax_1 + Ax_2 + Ax_3 + Ax_4 + Ax_5;


