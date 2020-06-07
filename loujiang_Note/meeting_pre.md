# the Progress of the project
## the Image capture:
+ the old method is week in: the dark edge of the image to detection
+ try some new method -- go through all the old dataset and pick out some hard pictures --- with the old method the wrong part are consisting in the part of the colored package of the food --- also meet the wrong concentration of the model we have now.
+ Problem: there is no best solution for all, but some optimal solution for part.
1. method now is good for the edge detection for the colored package, but it will include some background into the selected part 
2. another method is good for all kind of the picture but have the problem: if the object is catted of by the edge, the detection will be catastrophic. also when the object to small is--- which the light area fo the picture at the right top and button edge is bigger --- detect the wrong area.
## the feature selection
the correlation of the features(old) is made and get the matrix of the correlation --- some are highly correlated! 
manually select some features into the classifier leaner, the result is: all kind of svm and knn are having the same result now, around 60 -70, which we though it has get rid of the overfitting situation, the features are balanced. and the other wrong can be concluded tot the wrong pick of the picture image.
## the NIR data:
read through the NIR data, the NIR data is finding a model of 224 coefficients to predict the 225 result. however, how the 72 records are from and how to interpret the 255 result: the percentage of the kaolin?
## the direct learning of the picture:
failed -- no background knowledge of the model we used, the picture size, the information and background ratio,....