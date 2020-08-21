This is a working flow about how to use the these functions to get feature from NIR spectrum 
and training the model  

If you already have NIR spectrum, you can ignore the "spec3000" and "spec1000" files. They are specified 
to put two kinds of dataset together, which represent sequence scan order and mix scan order 

At the Beginning, you need use seperate function in split.m to spilt the whole data in training data and 
test data. 

And then according to different feature extraction methods yon can use the function with corresponding name. 
For example if you want use PLS to extract the feature, you can use "pls function" in the "pls.mat"