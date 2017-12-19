close all;

vlToolboxLocation = dir('lib/vlfeat/toolbox/vl_setup');
% Bind VL Feat Toolbox to obtain SIFT feature descriptors.
run(vlToolboxLocation);

srcFiles = dir('data/train/*/*.JPEG');

% Since we have 398 source files that are going to be used as trianing data
startIndices = zeros(398, 1);
descriptors = [];
gridId = 1;
mkdir('samples/grids')
for i = 1 : length(srcFiles)
    filename = strcat(srcFiles(i).folder,'/',srcFiles(i).name);
    I = imread(filename);
    resized_Image = imresize(I, [300 300]);
    % figure, imshow(resized_Image);
    [descriptors, startIndices, gridId] = gridify(resized_Image, 50, i, startIndices, descriptors, gridId);
end



%descriptors = double(transpose(descriptors));
descriptors = double(descriptors);

% Save descriptors for future usage.
save('Descriptors', 'descriptors');
save('startIndices', 'startIndices');
    
% Cluster the descriptors matrix.
[Clusters, Codebook] = kmeans(descriptors, 360);

load('pictureCount', 'pictureCount');
objHistogram;
SVM;

edgeler;
testObjHistogram;
prediction;