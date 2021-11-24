% main for exercise 2

% matrices
A_1 = load('stufe.mat').Problem.A;
A_2 = load('ukerbe1_dual.mat').Problem.A;

% block sizes
nb_1 = 4;
nb_2 = 3;

% matrix A1
[val_1,col_dx_1,row_blk_1] = sp_mx2bcrs(A_1,nb_1);
y_1 = randi(10,length(A_1),1);
x_1 = randi(10,length(A_1),1);
y_new_1 = spmv_bcrs(y_1,val_1,col_dx_1,row_blk_1,x_1);
err_1 = norm((A_1*x_1 + y_1)-y_new_1);  % check for error

% matrix A2
[val_2,col_dx_2,row_blk_2] = sp_mx2bcrs(A_2,nb_2);
y_2 = randi(10,length(A_2),1);
x_2 = randi(10,length(A_2),1);
y_new_2 = spmv_bcrs(y_2,val_2,col_dx_2,row_blk_2,x_2);
err_2 = norm((A_2*x_2 + y_2)-y_new_2);




