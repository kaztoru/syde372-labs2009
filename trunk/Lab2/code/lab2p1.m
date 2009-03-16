clear all
close all
load lab2_1

mua = 5;
sigmaa=1;
ParaA=[mua, sigmaa];
np_sigma1=0.1;
np_sigma2=0.4;

A=OneD(a,ParaA);
A.plotGauss()
A.plotTrue()
A.plotExp()
A.plotTrue()
A.plotUni()
A.plotTrue()
A.plotNPE(np_sigma1)
A.plotTrue()
A.plotNPE(np_sigma2)
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