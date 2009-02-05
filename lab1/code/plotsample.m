function Z = plotsample(Y,c)
Y_1=Y*[1;0];
Y_2=Y*[0;1];
scatter(Y_1, Y_2,5,c)
Z=1;