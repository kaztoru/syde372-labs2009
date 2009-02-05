%SYDE 372 Lab 0 - Matlab Introduction
%Feb 2, 2009

clear all % clear all variables from memory
close all % close all open figures
% define the mean and variance of the pdf
NA=200;
muA = [5 10];
sigmaA = [8 0; 0 4];
NB=200;
muB = [10 15];
sigmaB = [8 0; 0 4];
NC=100;
muC = muA;
sigmaC = [8 4; 4 40];
ND=200;
muD = [15 10];
sigmaD = [8 0; 0 8];
NE=150;
muE = [10 5];
sigmaE = [10 -5; -5 20];

cA='red';
cB='blue';
cE='green';
%%
%Part2: Generating Clusters and Unit Stardard Deviation Contour

%cluster generation
YA = clustergen(200,muA,sigmaA);
YB = clustergen(200,muB,sigmaB);
YC = clustergen(100,muC,sigmaC);
YD = clustergen(200,muD,sigmaD);
YE = clustergen(150,muE,sigmaE);

%muAB=[muA;muB];
%muCDE=[muC;muD;muE];
%YAB = [YA YB];

% %calculates the midpoint
% mpAB=muA+(muB-muA)/2;
% %calculates the slope of the bisector
% biAB = (-1)/((muA(2)-muB(2))/(muA(1)-muB(1)));
% %calculates the y-intercept
% bAB=mpAB(2)-(mpAB(1)*biAB);
% %calculates the x-intercept
% xintAB=(-bAB)/biAB;
% %vectorize the x- and y-intercepts
% xintABv=[xintAB 0];
% bABv=[0 bAB];
% 
% %right bisector for CD
% mpCD=muC+(muC+muD)/2;
% biCD=(-1)/((muC(2)-muD(2))/(muC(1)-muD(1)));
% bCD=mpCD(2)-(mpCD(1)*biCD);
% xintCD=(-bCD)/biCD;
% xintCDv=[xintCD 0];
% bCDv=[0 bCD];
% 
% %right bisector for DE
% mpDE=muD-(muD+muE)/2;
% biDE=(-1)/((muD(2)-muE(2))/(muD(1)-muE(1)));
% bDE=mpDE(2)-(mpDE(1)*biDE);
% xintDE=(-bDE)/biDE;
% xintDEv=[xintDE 0];
% bDEv=[0 bDE];

%plot clusters A and B and their unit std dev contours
figure
title('Part 2: A and B Clusters')
plotsample(YA,cA);
hold on
plotsample(YB,cB);
hold on
contourplot(muA,sigmaA);
hold on
contourplot(muB,sigmaB);
xlabel('x_{1}');
ylabel('x_{2}');
axis equal

%plot clusters C, D, and E on a new figure
figure
title('Part 2: C, D, and E Clusters');
plotsample(YC,cA);
hold on
plotsample(YD,cB); 
hold on
plotsample(YE,cE);
hold on
contourplot(muC,sigmaC);
hold on
contourplot(muD,sigmaD);
hold on
contourplot(muE,sigmaE);
hold on
line(xintCDv,bCDv);
hold on
%line(xintDEv,bDEv);
xlabel('x_{1}');
ylabel('x_{2}');
axis equal
%%
%Part 3: classifiers

%input data needed to run this function
Mu1=[5,10];
Mu2=[10,15];
Sigma1=[8 0;0 4];
Sigma2=[8 0;0 4];

R1 = chol(Sigma1);
z1 = repmat(Mu1,200,1) + randn(200,2)*R1;
R2 = chol(Sigma2);
z2 = repmat(Mu2,200,1) + randn(200,2)*R2;

% generate 2-D Grid
Grid_x=(0:0.3:25);
Grid_y=(0:0.3:25);


