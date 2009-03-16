load('c:\Documents and Settings\dkadish\workspace\lab2\code\lab2_3.mat')
se = SequentialEstimation({a b});

p_err = cell(20);
for i = 1:20
    conf = se.ConfusionMatrix(i);
    p_err{i} = (conf(1,2) + conf(2,1))*100/sum(sum(conf));
end
