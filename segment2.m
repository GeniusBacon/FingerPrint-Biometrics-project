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
    
    % Extract gabor magnitude features from source image. When working with Gabor 
    % filters, it is common to work with the magnitude response of each filter. 
    % Gabor magnitude response is also sometimes referred to as "Gabor Energy". 
    % Each MxN Gabor magnitude output image in gabormag(:,:,ind) is the output 
    % of the corresponding gabor filter g(ind).
    gabormag = imgaborfilt(I,g);
    
    % Post-process the Gabor Magnitude Images into Gabor Features. To use Gabor
    % magnitude responses as features for use in classification, some
    % post-processing is required. This post procesing includes Gaussian
    % smoothing, adding additional spatial information to the feature set,
    % reshaping our feature set to the form expected by the pca and kmeans
    % functions, and normalizing the feature information to a common variance
    % and mean. Each Gabor magnitude image contains some local variations, even
    % within well segmented regions of constant texture. These local variations
    % will throw off the segmentation. We can compensate for these variations
    % using simple Gaussian low-pass filtering to smooth the Gabor magnitude
    % information. We choose a sigma that is matched to the Gabor filter that
    % extracted each feature. We introduce a smoothing term K that controls how
    % much smoothing is applied to the Gabor magnitude responses.
    for i = 1:length(g)
        sigma = 0.5*g(i).Wavelength;
        K = 3;
        gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),K*sigma);
    end
    
    % When constructing Gabor feature sets for classification, it is useful to
    % add a map of spatial location information in both X and Y. This
    % additional information allows the classifier to prefer groupings which
    % are close together spatially.
    X = 1:numCols;
    Y = 1:numRows;
    [X,Y] = meshgrid(X,Y);
    featureSet = cat(3,gabormag,X);
    featureSet = cat(3,featureSet,Y);
    
    % Reshape data into a matrix X of the form expected by the kmeans function.
    % Each pixel in the image grid is a separate datapoint, and each plane in
    % the variable featureSet is a separate feature. In this example, there is
    % a separate feature for each filter in the Gabor filter bank, plus two
    % additional features from the spatial information that was added in the
    % previous step. In total, there are 24 Gabor features and 2 spatial
    % features for each pixel in our input image.
    X = reshape(featureSet,numRows*numCols,[]);
    
    % Normalize features to be zero mean, unit variance.
    X = bsxfun(@minus, X, mean(X));
    X = bsxfun(@rdivide,X,std(X));
    
    % Visualize feature set. To get a sense of what the Gabor magnitude
    % features look like, Principal Component Analysis can be used to move from
    % a 26-D representation of each pixel in the input image into a 1-D
    % intensity value for each pixel.
    coeff = pca(X);
    feature2DImage = reshape(X*coeff(:,1),numRows,numCols);
    
    % Classify Gabor Texture Features using kmeans
    
    % Repeat k-means clustering five times to avoid local minima when searching
    % for means that minimize objective function. The only prior information
    % assumed in this example is how many distinct regions of texture are
    % present in the image being segmented. There are two distinct regions in
    % this case. This part requires the Statistics and Machine Learning Toolbox.
    L = kmeans(X,2,'Replicates',5);
    L = reshape(L,[numRows numCols]);
    Mask = L < 2;
end