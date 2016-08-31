function [copiacolagem_result,sift_result,surf_result,hierarch_sift_result,zernike_result,zernike2_result,kpca_result,dct_result]=load_image(images_per_fold,fold_teste,k)

name_image=images_per_fold(fold_teste,k);
copiacolagem_result=imread(['../../aux/output_cph_database/scale1/copiacolagem/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
sift_result=imread(['../../aux/output_cph_database/scale1/sift/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
surf_result=imread(['../../aux/output_cph_database/scale1/surf/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
hierarch_sift_result=imread(['../../aux/output_cph_database/scale1/hierarch-sift/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
zernike_result=imread(['../../aux/output_cph_database/scale1/zernike/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);	zernike2_result=imread(['../../aux/output_cph_database/scale1/zernike2/CPHPALL/' num2str(name_image) '/' num2str(name_image) '.png']);
kpca_result=imread(['../../aux/output_cph_database/scale1/kpca/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
dct_result=imread(['../../aux/output_cph_database/scale1/dct/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);

end
