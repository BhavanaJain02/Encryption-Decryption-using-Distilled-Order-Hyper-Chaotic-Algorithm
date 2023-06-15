I2=imread('Encrypted.png'); 
S2=size(I2); 
M2=S2(1,1); 
N2=S2(1,2); 
Ir2=I2(:,:,1); 
Ig2=I2(:,:,2); 
Ib2=I2(:,:,3); 
IR2=reshape(Ir2,[1,M2*N2]);
IG2=reshape(Ig2,[1,M2*N2]);
IB2=reshape(Ib2,[1,M2*N2]);
%Hyper Chaotic Sequence Generation.
x(1)=0.1;y(1)=0.1;z(1)=-0.1;w(1)=0.1;
%initial conditions 
h=0.005;
%step size
n=M2*N2; al=0.97;
%fractional order. 
cp1=1; cp2=1; cp3=1; cp4=1;

for j=1:n 
    c1(j)=(1-(1+al)/j)*cp1;
    c2(j)=(1-(1+al)/j)*cp2; 
    c3(j)=(1-(1+al)/j)*cp3; 
    c4(j)=(1-(1+al)/j)*cp4;
    cp1=c1(j); cp2=c2(j);
    cp3=c3(j); cp4=c4(j); 
end

for i=2:n
    x(i)=(-z(i-1)-w(i-1))*h^al - memo(x,c1,i);
    y(i)=(2*y(i-1)+z(i-1))*h^al - memo(y,c2,i);
    z(i)=(14*(x(i)-y(i)))*h^al - memo(z,c3,i); 
    g(i-1)=w(i-1)-(abs(w(i-1)-0.4)-abs(w(i-1)-0.8)-abs(w(i-1)+0.4)+abs(w(i-1)+0.8)); 
    w(i)=(100*(x(i)-g(i-1)))*h^al - memo(w,c4,i); 
end

[B21,IY2]=sort(y,'descend');
[B22,IZ2]=sort(z,'descend');
[B23,IW2]=sort(w,'descend'); 
AR2=zeros(1,M2*N2);
AG2=zeros(1,M2*N2);
AB2=zeros(1,M2*N2);
for j=1:M2*N2 
    AR2(IY2(j))=IR2(j); 
    AG2(IZ2(j))=IG2(j); 
    AB2(IW2(j))=IB2(j); 
end 
for i=1:M2*N2 
    selI(i)=mod((abs(x(i))*10e14),6); 
    if selI(i)==1 IR22(i)=AR2(i);
        IG22(i)=AB2(i);
        IB22(i)=AG2(i);
    elseif selI(i)==2
        IR22(i)=AG2(i); 
        IG22(i)=AR2(i);
        IB22(i)=AB2(i);
    elseif selI(i)==3 
        IR22(i)=AB2(i); 
        IG22(i)=AR2(i); 
        IB22(i)=AG2(i); 
    elseif selI(i)==4 
        IR22(i)=AG2(i);
        IG22(i)=AB2(i); 
        IB22(i)=AR2(i); 
    elseif selI(i)==5 
        IR22(i)=AB2(i);
        IG22(i)=AG2(i);
        IB22(i)=AR2(i);

        else IR22(i)=AR2(i);
            IG22(i)=AG2(i);
            IB22(i)=AB2(i);
    end
end

H12=reshape(IR22,[M2,N2]); 
H22=reshape(IG22,[M2,N2]);
H32=reshape(IB22,[M2,N2]);
PA(:,:,1)=H12;
PA(:,:,2)=H22;
PA(:,:,3)=H32; 
imshow(uint8(PA)) 
imwrite(uint8(PA),'Ouput.png')




