% MICD-classifier for

%a. learn the mean and variance in each of the 10 classes in the training data set

function table= MICD(data_test,data_train)

clc
load feat.mat

means=ones(2,1)
cov=[0 0;0 0]
z=zeros(2,10)
s=zeros(2,20)

for i= 0:9
    means=[0;0];
    cov=[0 0;0 0];
    
    for j=1:16
        means=means+[data_train(1,(i*10+j));data_train(2,(i*10+j))];
    end
    z(1,i+1)=means(1,1)/16;
    z(2,i+1)=means(2,1)/16;
    
    for j=1:16
        cov=cov+([data_train(1,(i*10+j));data_train(2,(i*10+j))]-means)*([data_train(1,(i*10+j));data_train(2,(i*10+j))]-means)';
    end
    s(1,2*i+1)=cov(1,1)/16;
    s(1,2*i+2)=cov(1,2)/16;
    s(2,2*i+1)=cov(1,2)/16;
    s(2,2*i+2)=cov(2,2)/16;
end

% b. do the classification for the testing data set by returning a row of
% calssified class number

index=0;
d=100000;
x=zeros(2,1);
row=size(data_test)(1,1)
column=size(data_test)(1,2)
table=zeros(row,column);
for j=1:row
    for k=1:column
        x=[data_test(i,j,1),data_test(i,j,2)];
        for i=1:10
            if(d>(x-[z(1,i);z(2,i)])'*[s(1,2*i+1),s(1,2*i+2);s(2,2*i+1),s(2,2*i+2)]=c)
                d=c;
                index=i;
            end
        end
        table(j,k)=char('A'+index-1);
    end
end

end


% if(dim(data_test)=2)
%     row=size(data_test)(1,1)
%     column=size(data_test)(1,2)
% end
% else
%     if(dim(data_test)=3)
%     end