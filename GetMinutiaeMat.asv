function Minutiae  = GetMinutiaeMat(Fingerprint)

    %Image Preprocessing
    [EnhancedImg,Direction,freq]=ImgPreprocessing(Fingerprint);
    
  
    
    %Feature Extraction
    [bifurcationX,bifurcationY,bifurcationOrientation,ridgeX,ridgeY,RidgeOrientation]  =FeatureExtraction(EnhancedImg,Direction,freq);
    bifurcationSize=size(bifurcationX,1);
    ridgeSize=size(ridgeX,1);
    Minutiae=zeros(bifurcationSize+ridgeSize,4);
    for i=1:bifurcationSize
    Minutiae(i,1)=bifurcationX(i);
    Minutiae(i,2)=bifurcationY(i);
    Minutiae(i,3)=3;
    Minutiae(i,4)=bifurcationOrientation(i);
    end
        count=1;
    for j=i+1:i+ridgeSize
    Minutiae(j,1)=ridgeX(count);
    Minutiae(j,2)=ridgeY(count);
    Minutiae(j,3)=1;
    Minutiae(j,4)=RidgeOrientation(count);
    count=count+1;
    end 
    
    
    
end