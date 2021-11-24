% main for exercise 5_2

% parameters
k=10; % iterations for different random matrix every time
n=500;
m=100;
tol = 1e-6;
maxit = 4*n;
x0 = zeros(n,1);

%A = randn(n); xsol = rand(n,1);  %uncomment this to create new random matrix
load('A.mat'); load('xsol.mat');

b = A*xsol;

% run pcg
[x_pcg,~,relres_pcg,iter_pcg,resvec_pcg] = pcg(A.'*A,A.'*b,tol,maxit,[],[],x0); % we want the normal equation and A does not contain imaginary number so we transpose with ".'"

% run gmres(m)
[x_gmres_m,~,relres_gmres_m,iters_gmres_m,resvec_gmres_m] = gmres(A,b,m,tol,maxit/m,[],[],x0);  %maxit = maxit/m * m = 4*n
iter_gmres_m = iters_gmres_m(1)*iters_gmres_m(2);  % total iters = outer iters * inner iters 

% run gmres(n)
[x_gmres,~,relres_gmres,iters_gmres,resvec_gmres] = gmres(A,b,n,tol,maxit,[],[],x0);
iter_gmres = iters_gmres(1)*iters_gmres(2);  % total iters = outer iters * inner iters

close all;

% plot relative residue for each method
figure;
semilogy(resvec_pcg./norm(A.'*b),'-.r');
hold on
semilogy(resvec_gmres_m./norm(b),'--m');
semilogy(resvec_gmres./norm(b),'b');
yline(tol, ':k');
title('Σύγκλιση PCG, GMRES(m) και GMRES(n) για τυχαίο μητρώο A');
ylabel('Νόρμα-2 Σχετικού Υπολοίπου')
xlabel('Επανάληψη')
legend(['pcg: σφάλμα = ' num2str(resvec_pcg(end)) ', τελευταίο βήμα ' num2str(iter_pcg)],...
    ['gmres(m): σφάλμα = ' num2str(resvec_gmres_m(end)) ', τελευταίο βήμα ' num2str(iter_gmres_m)],...
    ['gmres(n): σφάλμα = ' num2str(resvec_gmres(end)) ', τελευταίο βήμα ' num2str(iter_gmres)],...
    ['tol = ' num2str(tol)]);
hold off
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 25 10]);
saveas(gcf,'5_2.png');  % save as png

% number or operations for each vector
mv_pcg = iter_pcg;
mv_gmres_m = 1 + (iters_gmres_m(1) - 1) * (2*m + 1) + 2 * iters_gmres_m(2) + 1;
mv_gmres = 1 + 2 * iters_gmres(2) + 1;

% run time for each method
t_pcg = timeit(@()pcg(A.'*A,A.'*b,tol,maxit),5);
t_gmres_m = timeit(@()gmres(A,b,m,tol,maxit/m,[],[],x0),5);
t_gmres = timeit(@()gmres(A,b,n,tol,maxit,[],[],x0),5);

% run time for backslash solution
x_approx = A\b;
t_bckslsh = timeit(@()A\b,1);

% relative residual error  for backslash solution
b_approx = A*x_approx;
relres_bckslsh = norm(b_approx-b)/norm(b);








