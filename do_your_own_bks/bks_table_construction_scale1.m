function [BKS] = bks_table_construction_scale1(BKS, database_name, fold_train)

	%Read the images list of training and testing according to our 5x2 cross validation procedure 
	images_per_fold=csvread('../aux/5x2data/CPH_ALL.csv');

	disp('Using scale 1 binary output images to fill bks tables');
  
	%BKS is built using only training images, so, we iterate trough these images
	for k=1:size(images_per_fold,2) 
		
		name_image=images_per_fold(fold_train,k);
		disp(['Image ' int2str(k) ':' int2str(name_image)]);

		%Binary output images from the 8 fused approaches are read
		copiacolagem_result=imread(['../aux/output_cph_database/scale1/copiacolagem/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		sift_result=imread(['../aux/output_cph_database/scale1/sift/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		surf_result=imread(['../aux/output_cph_database/scale1/surf/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		hierarch_sift_result=imread(['../aux/output_cph_database/scale1/hierarch-sift/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		zernike_result=imread(['../aux/output_cph_database/scale1/zernike/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
	    	zernike2_result=imread(['../aux/output_cph_database/scale1/zernike2/CPHPALL/' num2str(name_image) '/' num2str(name_image) '.png']);
    		kpca_result=imread(['../aux/output_cph_database/scale1/kpca/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
    		dct_result=imread(['../aux/output_cph_database/scale1/dct/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);

		%read ground truth to fill probabilities		
		ground_truth=imread(['../aux/cph_database/scale1/CPHPALL/' int2str(images_per_fold(fold_train,k)) '/' int2str(images_per_fold(fold_train,k)) '_gt.png']);
		
		%Now we investigate the binary outputs pixel-wise to fill BKS Tables
		for i=1:size(ground_truth,1)
            		for j=1:size(ground_truth,2)
     
                		%concatenating the 8 binary outputs for the given pixel
                		joined=horzcat(dct_result(i,j),zernike_result(i,j),zernike2_result(i,j),hierarch_sift_result(i,j),kpca_result(i,j),sift_result(i,j),surf_result(i,j),copiacolagem_result(i,j));

                		%Converting 255 to 1
                		joined=joined==255;
                		joined2=sprintf('%d',joined);
                
                		%Now we look for this combination in the BKS Table		
                		[x,~]=find(strcmp(BKS, joined2),1);
                
                		%If the pixel from the training image is truly a copy move pixel we increment the counter of the binary
				%combination as being a copy move forgery combination
                		if ground_truth(i,j)==255                
                    			BKS{x,2}=BKS{x,2}+1;
                		end
                
                		%We also increment the combination frequency
                		BKS{x,3}=BKS{x,3}+1;
            		end
        	end
	end


end
