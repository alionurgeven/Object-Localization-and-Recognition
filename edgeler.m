model=load('edges-master/models/forest/modelBsds'); model=model.model;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;

opts = edgeBoxes;
opts.alpha = .80;     % step size of sliding window search
opts.beta  = .99;     % nms threshold for object proposals
opts.minScore = .01;  % min score of boxes to detect
opts.maxBoxes = 1e4;  % max number of boxes to detect

descriptors_test = [];
srcFiles = dir('data/test/images/*.JPEG');

for j = 1 : length(srcFiles)
    filename = strcat(srcFiles(j).folder,'/',srcFiles(j).name);
    I = imread(filename);
    bbs=edgeBoxes(I,model,opts);
    
    for i = 1:10
        grid = [bbs(i,1) bbs(i,2) bbs(i,3) bbs(i,4)];
        
        img = imresize(imcrop(I, grid), [300 300]);
        img = single(rgb2gray(img));
        [descriptors_test] = testGridify(img, 50, descriptors_test);
       
    end
    bbs = [];
end

descriptors_test = double(descriptors_test);
[TestClusters, TestCodebook] = kmeans(descriptors_test, 360);



