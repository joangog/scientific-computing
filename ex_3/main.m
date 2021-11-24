% main for exercise 3

A = [0,1,0;0,0,1;1,0,0];
i = 1; j = 2;
k = 4;

close all;

% plot graph of A
figure;
plot(digraph(A));
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 6 4]);
saveas(gcf,'3.png');  % save as png

% find path tensor of A
G = path_tensor(A,k);

% calculate count of paths of max length k for pair i-j
count_ij = path_count_ij(G,i,j)

% calculate count of paths of max length k for every pair i-j
count = path_count(G)