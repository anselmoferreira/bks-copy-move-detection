function [mean_acc,mean_tpr,mean_fpr,std_acc,std_tpr,std_fpr]=main (c, g, database_name, fold_train, fold_test)

	disp('Step 1: Load the model (bks) for the trained BKS classifier');
	BKS = importdata(['../../aux/already_built_bks_tables/multiscale_bks_svr/UNCOMPRESSED/bks-treino-' int2str(fold_train) 'database-' database_name '_' num2str(c) '_' num2str(g) '.csv']);

	disp('Step 2: Do the test and apply the Local Variable Threshold to improve classification');
	[mean_acc,mean_tpr,mean_fpr,std_acc,std_tpr,std_fpr]=bks_table_test_LVT(BKS, fold_test);
	
end
