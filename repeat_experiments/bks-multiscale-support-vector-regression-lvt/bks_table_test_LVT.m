function [mean_acc,mean_tpr,mean_fpr,std_acc,std_tpr,std_fpr]= bks_table_test(BKS, fold_test)

	%Open the list of test images
	images_per_fold=csvread('../../aux/5x2data/CPH_ALL.csv');
	
	disp('Starting classifying test images...');

	for k=1:size(images_per_fold,2) 
		disp(['Test image: ' int2str(images_per_fold(fold_test,k))]);

		%read binary outputs of 8 classifiers already runned over the images
		[copiacolagem_result,sift_result,surf_result,hierarch_sift_result,zernike_result,zernike2_result,kpca_result,dct_result]=load_image(images_per_fold,fold_test,k);	

		%creating the output image 
		image_result=zeros(size(zernike_result,1), size(zernike_result,2));

		%For each pixel, the code query the 8 outputs from the fused classifier in the BKS Table
		for i=1:size(image_result,1)
            		for j=1:size(image_result,2)     

			        %The 8 outputs for the (i,j) pixel are in joined variable        		
				joined=horzcat(kpca_result(i,j),zernike2_result(i,j),dct_result(i,j),hierarch_sift_result(i,j),copiacolagem_result(i,j),sift_result(i,j),surf_result(i,j),zernike_result(i,j));
     				%converting 255 to 1
                		joined=joined==255;
				%Here we have the probability queried in the table for the given combination of outputs
         			probability_image(i,j)=BKS(bi2de(joined)+1,9);
         			%If the probability is higher than 50% there is a copied and moved pixel
		       		if (BKS(bi2de(joined)+1,9))>0.5
                    			image_result(i,j)=1; 
                		else
                    			image_result(i,j)=0;
                		end
			end
    		end

		disp('BKS classification done. Now we start varying the threshold according to each pixel neighborhood and creating new probability image.');
	
		%New output image 
		new_image_result=zeros(size(zernike_result,1), size(zernike_result,2));
	        
		%The probability map is convolved with a 9x9 filter, so we have the mean probabilities of each pixel in a 9x9 neighborhood
		%used for the local variable treshold equation 
		image_result = conv2(image_result, 1.0 / 9 * ones(3), 'valid');
	 
                %Now the image is analyzed again, but now changing the threshold according to the neighborhood
		for i=1:size(image_result,1)
            		for j=1:size(image_result,2)

					%here it is the new threshold     
                			new_threshold=0.5-2*(image_result(i,j)-0.5)*0.2;
					if(probability_image(i,j)>new_threshold)	
						new_image_result(i,j)=255;
					end	
				end
    		end
	

		%reading ground truth for comparison in the end
		ground_truth=imread(['../../aux/cph_database/scale1/CPHPALL/' int2str(images_per_fold(fold_test,k)) '/' int2str(images_per_fold(fold_test,k)) '_gt.png']);
		[tpr,fpr,acc]=calculate_statistics(new_image_result, ground_truth(:,:,1));
		acc_vec(k)=acc;
		tpr_vec(k)=tpr;
		fpr_vec(k)=fpr;
		disp('Image pixels classified.');	
	end

disp('Sub-experiment finished');

mean_acc=mean(acc_vec);
mean_tpr=mean(tpr_vec);
mean_fpr=mean(fpr_vec);
std_acc=std(acc_vec);
std_tpr=std(tpr_vec);
std_fpr=std(fpr_vec);

end
