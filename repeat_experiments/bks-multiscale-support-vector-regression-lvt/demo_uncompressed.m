%parameters for random forests using uncompressed images
c=1;
g=0.5;
			

disp('Starting experiments on uncompressed images.');
disp(['For our Multiscale BKS on uncompressed images we use C=' int2str(c)  ' and G=' num2str(g) ' for the support vector regression']);
disp('Starting the 5x2 CV: uncompressed database. Have Fun.');
disp('Press enter to begin...');
pause;

system('mkdir results');
			
disp('First combination of training and test. Fold 1 starting...');
[mean_acc1,mean_tpr1,mean_fpr1,std_acc1,std_tpr1,std_fpr1]=main(c,g,'CPHPALL', 1, 2);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc1, mean_tpr1, mean_fpr1, std_acc1, std_tpr1, std_fpr1),'-append');
clc;

disp('Second combination of training and test. Fold 2 starting...');
[mean_acc2,mean_tpr2,mean_fpr2,std_acc2,std_tpr2,std_fpr2]=main(c,g,'CPHPALL', 2, 1);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc2, mean_tpr2, mean_fpr2, std_acc2, std_tpr2, std_fpr2),'-append');
clc;

disp('Third combination of training and test. Fold 3 starting...');
[mean_acc3,mean_tpr3,mean_fpr3,std_acc3,std_tpr3,std_fpr3]=main(c,g,'CPHPALL', 3, 4);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc3, mean_tpr3, mean_fpr3, std_acc3, std_tpr3, std_fpr3),'-append');
clc;

disp('Fourth combination of training and test. Fold 4 starting...');
[mean_acc4,mean_tpr4,mean_fpr4,std_acc4,std_tpr4,std_fpr4]=main(c,g,'CPHPALL', 4, 3);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc4, mean_tpr4, mean_fpr4, std_acc4, std_tpr4, std_fpr4),'-append');
clc;

disp('Fifth combination of training and test. Fold 5 starting...');
[mean_acc5,mean_tpr5,mean_fpr5,std_acc5,std_tpr5,std_fpr5]=main(c,g,'CPHPALL', 5, 6);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc5, mean_tpr5, mean_fpr5, std_acc5, std_tpr5, std_fpr5),'-append');
clc;

disp('Sixth combination of training and test. Fold 6 starting...');	
[mean_acc6,mean_tpr6,mean_fpr6,std_acc6,std_tpr6,std_fpr6]=main(c,g,'CPHPALL', 6, 5);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc6, mean_tpr6, mean_fpr6, std_acc6, std_tpr6, std_fpr6),'-append');
clc;

disp('Seventh combination of training and test. Fold 7 starting...');	
[mean_acc7,mean_tpr7,mean_fpr7,std_acc7,std_tpr7,std_fpr7]=main(c,g,'CPHPALL', 7, 8);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc7, mean_tpr7, mean_fpr7, std_acc7, std_tpr7, std_fpr7),'-append');
clc;
	
disp('Eigth combination of training and test. Fold 8 starting...');	
[mean_acc8,mean_tpr8,mean_fpr8,std_acc8,std_tpr8,std_fpr8]=main(c,g,'CPHPALL', 8, 7);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc8, mean_tpr8, mean_fpr8, std_acc8, std_tpr8, std_fpr8),'-append');
clc;

disp('Nineth combination of training and test. Fold 9 starting...');	
[mean_acc9,mean_tpr9,mean_fpr9,std_acc9,std_tpr9,std_fpr9]=main(c,g,'CPHPALL', 9, 10);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc9, mean_tpr9, mean_fpr9, std_acc9, std_tpr9, std_fpr9),'-append');
clc;

disp('Tenth combination of training and test. Fold 10 starting...');	
[mean_acc10,mean_tpr10,mean_fpr10,std_acc10,std_tpr10,std_fpr10]=main(c,g,'CPHPALL', 10, 9);
dlmwrite('results/svr_lvt-CPHPALL-FULL-RESULTS.txt',horzcat(mean_acc10, mean_tpr10, mean_fpr10, std_acc10, std_tpr10, std_fpr10),'-append');
clc;


disp(['Final mean accuracy is ' num2str(mean(vertcat(mean_acc1,mean_acc2,mean_acc3,mean_acc4,mean_acc5,mean_acc6,mean_acc7,mean_acc8,mean_acc9,mean_acc10))*100) '%']);

%Now we write the parameters used for the regression, the mean normalized accuracy, the mean true positive rate, the mean false positive
%rate and the mean standard deviations of accuracy, true positive rate and false positive rates 
dlmwrite('results/svr_lvt-CPHPALL-RESULTS.txt',horzcat(c,g,mean(vertcat(mean_acc1,mean_acc2,mean_acc3,mean_acc4,mean_acc5,mean_acc6,mean_acc7,mean_acc8,mean_acc9,mean_acc10)), mean(vertcat(mean_tpr1,mean_tpr2,mean_tpr3,mean_tpr4,mean_tpr5,mean_tpr6,mean_tpr7,mean_tpr8,mean_tpr9,mean_tpr10)), mean(vertcat(mean_fpr1,mean_fpr2,mean_fpr3,mean_fpr4,mean_fpr5,mean_fpr6,mean_fpr7,mean_fpr8,mean_fpr9,mean_fpr10)), mean(vertcat(std_acc1,std_acc2,std_acc3,std_acc4,std_acc5,std_acc6,std_acc7,std_acc8,std_acc9,std_acc10)), mean(vertcat(std_tpr1,std_tpr2,std_tpr3,std_tpr4,std_tpr5,std_tpr6,std_tpr7,std_tpr8,std_tpr9,std_tpr10)), mean(vertcat(std_fpr1,std_fpr2,std_fpr3,std_fpr4,std_fpr5,std_fpr6,std_fpr7,std_fpr8,std_fpr9,std_fpr10))),'-append');

%Now we write the 10 mean accuracies, 10 mean false positive rates and 10 mean false positive rates 
dlmwrite('results/svr_lvt-CPHPALL-RESULTS-10-ACC.txt',horzcat(c,g,mean_acc1,mean_acc2,mean_acc3,mean_acc4,mean_acc5,mean_acc6,mean_acc7,mean_acc8,mean_acc9,mean_acc10), '-append');
dlmwrite('results/svr_lvt-CPHPALL-RESULTS-10-FPR.txt',horzcat(c,g,mean_fpr1,mean_fpr2,mean_fpr3,mean_fpr4,mean_fpr5,mean_fpr6,mean_fpr7,mean_fpr8,mean_fpr9,mean_fpr10), '-append');
dlmwrite('results/svr_lvt-CPHPALL-RESULTS-10-TPR.txt',horzcat(c,g,mean_tpr1,mean_tpr2,mean_tpr3,mean_tpr4,mean_tpr5,mean_tpr6,mean_tpr7,mean_tpr8,mean_tpr9,mean_tpr10), '-append');
