
INSTRUCTIONS

This code will build 10 BKS Tables, each one using a 5x2 cross validation training dataset. These will be the 10 classifier models used in the training step.

To run the code, you just need to run demo_table_construction. Then, it will read output images 
from a set of copy-move forgeries classifiers (we used 8 in our work) and build BKS Tables. You need to download the aux folder containing the 5x2 cross validation data, the output images and also the datasets used. Please check the readme in the root folder of this project where you can download the aux data.

If you want to build the BKS tables in your own combination of classifiers, you need to run the classifiers in your images and also change the code to point the location of the output images. To do the multiscale BKS, we applied the following transformations in the images before running the classifiers on them:

Scale 1:2 	scale1_2= impyramid(image, 'reduce');

Scale 1/4: 	scale1_4= impyramid(scale1_2, 'reduce');

After you build the BKS Tables, you need to apply the Random forests and Support Vector Regression on them. For this, we have two R scripts: GridSearch_rf.R and GridSearch_svr.R. Please create a folder called bks_new_tables and subfolders called svr and rf to make the code run OK. If you want to use them to test images, please take a look in our paper what are the parameters (c,g) and (nt,mry) of support vector regression and random forests used for compressed and uncompressed images.

Please e-mail me any problems or suggestions: anselmo.ferreira@gmail.com