%classify using MED
MED=zeros(length(Grid_x),length(Grid_y));
figure
title('Part 3: Case 1 - MED Boundary');
for i=1 : length(Grid_x)
    for j=1: length(Grid_y)
        location=[Grid_x(i),Grid_y(j)];%row vector
        if( (location-Mu1)*(location-Mu1)'<(location-Mu2)*(location-Mu2)')
            plot(Grid_x(i),Grid_y(j),'w.');
            hold on;
        else
            plot(Grid_x(i),Grid_y(j),'y.');
            hold on;
        end
    end
end

%classify using GED
GED=zeros(length(Grid_x),length(Grid_y));
figure
title('Part 3: Case 1 - GED Boundary');
for i=1 : length(Grid_x)
    for j=1: length(Grid_y)
        location=[Grid_x(i),Grid_y(j)];%row vector
        if( (location-Mu1)*Sigma1^(-1)*(location-Mu1)'<(location-Mu2)*Sigma2^(-1)*(location-Mu2)')
            plot(Grid_x(i),Grid_y(j),'w.');
            hold on;
        else
            plot(Grid_x(i),Grid_y(j),'y.');
            hold on;
        end
    end
end

%classify using NN
NN=zeros(length(Grid_x),length(Grid_y));
figure
title('Part 3: Case 1 - NN Boundary');
for i=1 : length(Grid_x)
    for j=1: length(Grid_y)
        location=[Grid_x(i),Grid_y(j)]; %row vector
        min1=(location-[z1(1,1) z1(1,2)])*(location-[z1(1,1),z1(1,2)])' ; % initializae min1
        for k=2: ndims(z1)
            if ((location-[z1(k,1),z1(k,2)])*(location-[z1(k,1),z1(k,2)])'<min1)
                min1=(location-[z1(k,1),z1(k,2)])*(location-[z1(k,1),z1(k,2)])';
            end
        end
        
        min2=(location-[z2(1,1),z2(1,2)])*(location-[z2(1,1),z2(1,2)])' ; % initializae min1
        for k=2: ndims(z2)
            if ((location-[z2(k,1),z2(k,2)])*(location-[z2(k,1),z2(k,2)])'<min2)
                min2=(location-[z2(k,1),z2(k,2)])*(location-[z2(k,1),z2(k,2)])';
            end
        end
        % compare the distance, classify based on Minimum Euclean Distance
        if( min1<min2)
            plot(Grid_x(i),Grid_y(j),'w.');
            hold on;
        else
            plot(Grid_x(i),Grid_y(j),'y.');
            hold on;
        end
    end
end
% 
% %classify using 5-NN
% KNN=zeros(length(Grid_x),length(Grid_y));
% for i=1 : length(Grid_x)
%     for j=1: length(Grid_y)
%         location=[Grid_x(i),Grid_y(j)]; %row vector
%         min1=(location-[z1(1,1) z1(1,2)])*(location-[z1(1,1),z1(1,2)])' ; % initializae min1
%         for k=2: ndims(z1)
%             if ((location-[z1(k,1),z1(k,2)])*(location-[z1(k,1),z1(k,2)])'<min1)
%                 min1=(location-[z1(k,1),z1(k,2)])*(location-[z1(k,1),z1(k,2)])';
%             end
%         end
%         
%         min2=(location-[z2(1,1),z2(1,2)])*(location-[z2(1,1),z2(1,2)])' ; % initializae min1
%         for k=2: ndims(z2)
%             if ((location-[z2(k,1),z2(k,2)])*(location-[z2(k,1),z2(k,2)])'<min2)
%                 min2=(location-[z2(k,1),z2(k,2)])*(location-[z2(k,1),z2(k,2)])';
%             end
%         end
%         % compare the distance, classify based on Minimum Euclean Distance
%         if( min1<min2)
%             KNN(i,j)=1;
%         else
%             KNN(i,j)=0.5;
%         end
%     end
% end
% figure
% surf(Grid_x,Grid_y,KNN)

