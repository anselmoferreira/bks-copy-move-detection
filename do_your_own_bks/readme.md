
INSTRUCTIONS

This code will build 10 BKS Tables, each one using a 5x2 cross validation training dataset. These will be the 10 classifier models used in the training step.

To run the code, you just need to run demo_table_construction. Then, it will read output images 
from a set of copy-move forgeries classifiers (we used 8 in our work) and build BKS Tables. You need to download the aux folder containing the 5x2 cross validation data, the output images and also the datasets used. Please check the readme in the root folder of this project where you can download the aux data.

If you want to build the BKS tables in your own classifiers you need to change the code to point their location and also run the classifiers in your images. To do the multiscale BKS, we applied the following transformations in the images before running the classifiers on them.

Scale 1:2 	scale1_2= impyramid(image, 'reduce');
Scale 1/4: 	scale1_4= impyramid(scale1_2, 'reduce');

Please e-mail me any problems or suggestions: anselmo.ferreira@gmail.com
