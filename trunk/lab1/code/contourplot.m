function Y = contourplot(Mu, Sig)
x1 = [-4:0.3:14];
x2 = [1:0.3:19];

lb1=Mu(1) - sqrt(Sig(1,1));
ub1=Mu(1) + sqrt(Sig(1,1));
lb2=Mu(2) - sqrt(Sig(2,2));
ub2=Mu(2) + sqrt(Sig(2,2));

x=Mu(1);
y=Mu(2);

[V,D]=eig(Sig)

rta=sqrt(D(1,1))
rtc=sqrt(D(2,2))

theta=atan(V(2,1)/V(1,1));

% This routine plots an ellipse with centre (x,y), axis lengths rta,rtc
% with major axis at an angle of theta radians from the horizontal.
plot_ellipse(x,y,theta,rta,rtc);

%this was how we had the plots made originally but they didn't seem to line
%up where they should
%y1 = Gauss2D(x1,x2,Mu,Sig);
%contour(x1,x2,y1,1)
%Y=1;

