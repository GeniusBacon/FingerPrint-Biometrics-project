function [ feature2DImage, Mask] = segmentTexture(I)
    imageSize = size(I);
    numRows = imageSize(1);
    numCols = imageSize(2);
    
    wavelengthMin = 4/sqrt(2);
    wavelengthMax = hypot(numRows,numCols);
    n = floor(log2(wavelengthMax/wavelengthMin));
    wavelength = 2.^(0:(n-2)) * wavelengthMin;
    
    deltaTheta = 45;
    orientation = 0:deltaTheta:(180-deltaTheta);
   g = gabor(wavelength,orientation);
    gabormag = imgaborfilt(I,g);
    
    for i = 1:length(g)
        sigma = 0.5*g(i).Wavelength;
        K = 3;
        gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),K*sigma);
    end
    X = 1:numCols;
    Y = 1:numRows;
    [X,Y] = meshgrid(X,Y);
    featureSet = cat(3,gabormag,X);
    featureSet = cat(3,featureSet,Y);
    
    % Reshape data into a matrix X of the form expected by the kmeans function.
    X = reshape(featureSet,numRows*numCols,[]);
    
    % Normalize features to be zero mean, unit variance.
    X = bsxfun(@minus, X, mean(X));
    X = bsxfun(@rdivide,X,std(X));
    
    % Visualize feature set.
    coeff = pca(X);
    feature2DImage = reshape(X*coeff(:,1),numRows,numCols);
    
    % Classify Gabor Texture Features using kmeans
    
    % Repeat k-means clustering five times to avoid local minima when searching
    % for means that minimize objective function.
    L = kmeans(X,2,'Replicates',5);
    L = reshape(L,[numRows numCols]);
    Mask = L < 2;
end