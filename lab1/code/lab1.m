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

%%
%Part 4: testing

% generate testing data
TA=clustergen(200,muA,sigmaA);
TB=clustergen(200,muB,sigmaB);
confu_matrix=zeros(2,2);
%%
%testing both class using MED
for i=1 : length(TA)
        location=[TA(i,1),TA(i,2)];%row vector
        if( (location-muA)*(location-muA)'<(location-muB)*(location-muB)')
            confu_matrix(1,1)=confu_matrix(1,1)+1;
        else
            confu_matrix(1,2)=confu_matrix(1,2)+1;
        end
end
for i=1 : length(TB)
        location=[TB(i,1),TB(i,2)];%row vector
        if( (location-muA)*(location-muA)'<(location-muB)*(location-muB)')
            confu_matrix(2,1)=confu_matrix(2,1)+1;
        else
            confu_matrix(2,2)=confu_matrix(2,2)+1;
        end
end
%calculate error
confu_matrix
err_MED=(confu_matrix(1,2)+confu_matrix(2,1))/([1,1]*confu_matrix*[1 1]')
confu_matrix=zeros(2,2);

%%
%testing using GED
for i=1 : length(TA)
        location=[TA(i,1),TA(i,2)];%row vector
        if( (location-muA)*sigmaA^(-1)*(location-muA)'<(location-muB)*sigmaB^(-1)*(location-muB)')
            confu_matrix(1,1)=confu_matrix(1,1)+1;
        else
            confu_matrix(1,2)=confu_matrix(1,2)+1;
        end
end

for i=1 : length(TB)
        location=[TB(i,1),TB(i,2)];%row vector
        if( (location-muA)*sigmaA^(-1)*(location-muA)'<(location-muB)*sigmaB^(-1)*(location-muB)')
            confu_matrix(2,1)=confu_matrix(2,1)+1;
        else
            confu_matrix(2,2)=confu_matrix(2,2)+1;
        end
end
%calculate error
confu_matrix
err_GED=(confu_matrix(1,2)+confu_matrix(2,1))/([1,1]*confu_matrix*[1 1]')
confu_matrix=zeros(2,2);

%%      
%testing using KNN
KNNA=zeros(length(YA),1);
KNNB=zeros(length(YB),1);
location=[0 0];
copy=ones(length(YA),2);
squareA=ones(length(YA),length(YA));
squareB=ones(length(YB),length(YB));
distanceA=ones(length(YA),1);
distanceB=ones(length(YB),1);
sorted_disA=ones(length(YA),1);
sorted_disB=ones(length(YB),1);

% for Data generated in Class A
for i=1 : length(TA)
        location=[TA(i,1),TA(i,2)];   % a row vector indicating the location of the point that needs to be classified\
        copy=ones(length(YA),1)*location;        % a N*2 Vector that contains copies of "locations", so that it is easier to compute       
        squareA=(copy-YA)*(copy-YA)' ;   % N*N vector whose diagonals represent the distances between a location to the sample data
        for k=1: length(YA)
            distanceA(k,1)=squareA(k,k);% distance is a N*1 vector containing distance from one data to all sample data
        end
        sorted_disA=sort(distanceA);
        KNNA=sorted_disA(5,1); % pick the 5th nearest point
        %repeat for class 2
        squareB=(copy-YB)*(copy-YB)' ;   
        for k=1: length(YB)
            distanceB(k,1)=squareB(k,k);
        end
        sorted_disB=sort(distanceB);
        KNNB=sorted_disB(5,1);
        %compare and make decision
        if( KNNA<KNNB)
            confu_matrix(1,1)=confu_matrix(1,1)+1;
        else
            confu_matrix(1,2)=confu_matrix(1,2)+1;
        end
end

% for Data generated in Class B
for i=1 : length(TB)
        location=[TB(i,1),TB(i,2)];   % a row vector indicating the location of the point that needs to be classified\
        copy=ones(length(YA),1)*location;        % a N*2 Vector that contains copies of "locations", so that it is easier to compute       
        squareA=(copy-YA)*(copy-YA)' ;   % N*N vector whose diagonals represent the distances between a location to the sample data
        for k=1: length(YA)
            distanceA(k,1)=squareA(k,k);% distance is a N*1 vector containing distance from one data to all sample data
        end
        sorted_disA=sort(distanceA);
        KNNA=sorted_disA(5,1); % pick the 5th nearest point
        %repeat for class 2
        squareB=(copy-YB)*(copy-YB)' ;   
        for k=1: length(YB)
            distanceB(k,1)=squareB(k,k);
        end
        sorted_disB=sort(distanceB);
        KNNB=sorted_disB(5,1);
        %compare and make decision
        if( KNNA<KNNB)
            confu_matrix(2,1)=confu_matrix(2,1)+1;
        else
            confu_matrix(2,2)=confu_matrix(2,2)+1;
        end
end
%calculate error
confu_matrix
err_KNN=(confu_matrix(1,2)+confu_matrix(2,1))/([1,1]*confu_matrix*[1 1]')