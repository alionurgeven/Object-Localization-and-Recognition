function [ descriptors_test ] = testGridify( image, GridSize, descriptors_test)

[width , heigth ] = size(image);

    for i = 1: width / GridSize
       for j = 1: heigth / GridSize
           % Calculate grid's bounding box.
           x_start = (i-1)*GridSize + 1;
           y_start = (j-1)*GridSize + 1;
           x_end = i*GridSize;
           y_end = j*GridSize;

           % Calculate grid's coordinates.
           x = (x_start + x_end) / 2;
           y = (y_start + y_end) / 2;
           grid = [x; y; GridSize; 0];

           % Calculate its descriptor and concatenate to the matrix.
           [~,d] = vl_sift(image, 'frames', grid);
           descriptors_test = cat(2, descriptors_test, d);
       end
    end
        
end

