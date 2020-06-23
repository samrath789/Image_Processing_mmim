clear;
clc;


%Reading Images
I1=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s04_CT.tif');
I2=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s04_MRT2.tif');


% Wavelet Transform 
[a1,b1,c1,d1]=dwt2(I1,'db2');
[a2,b2,c2,d2]=dwt2(I2,'db2');
[k1,k2]=size(a1);


% Fusion Rules
% Average Rule
for i=1:k1
    for j=1:k2
        a3(i,j)=(a1(i,j)+a2(i,j))/2;
   end
end



% Max Rule
for i=1:k1
    for j=1:k2
        b3(i,j)=max(b1(i,j),b2(i,j));
        c3(i,j)=max(c1(i,j),c2(i,j));
        d3(i,j)=max(d1(i,j),d2(i,j));
    end
end



% Inverse Wavelet Transform 
c=idwt2(a3,b3,c3,d3,'db2');
imshow(I1)
title('First Image')
figure,imshow(I2)
title('Second Image')
figure,imshow(c,[])
title('Fused Image')



% Performance Criteria
CR1=corr2(I1,c);
CR2=corr2(I2,c);
S1=ssim(double(I1),double(c));
S2=ssim(double(I2),double(c));
fprintf('Correlation between first image and fused image =%f \n\n',CR1);
fprintf('Correlation between second image and fused image =%f \n\n',CR2);
fprintf('SSIM between first image and fused image =%4.2f db\n\n',S1);
fprintf('SSIM between second image and fused image =%4.2f db \n\n',S2);

