I1=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s01_CT.tif');
I2=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s01_MRT2.tif');
%dList(i).data = imread( fullfile(imgPath, dList(i).name));
[A1,A2,A3,A4]=dwt2(I1,'Db4');
[B1,B2,B3,B4]=dwt2(I2,'Db4');

        X1=imbilatfilt(A1);
 
        X2=imbilatfilt(B1);
  [m,n]=size(X1);
  X3=X1;
  for i=1:m
      for j=1:n
          X3(i,j)= max(X1(i,j),X2(i,j));
      end
  end
  
  X4= entropy(A2);
  X5= entropy(B2);
  X6=X4;
  [m,n]=size(X4);
  for i=1:m
      for j=1:n
          if X4(i,j)>X5(i,j)
              X6(i,j)=A2(i,j);
          else
              X6(i,j)=B2(i,j);
          end
      end
  end
   X7= entropy(A3);
   X8= entropy(B3);
   X9=X7;
   [m,n]=size(X4);
  for i=1:m
      for j=1:n
          if X7(i,j)>X8(i,j)
              X9(i,j)=A3(i,j);
          else
              X9(i,j)=B3(i,j);
          end
      end
  end
    X10= entropy(A4);
   
    X11= entropy(B4);
    
   X12=X10;
   [m,n]=size(X10);
  for i=1:m
      for j=1:n
          if X10(i,j)>X11(i,j)
              X12(i,j)=A4(i,j);
          else
              X12(i,j)=B4(i,j);
          end
      end
  end
  
  
I3=idwt2(X3,X6,X9,X12,'Db4');
imshow(I3)    

   
   
 
  