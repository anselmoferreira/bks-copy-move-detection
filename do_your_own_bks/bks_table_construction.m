%dada a base de imagens dada, procuro as imagens dela e construo a tabela BKS de acordo com as saídas dos classificadores para cada pixel.
 
function [BKS] = bks_table_construction(database_name, fold_treino)

%LI a tabela onde estão todas as imagens
images_per_fold=csvread('../../folds_trabalho_oficial/CPH_ALL.csv');
relacao_uncompressed_compressed=dlmread('/datasets/anselmo/CPH/iguais-cphpall-cphcompressed.txt');
%inicio a tabela BKS

	BKS=cell(2^8,3);

	%na primeira coluna, tenho a combinação binária
	for k=1:256
		BKS{k,1}=dec2mvl(k-1,8);
	end

	%NA SEGUNDA COLUNA TENHO QUANTAS VEZES ESSA COMBINAÇÃO ERA 1 NO GROUND-TRUTH
        BKS(:,2)={0};

	%NA TERCEIRA COLUNA EU TENHO QUANTAS VEZES ESSA COMBINAÇÃO OCORREU NO TOTAL
	BKS(:,3)={0};

%quero apenas o fold de treino enviado como parâmetro pelo usuário.
%vou percorrer as colunas da tabela de imagens apenas na linha do fold que será usado para treino

for k=1:size(images_per_fold,2) 

	if strcmp(database_name,'CPHCOMPRESSED')==1
		compressed_image_name=relacao_uncompressed_compressed(images_per_fold(fold_treino,k),2);
		%disp(['Imagem não comprimida:' int2str(images_per_fold(fold_treino,k))]);
		%disp(['Equivalente comprimida:' int2str(compressed_image_name)]);
		%pause; 
		copiacolagem_result=imread(['/datasets/anselmo/output_cph_database/copiacolagem/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.jpg']);
		sift_result=imread(['/datasets/anselmo/output_cph_database/sift/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
		surf_result=imread(['/datasets/anselmo/output_cph_database/surf/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
		hierarch_sift_result=imread(['/datasets/anselmo/output_cph_database/hierarch-sift/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
		zernike_result=imread(['/datasets/anselmo/output_cph_database/zernike/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
    		zernike2_result=imread(['/datasets/anselmo/output_cph_database/zernike2/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
    		kpca_result=imread(['/datasets/anselmo/output_cph_database/kpca/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
    		dct_result=imread(['/datasets/anselmo/output_cph_database/dct/CPHCOMPRESSED/' num2str(compressed_image_name) '/' num2str(compressed_image_name) '_post.png']);
	else
		name_image=images_per_fold(fold_treino,k);
		copiacolagem_result=imread(['/datasets/anselmo/output_cph_database/copiacolagem/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		sift_result=imread(['/datasets/anselmo/output_cph_database/sift/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		surf_result=imread(['/datasets/anselmo/output_cph_database/surf/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		hierarch_sift_result=imread(['/datasets/anselmo/output_cph_database/hierarch-sift/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
		zernike_result=imread(['/datasets/anselmo/output_cph_database/zernike/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
	    	zernike2_result=imread(['/datasets/anselmo/output_cph_database/zernike2/CPHPALL/' num2str(name_image) '/' num2str(name_image) '.png']);
    		kpca_result=imread(['/datasets/anselmo/output_cph_database/kpca/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);
    		dct_result=imread(['/datasets/anselmo/output_cph_database/dct/CPHPALL/' num2str(name_image) '/' num2str(name_image) '_post.png']);

	end

	ground_truth=imread(['/datasets/anselmo/CPH/CPHPALL/' int2str(images_per_fold(fold_treino,k)) '/' int2str(images_per_fold(fold_treino,k)) '_gt.png']);
		

    	disp(['Analisando imagem ../../databases/' database_name '/' int2str(images_per_fold(fold_treino,k))]);  
	%agora que a primeira coluna da tabela bks está inicializada, vou calcular somente as frequências
	%percorre a imagem e vai gravando a frequência da combinação na tabela bks
        for i=1:size(ground_truth,1)
            for j=1:size(ground_truth,2)
     
                %concateno a saída de cada classificador no pixel e converto para strings, temos uma combinação
                joined=horzcat(dct_result(i,j),zernike_result(i,j),zernike2_result(i,j),hierarch_sift_result(i,j),kpca_result(i,j),sift_result(i,j),surf_result(i,j),copiacolagem_result(i,j));

                %converto 255 e 0 para 1 e 0
                joined=joined==255;

                joined2=sprintf('%d',joined);
                
                %vou procurar essa combinação na tabela		
                [x,~]=find(strcmp(BKS, joined2),1);
                
                %incremento a segunda coluna se a combinação for 1 no ground-truth
                if ground_truth(i,j)==255                
                    BKS{x,2}=BKS{x,2}+1;
                end
                
                %incremento a terceira coluna, que é apenas a frequência dessa combinação
                BKS{x,3}=BKS{x,3}+1;
            end
        end
end

%agora salva a tabela como csv

[nrows, NCOLS]= size(BKS);

filename = ['bks_tables/bks-treino-' int2str(fold_treino) 'database-' database_name '.csv'];
fid = fopen(filename, 'w');

for row=1:nrows
    fprintf(fid, '%s %d %d \n', BKS{row,:});
end

fclose(fid);

end
