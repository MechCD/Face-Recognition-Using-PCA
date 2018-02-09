%reading training images and assigning a label to each training image
training_images=dir('train_images\*.jpg');
Lt=[];
T=[];

for k = 1 : length(training_images)
    
 ImgName = training_images(k).name;
  Lt=[Lt ; ImgName(:,1:3)];
  ImgName = char(strcat('train_images\',ImgName(1:end-4)));

 GRAYIm = imread(ImgName, 'jpg');
 Img=reshape(GRAYIm,1,64*64);
 T=[T ; Img]; 
end

%subtract off the mean for each dimension
mT=mean(T,2);%mean of rows
D=double(T)-repmat(mT,1,size(T,2));

%covariance matrix
sigma=(1/(length(training_images)-1))*D*(D');


%eigenvalues and eigenvectors
[V,DD]=eigs(sigma,length(training_images)-2);


phay=D'*V;




Ft=[];
for k = 1 : length(training_images)
                                    
 ImgName = training_images(k).name;
  ImgName = char(strcat('train_images\',ImgName(1:end-4)));
 GRAYIm = imread(ImgName, 'jpg');
 Img=reshape(GRAYIm,1,64*64);
 recon=double(Img)*phay;
 Ft=[Ft;recon];
end

%reading test images
Wt=[];
e=0;
test_images=dir('test_images\*.jpg');
for k = 1 : length(test_images)
    
 ImgName = test_images(k).name;
  ImgName = char(strcat('test_images\',ImgName(1:end-4)));
 Wt=[Wt ; ImgName(:,13:15)];
 GRAYIm = imread(ImgName, 'jpg');
 
 
  H=reshape(GRAYIm,1,64*64);
 rec=double(H)*phay; 
 

for k=1:length(training_images)
    x(k)=norm(rec-Ft(k,:));
end

[a z]=min(x);

if Lt(z,1:end)~=ImgName(:,13:15)
 e=e+1;

end

end
accuracy=(1-(e/length(test_images)))*100



H=imread('C:\Users\mohitkumarahuja\Desktop\PCA Project\Normalization zain\test_images\Mohit1','jpg');


  H=reshape(H,1,64*64);
 rec=double(H)*phay; 
 
 x(1)=norm(rec-Ft(1:(length(training_images)-2)));

for k=2:length(training_images)
    x(k)=norm(rec-Ft(((k-1)*(length(training_images)-2))+1:((k-1)*(length(training_images)-2))+(length(training_images)-2)));
end

[a z]=min(x);
[b g]=sort(x);
z
Lt(z,1:end)
% tttttt=reshape(H,64,64);
% imshow(tttttt)
% size(tttttt)
 g(2)
 Lt(g(2),1:end)
g(3)
 Lt(g(3),1:end)

