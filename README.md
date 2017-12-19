# Project Title

The aim of this project is to figure out the class of the object in an image within giving the boundaries of where the object is located in the image. There are 398 training images and 100 labeled test images

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

LIBSVM is required for creating the machine learning model.
Can be found here: https://www.csie.ntu.edu.tw/~cjlin/libsvm/


## Authors

* **Ali Onur Geven** - *Initial work* - https://github.com/alonge
* **Alp Güvenir** - *Initial work* - https://github.com/alpguvenir

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
First of all, the scale variety of the training images was a challenge in order to extract useful features. We have overcome this problem by resizing the images and using SIFT which is a scale invariant feature detection algorithm.  
 
In order to create a bag-of-visual-words model we have generated a codebook by applying kmeans clustering algorithm to the detectors returned from SIFT.  
 
Furthermore we have modeled 10 different SVM models in order to overcome the challenge of multivariable SVM with binary SVM. 
 
However the training images where tightly cropped around the interest object whereas the test images where not. Therefore we have overcome this problem by extracting the candidate windows for each image. 
 
Then in order to classify the images more accurately we generated bag-of-visual-words for each candidate window. With using the bag-of-visual-words we have extracted object histograms of the candidate windows of the test images. Furthermore we have predicted the candidate window label by using 10 different SVM models trained before hand. By selecting the most accurate candidate window we have also predicted the label of respective test image. Also with using the most accurate candidate window we tried to localize the object by bounding boxes. 
 
 In total we have predicted 38 out of 100 test images correctly. During this process the bounding boxes generated using the ready code where approximately 40%-50% consistent in detecting the interest object intersection area. This has generally caused our precision of classification to be poor. 

