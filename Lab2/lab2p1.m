clear all
close all
load lab2_1

mua = 5;
sigmaa=1;
ParaA=[mua, sigmaa];

A=ParametricEstimation(a,ParaA)
A.plotGauss()
A.plotTrue()
A.plotExp()
A.plotTrue()
A.plotUni()
A.plotTrue()

clear
load lab2_1

lamdab=1;
B=ParametricEstimation(b,lamdab)
B.plotGauss()
B.plotTrue()
B.plotExp()
B.plotTrue()
B.plotUni()
B.plotTrue()



