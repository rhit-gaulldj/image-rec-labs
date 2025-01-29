load('datagridpt2c.mat');
load('datagrid2pt2c.mat');

%%
accs = datagrid(:, 1);
Cs = datagrid(:, 2);
Ks = datagrid(:, 3);

figure;
scatter(Cs, Ks, 50, accs, 'filled');
set(gca, 'XScale', 'log', 'YScale', 'log');
colorbar;
colormap jet;
xlabel('Box Constraint (log scale)');
ylabel('Kernel Scale (log scale)');
title('Hyperparameter Tuning with Validation Accuracy (Part 1)');

%%%%%%

accs = datagrid2(:, 1);
Cs = datagrid2(:, 2);
Ks = datagrid2(:, 3);

figure;
scatter(Cs, Ks, 50, accs, 'filled');
%set(gca, 'XScale', 'log', 'YScale', 'log');
colorbar;
colormap jet;
xlabel('Box Constraint (linear scale)');
ylabel('Kernel Scale (linear scale)');
title('Hyperparameter Tuning with Validation Accuracy (Part 2)');
