% main for exercise 5_1

% parameters
n=500;
tol = 1e-6;
maxit = 4*n;
x0 = zeros(n,1);

A_1 = spdiags([1:n]',[0],n,n);
A_2 = spdiags([linspace(1,2,n/2)';linspace(1000,1001,n/2)'],[0],n,n);
xsol = ones(n,1);

b_1 = A_1*xsol;
b_2 = A_2*xsol;

% run pcg
[~,f,relres_1,iter_1,resvec_1] = pcg(A_1,b_1,tol,maxit,[],[],x0);
[~,~,relres_2,iter_2,resvec_2] = pcg(A_2,b_2,tol,maxit,[],[],x0);

close all;

% plot relative residue for each matrix
figure(1);
semilogy(resvec_1./norm(b_1),'--');
hold on
semilogy(resvec_2./norm(b_2));
yline(tol, ':k');
title('�������� PCG ��� �������� ������ �1, �2');
ylabel('�����-2 �������� ���������')
xlabel('���������')
legend(['�1: ������ = ' num2str(resvec_1(end)) ', ��������� ���� ' num2str(iter_1)],...
    ['�2: ������ = ' num2str(resvec_2(end)) ', ��������� ���� ' num2str(iter_2)],...
    ['tol = ' num2str(tol)]);
hold off
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 25 10]);
saveas(gcf,'5_1.png');  % save as png

% calculate condition of each matrix
cond_1 = condest(A_1)
cond_2 = condest(A_2)


