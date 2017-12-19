addpath(genpath('lib/libsvm/'))

SVM_model = cell(10, 1);
objLabels = cell(10, 1);

for i = 1:size(objLabels)
   objLabels{i,1} = ones(398, 1) .* -1;
end

instance_mtrx = zeros(398, 360);
cnt = 1;
for i = 1:size(objectHistogram)
    currentCell = objectHistogram{i, 1};
    for j = 1:size(currentCell, 1)
        instance_mtrx(cnt, :) = currentCell(j, :);
        objLabels{i}(cnt, 1) = 1;
        cnt = cnt + 1;
    end
end

for i = 1 : 10
    SVM_model{i, 1} = svmtrain(objLabels{i,1}, instance_mtrx, '-t 0 -b 0'); 
end
