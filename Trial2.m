clear;
clc;

%Reading Images
I1=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s01_CT.tif');
I2=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s01_MRT2.tif');



% Wavelet Transform 
[A1,A2,A3,A4]=dwt2(I1,'Db4');
[B1,B2,B3,B4]=dwt2(I2,'Db4');

%Bilateral Filter 
X1=imbilatfilt(A1);
X2=imbilatfilt(B1);

[m,n]=size(X1);
X3=X1;


  for i=1:m
      for j=1:n
          X3(i,j)= max(X1(i,j),X2(i,j));
      end
  end
  X4=[3,3];
  X5=[3,3];
 
 [m,n]=size(A2);
 X6=[m,n];
 for i=1:m-2
     for j=1:n-2
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X4(c,d)=A2(k,l);
             d=d+1;
             end
             c=c+1;
         end
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X5(c,d)=B2(k,l);
             d=d+1;
             end
             c=c+1;
         end
         if entropy(X4)>entropy(X5)
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X6(k,l)=X4(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         else
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X6(k,l)=X5(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         end
     end
 end
  X7=[3,3];
  X8=[3,3];
 
 [m,n]=size(A2);
 X9=[m,n];
 for i=1:m-2
     for j=1:n-2
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X7(c,d)=A3(k,l);
             d=d+1;
             end
             c=c+1;
         end
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X8(c,d)=B3(k,l);
             d=d+1;
             end
             c=c+1;
         end
         if entropy(X4)>entropy(X5)
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X9(k,l)=X7(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         else
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X9(k,l)=X8(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         end
     end
 end
  X10=[3,3];
  X11=[3,3];
 
 [m,n]=size(A2);
 X12=[m,n];
 for i=1:m-2
     for j=1:n-2
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X10(c,d)=A4(k,l);
             d=d+1;
             end
             c=c+1;
         end
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X11(c,d)=B4(k,l);
             d=d+1;
             end
             c=c+1;
         end
         if entropy(X4)>entropy(X5)
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X12(k,l)=X10(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         else
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X12(k,l)=X11(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         end
     end
 end
     
 % Inverse Wavelet Transform 
I3=idwt2(X3,X6,X9,X12,'Db4');
imshow(I1);
title('First Image')
figure,imshow(I2)
title('Second Image')
figure,imshow(I3,[])
title('Fused Image')


% Performance Criteria

CR1=corr2(I1,I3);
CR2=corr2(I2,I3);
S1=ssim(double(I1),(I3));
S2=ssim(double(I2),(I3));
fprintf('Correlation between first image and fused image =%f \n\n',CR1);
fprintf('Correlation between second image and fused image =%f \n\n',CR2);
fprintf('SSIM between first image and fused image =%4.2f db\n\n',S1);
fprintf('SSIM between second image and fused image =%4.2f db \n\n',S2);

   
   
 
  