clear
close all
load feat.mat

%obtain the MCID classifier for each data set
[c2,conf2,PE2]=getMCID(f2, f2t)
[c8,conf8,PE8]=getMCID(f8, f8t)
[c32,conf32,PE32]=getMCID(f32, f32t)
