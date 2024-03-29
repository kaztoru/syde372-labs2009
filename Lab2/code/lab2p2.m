%lab2p2
close all
clear all
load lab2_2


%create a 2-D Gaussian matrix for non-parametric case
increment=1;
max=60;
min=-60;
x=[min:increment:max];
n=length(x);
y=zeros(1,n);
for i=1:n
    y(i)=exp(-x(i)^2/2/400)/sqrt(2*pi)/20;
end
matrix=y'*y;


%specify range of matrix
res=[1,0,0,450,450];

a=TwoD(al);
b=TwoD(bl);
c=TwoD(cl);

%%nonparametric method(parzen)

[ap,ax,ay]=a.parzen(res,matrix);
[bp,bx,by]=b.parzen(res,matrix);
[cp,cx,cy]=c.parzen(res,matrix);

%Apply ML for classification

ML=ML(ap,bp,cp);

%plot contour
figure;
contour(cx,cy,ML)
hold on
%plot clusters
a.plotCluster('bd');
b.plotCluster('g+');
c.plotCluster('r*');

%parametric method
[ap,ax,ay]=a.parametric(res);
[bp,bx,by]=b.parametric(res);
[cp,cx,cy]=c.parametric(res);
ML=ML(ap,bp,cp);

figure;
contour(cx,cy,ML);
hold on
a.plotCluster('bd');
b.plotCluster('g+');
c.plotCluster('r*');