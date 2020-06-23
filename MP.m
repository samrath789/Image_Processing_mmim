I1=imread('2.jpg');
I2=imread('4.jpg');
[A1,A2,A3,A4]=dwt2(I1,'Db4');
[B1,B2,B3,B4]=dwt2(I2,'Db4');

[m,n]=size(A1)
for i=1:m
    for j=1:n
        x1=imbilatfilt(A1)
    end
end
[m,n]=size(A1)
for i=1:m
    for j=1:n
        x2=imbilatfilt(A2)
    end
end



