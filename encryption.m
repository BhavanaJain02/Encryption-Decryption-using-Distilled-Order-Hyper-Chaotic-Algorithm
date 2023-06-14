clc
I=imread('T.jpg');%type the name of image.
S=size(I);%S stores the size of image or the dimensions eg.(m,n,3).
M=S(1,1)
N=S(1,2)
%Hyper Chaotic Sequence Generation.
x(1)=0.1;
y(1)=0.1;
z(1)=-0.1;
w(1)=0.1;
%initial conditions
h=0.005;
%step size
n=M*N;
al=0.97;
%fractional order.
cp1=1; cp2=1; cp3=1; cp4=1;
%4 binominal cooefficients
for j=1:n
c1(j)=(1-(1+al)/j)*cp1;
c2(j)=(1-(1+al)/j)*cp2;
c3(j)=(1-(1+al)/j)*cp3;
c4(j)=(1-(1+al)/j)*cp4;
cp1=c1(j); cp2=c2(j);
cp3=c3(j); cp4=c4(j);
end
%numerical solutions for the fractional derivatives
for i=2:n
x(i)=(-z(i-1)-w(i-1))*h^al - memo(x,c1,i);
y(i)=(2*y(i-1)+z(i-1))*h^al - memo(y,c2,i);
z(i)=(14*(x(i)-y(i)))*h^al - memo(z,c3,i);
g(i-1)=w(i-1)-(abs(w(i-1)-0.4)-abs(w(i-1)-0.8)-abs(w(i1)+0.4)+abs(w(i-1)+0.8));
w(i)=(100*(x(i)-g(i-1)))*h^al - memo(w,c4,i);
end
% Step 1:
%reshaping the R,G,B matrix obtained from the 3D image matrix into a row
matrix.
Ir=I(:,:,1); Ig=I(:,:,2);
Ib=I(:,:,3);
IR1=reshape(Ir,[1,M*N]);
IG1=reshape(Ig,[1,M*N]);
IB1=reshape(Ib,[1,M*N]);
% Step 2: LocalScrambling
for i=1:M*N
selI(i)=mod((abs(x(i))*10e14),6);
if selI(i)==1
IR(i)=IR1(i);
IG(i)=IB1(i);
IB(i)=IG1(i);
elseif selI(i)==2
IR(i)=IG1(i);
IG(i)=IR1(i);
IB(i)=IB1(i);
elseif selI(i)==3
IR(i)=IG1(i);
IG(i)=IB1(i);
IB(i)=IR1(i);
elseif selI(i)==4
IR(i)=IB1(i);
IG(i)=IR1(i);
IB(i)=IG1(i);
elseif selI(i)==5
IR(i)=IB1(i); IG(i)=IG1(i);
IB(i)=IR1(i);
else
IR(i)=IR1(i);
IG(i)=IG1(i);
IB(i)=IB1(i);
end
end
%Step4
%Sorting y z w in descending order
%IY IZ IW are the indices of the original y z w matrix
[B1,IY]=sort(y,'descend');
[B2,IZ]=sort(z,'descend');
[B3,IW]=sort(w,'descend');
% shuffling IR IG IB matrix as per the indices of the above matrix.
for j=1:M*N
AR(j)=IR(IY(j));
AG(j)=IG(IZ(j));
AB(j)=IB(IW(j)); end
% step 6:
%reshaping the IR IG IB in their original formate M*N
%and making new 3d matrix for the encrypted image
H1=reshape(AR,M,[]);
H2=reshape(AG,M,[]);
H3=reshape(AB,M,[]);
U(:,:,1)=H1;
U(:,:,2)=H2;
U(:,:,3)=H3;
subplot(1,2,2), imshow(U);
subplot(1,2,1),
imshow(I);
