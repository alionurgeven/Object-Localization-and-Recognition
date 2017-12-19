gridCount = 36;

objectHistogram = cell(size(pictureCount, 1),1);
count = 1;
codeVector = zeros(1,360);
for i = 1:size(pictureCount, 1)
   for j = 1:cell2mat(pictureCount(i,2)) 
        for k = 1:gridCount
            codeVector(Codebook(count)) = codeVector(Codebook(count)) + 1;
            count = count + 1;
        end
        objectHistogram{i} = cat(1, objectHistogram{i}, codeVector);
        codeVector = zeros(1,360);
   end
end

