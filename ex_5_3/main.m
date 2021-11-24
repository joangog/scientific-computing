% Author : Ι . ΓΩΓΟΥ , ΑΜ 1054388 , Date : 18/2/2021

% main for exercise 5_3

global w;
w = 0;

% parameters
N = 2^7-1;
Usol = ones(N^2,1);
h = 1/(N+1);
tol = 1e-6;
x0 = zeros(N^2,1);
maxit = 4*N^2;

% create A matrix (block tridiagonal)
B = toeplitz([4-w^2*h^2,-1,zeros(1,N-2)]);
C = -eye(N);
A = zeros(N^2);
for k=1:N
    A(1+(k-1)*N:k*N,1+(k-1)*N:k*N) = B;  % block diagonal
    if(k<N)
        i = k + 1;
        A(1+(i-1)*N:i*N,1+(k-1)*N:k*N) = C;  % 1st block subdiagonal (i = j + 1)
    end
    if(k<N)
        j = k + 1;
        A(1+(k-1)*N:k*N,1+(j-1)*N:j*N) = C;  % 1st block superdiagonal (j = i + 1)
    end
end
A = sparse(A);

G = A*Usol./h^2;
b = h^2.*G;  % right side of equation

close all;  % close all plots

% plot structure of A 
spy(A,'s');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 10 10]);
saveas(gcf,'5_3_1.png');  % save as png

% validate if A is symmetric positive definite (not_spd should be 0)
[~,not_spd] = chol(A);

% create preconditioner matrix
L = ichol(A);

% run pcg no preconditioner
[U_pcg,f_pcg,relres_pcg,iter_pcg,resvec_pcg] = pcg(A,b,tol,maxit,[],[],x0);

% run pcg with chol preconditioner
[U_pcg_chol,f_pcg_chol,relres_pcg_chol,iter_pcg_chol,resvec_pcg_chol] = pcg(A,b,tol,maxit,L,L',x0);

% plot relative residue for each method
figure;
semilogy(resvec_pcg./norm(b),'--');
hold on
semilogy(resvec_pcg_chol./norm(b),'');
yline(tol, ':k');
title(['Σύγκλιση PCG, και PCG με chol preconditioner για ω=' num2str(w)]);
ylabel('Νόρμα-2 Σχετικού Υπολοίπου')
xlabel('Επανάληψη')
legend(['pcg: σφάλμα = ' num2str(resvec_pcg(end)) ', τελευταίο βήμα ' num2str(iter_pcg)],...
    ['pcg chol preconditioner: σφάλμα = ' num2str(resvec_pcg_chol(end)) ', τελευταίο βήμα ' num2str(iter_pcg_chol)],...
    ['tol = ' num2str(tol)]);
hold off
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 25 10]);
saveas(gcf,['5_3_' num2str(w+2) '.png']);  % save as png


