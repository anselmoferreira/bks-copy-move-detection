function [tpr,fpr,acc]=calculate_statistics(technique_binary_image, ground_truth)

technique_binary_image = technique_binary_image./255.0;
ground_truth = ground_truth./255.0;

false_positives=0;
false_negatives=0;
true_positives=0;
true_negatives=0;
totalClone = 0;
totalNormal = 0;

for i=1:size(technique_binary_image,1)
	for j=1:size(technique_binary_image,2) 
		if technique_binary_image(i,j)==ground_truth(i,j) && ground_truth(i,j)~=0
			true_positives=true_positives+1;
		end
		
		if technique_binary_image(i,j)==ground_truth(i,j) && ground_truth(i,j)==0
			true_negatives=true_negatives+1;
		end

		if technique_binary_image(i,j)~=ground_truth(i,j) && ground_truth(i,j)~=0
			false_negatives=false_negatives+1;
		end
		
		if technique_binary_image(i,j)~=ground_truth(i,j) && ground_truth(i,j)==0
			false_positives=false_positives+1;
        end
        if ground_truth(i,j)~=0
            totalClone = totalClone + 1;
        end
        if ground_truth(i,j)==0
            totalNormal = totalNormal + 1;
        end
	end
end

%agora basta calcular as metricas- a acuracia e normalizada
tpr=(true_positives)/totalClone;
fpr=(false_positives)/totalNormal;
acc = (tpr + (1 - fpr))/2;

%matlab nao sabe fazer 0/num, ele retorna sempre NAN, troco NAN por 0
if isnan(tpr)
   tpr=0; 
end

if isnan(fpr)
    fpr=0;
end

if (isnan(acc))
    acc=0;
end

end


