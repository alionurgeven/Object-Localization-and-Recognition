gridCount = 36;

testObjectHistogram = cell(1, 1);

for i = 1:100
    testObjectHistogram{i} = cell(1, 10);
end

count = 1;
testCodeVector = zeros(1,360);
for i = 1:100 % number of test images
   for j = 1:10 % number of candidate windows 
        for k = 1:gridCount
            testCodeVector(TestCodebook(count)) = testCodeVector(TestCodebook(count)) + 1;
            count = count + 1;
        end
        testObjectHistogram{i}{j} = cat(1, testObjectHistogram{i}{j}, testCodeVector);
        testCodeVector = zeros(1,360);
   end
end

