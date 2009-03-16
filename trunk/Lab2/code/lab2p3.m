load('c:\Documents and Settings\dkadish\workspace\lab2\code\lab2_3.mat')
se = SequentialEstimation({a b});

p_err = zeros(5,20);
for i = 1:5
    for j = 1:20
        conf = se.ConfusionMatrix(i);
        p_err(i,j) = (conf(1,2) + conf(2,1))*100/sum(sum(conf));
    end
end
