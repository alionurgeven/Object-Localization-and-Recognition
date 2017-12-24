function [ descriptors, startIndices, gridId ] = gridify( IM, GridSize, imageNum, startIndices, descriptors, gridId)
colored = IM;
image = single(rgb2gray(IM));

[width , heigth ] = size(image);

startIndices(imageNum) = gridId;

    for i = 1: width / GridSize
       for j = 1: heigth / GridSize
           % Calculate a grid's bounding box.
           x_start = (i-1)*GridSize + 1;
           y_start = (j-1)*GridSize + 1;
           x_end = i*GridSize;
           y_end = j*GridSize;

           % Extract grid/feature image and save.
           gridImage = colored(y_start:y_end, x_start:x_end, :);
           filename = strcat('samples/grids/', int2str(gridId), '.png');
           imwrite(gridImage, filename);
           gridId = gridId + 1;

           % Calculate grid's coordinates.
           x = (x_start + x_end) / 2;
           y = (y_start + y_end) / 2;
           grid = [x; y; GridSize; 0];

           % Calculate its descriptor and concatenate to the matrix.
           [~,d] = vl_sift(image, 'frames', grid);
           descriptors = cat(2, descriptors, d);
       end
    end

end
