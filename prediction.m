fileID = fopen('data/test/bounding_box.txt');
labeled = textscan(fileID, '%s %f %f %f %f', 'Delimiter', ',');

testIm = cell(100, 1);
for i=1:1:10
    x = imread(strcat(['data/test/images/',num2str(i-1)],'.JPEG'));
    x = rgb2gray(x);
    testIm{i} = x;
end

for i=11:1:100
    x = imread(strcat(['data/test/images/',num2str(i-1)],'.JPEG'));
    x = rgb2gray(x);
    testIm{i} = x;
end

cnt = 0;

best_cws = cell(100,1);
prd_acc = cell(10,3);
prd_acc(:,1) = pictureCount(:,1);
prd_acc(:,2) = mat2cell((ones(1,1) .* 10), 1);
prd_acc(:,3) = mat2cell(zeros(1,1),1);

for j = 1:100 % number of images
        temp = ones(10, 1) .* -1;
        if strcmp(labeled{1,1}(j), 'n01615121')
            temp(1) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02099601')
            temp(2) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02123159')
            temp(3) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02129604')
            temp(4) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02317335')
            temp(5) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02391049')
            temp(6) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02410509')
            temp(7) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02422699')
            temp(8) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02481823')
            temp(9) = 1;
        elseif strcmp(labeled{1,1}(j), 'n02504458')
            temp(10) = 1;
        end
        
        testArr = cell2mat(testObjectHistogram{1,j});
        tests = zeros(10, 360);
        for n = 1:10
            tests(n,:) = testArr(1,(n-1)*360+1:(n*360));
        end
        
        flag = 0;
        for k = 1:10
            if flag == 0
                for i = 1:10

                    [labels_predict, accuracy, prob_values] = svmpredict(temp(i), tests(k,:), SVM_model{i});
                    if temp(i) == 1 && temp(i) == labels_predict
                        cnt = cnt + 1;
                        best_cws(j,1) = mat2cell(k,1); 
                        fprintf('Image number %d, candidate window: %d Model no: %d\n', j, k, i);
                        prd_acc(i,3) = mat2cell(cell2mat(prd_acc(i,3)) + 1, 1);
                        flag = 1;
                    end
                end
            else
                break;
            end
        end
        
end
srcFiles = dir('data/test/images/*.JPEG');

for i = 1 : length(srcFiles)
    x = labeled{1,2}(i);
    y = labeled{1,3}(i);
    width = labeled{1,4}(i);
    height = labeled{1,5}(i);
    
    r1 = rectangle('Position', [x y width height]);
    
    model1=load('edges-master/models/forest/modelBsds'); model1=model1.model;
    model1.opts.multiscale=0; model1.opts.sharpen=2; model1.opts.nThreads=4;

    opts = edgeBoxes;
    opts.alpha = .80;     % step size of sliding window search
    opts.beta  = .99;     % nms threshold for object proposals
    opts.minScore = .01;  % min score of boxes to detect
    opts.maxBoxes = 1e4;  % max number of boxes to detect
    
    filename = strcat(srcFiles(j).folder,'/',srcFiles(j).name);
    I = imread(filename);
    bbs1=edgeBoxes(I,model1,opts);
    if ~isempty(best_cws{i,1})
        xcw = best_cws{i,1};
        ycw = best_cws{i,1};
        widthcw = best_cws{i,1};
        heightcw= best_cws{i,1};
        r2 = rectangle('Position', [bbs1(xcw,1) bbs1(ycw,2) bbs1(widthcw,3) bbs1(heightcw,4)]);
        
        intersectionArea = rectint(r1.Position,r2.Position);
        fprintf('For image %d.JPEG Intersection area percentage is: %.2f %%\n' , i, 100 * (intersectionArea / (r1.Position(3) * r1.Position(4))));
    end
    
end
fprintf('Total Accuracy: %d\n', cnt);