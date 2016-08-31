function [BKS]=main_table_construction(database, fold_train)

	%Initiate BKS table with 2^k rows and three columns
	%In our work we consider 8 approaches to be fused, so here k equals to 8. You can change the code if you want to 
	BKS=cell(2^8,3);

	%Filling the first column with combinations of 8 binary outputs 
	for k=1:256
		BKS{k,1}=dec2mvl(k-1,8);
	end

	%The second column stores the frequency of the binary combination of outputs as being a copy move forgery according to
	%the ground truth
        BKS(:,2)={0};

	%The third column stores the total frequency of that binary combination
	BKS(:,3)={0};

%Now we call the table construction on the given scale
%The variable database will indicate where the images are
%indicates which images will be used to build the BKS table   
%Just for the matter of demonstration, the code will build the BKS on our images
%You can change the code to include yours
[BKS] = bks_table_construction_scale1(BKS, database, fold_train);
[BKS] = bks_table_construction_scale1_2(BKS, database, fold_train);
[BKS] = bks_table_construction_scale1_4(BKS, database, fold_train);

%Saving the table in CSV format
	[nrows, NCOLS]= size(BKS);
filename = ['bks_original_tables/bks-treino-' int2str(fold_train) 'database-' database '.csv'];
fid = fopen(filename, 'w');
for row=1:nrows
    fprintf(fid, '%s %d %d \n', BKS{row,:});
end
fclose(fid);
end
