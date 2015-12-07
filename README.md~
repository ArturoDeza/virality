
## Understanding Image Virality Documentation
Created by Arturo Deza. April,2015a

pair_matrix.mat: Contains all the viral and non viral images randomly paired as described in Section 3.3.1 of the paper. It is a [5039x2] matrix where the left column has the viral image id, and the right column has the non viral image id.

virality_label.mat: Contains the pair order as shown on AMT for image annotation. We wanted to randomize viral and non viral images on left and right so that the annotations
were counter-balanced.
{1} represents the viral image on the left and the non viral image on the right.
{0} represents the viral image on the right and the non viral image on the left.

Attribute_matrix.mat: Contains all relative attributes annotated for all the previously mentioned pairs. 
{+1} represents that the image on the left has 'more' of an attribute than the image on the right.
{0} represents that the image on the left has 'equal' of an attribute than the image on the right.
{-1} represents that the image on the left has 'less' of an attribute than the image on the right.

Top_489_pair.mat: Contains the 500p dataset which consists of 489 unique pairs used for testing.

viral_decaf6_feats.mat: Contains all the DECAF6 features computed for the 10078 images in the dataset. The img_id maps to the row of the matrix that has the image feature. DECAF6 features are 4096 dimensional.


### Attribute And Virality Prediction 


 To predict virality you will have to create a different folder for every attribute you want to use. The SVM should output a +1,0,-1 label for every image pair after training.
 If you are using libsvm, you can use the class_hat to know the predicted output for each attribute, and you can write an additional script that will load all of these and
 combined them. You also ideally want to use the kernel that maximizes performance (grid search on C and G parameters from 10^-5 to 10^5). 
 Combinining attributes is simply a sum of the labels, where a positive value means that virality was correctly predicted, and a negative label means it was
 incorrectly predicted. Ties were removed by selecting a random positive/negative outcome and running the classifier 100 times, to later compute average performance. Notice
 however that ties need not to be removed for future applications, we had to do such process since our ground truth was a virality score that presented no equal values (one
 image was always more viral than another one in our dataset, and there weren't any ties).


### Other reminders 


You will need to know the virality_label of each pair to train your SVM with correct labels for every label.
Moreoever, we create the relative features by always subtracting the nonviral descriptor from the viral descriptor, hence saving each relative feature with the id of the viral image.


### Download DECAF6 features:
http://brie.uchicago.edu/ftp-www/Viral_total/viral_decaf6_feats.mat

### ArXiv paper pre-print:
http://arxiv.org/abs/1503.02318

### Virality Project Website
http://arturodeza.github.io/virality/

### BibTex Citation

    @inproceedings{deza2015virality, Author = {Arturo Deza and Devi Parikh}, 
    Title = {Understanding Image Virality}, 
    Year = {2015}, 
    booktitle = {IEEE Conference on Computer Vision and Pattern Recognition (CVPR)} }

### License

Redistribution and reuse is allowed under the simplified BSD license.

    Copyright (c) 2015, Arturo Deza
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:
    
    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
    
    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation and/or other
    materials provided with the distribution.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
    MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
    THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
    OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
    IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
    IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
    SUCH DAMAGE.
