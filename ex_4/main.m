% Author : Ι . ΓΩΓΟΥ , ΑΜ 1054388 , Date : 15/2/2021

% main for exercise 4

% inputs matrices for function
input{1,1} = 'Rajat/rajat04'; 
input{1,2} = 1497;
input{1,3} = gallery('wathen',10,20);
% titles for plot
input{2,1} = 'Rajat/rajat04 ('; 
input{2,2} = 'Pajek/GD98\_c';
input{2,3} = 'Wathen';

close all;  % close opened figures

% plot rnnz and rerr for each matrix
for i=1:3
    % choose p as any big integer (maximum iterations) because p is bounded inside the algorithm
    Pi = band_stats(input{1,i},10000); 
    % plot rnnz and rerr for each k = 1,3,...,2*p+1 where p = length(P)-1 since
    % iterations are q = 0,1,2,...,p
    figure(i);
    plot([1:2:2*length(Pi)-1],Pi(1,:));
    hold on;
    plot([1:2:2*length(Pi)-1],Pi(2,:),'--');
    title(['rnnz και rerr με μητρώο ' input{2,i} ' (' num2str(size(Pi,2)+1) 'x' num2str(size(Pi,2)+1) ')']);
    ylabel('Τιμή')
    xlabel('Εύρος Ζώνης Μητρώου')
    legend('rnnz','rerr');
    hold off;
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 25 10]);
    saveas(gcf,['4_' num2str(i) '.png']);  % save as png
end




