function [c, conf, PE] = getMCID(f,ft)
    %initialize internal variables
    mu=zeros(2,10);
    sigma=zeros(2,20);
    count=0;
    j=1;    
    testdata=ft(1:2,:);
    truth=ft(3,:);
    c=99*ones(160,1);
    conf=zeros(10);
    dist=Inf;
    %calculate the mean and variance of the learning data set
    while j <= 160
        m1=0;
        m2=0;
        %calculate the mean of the 16 data points in cluster count
        for i=1:16
            m1=m1+f(1,j);
            m2=m2+f(2,j);
            j=j+1;
        end
        m1=m1./16;
        m2=m2./16;
        %calculate the mean of the same 16 data points
        temp=f(1:2,(count*16+1):(count*16+16)); %selects a single cluster 
        v=cov(temp'); 
        sigma(:,2*count+1:2*count+2)=v; %creates a matrix of covar matrices
        count=count+1;
        %builds the mu matrix one cluster at a time
        mu(1,count)=m1; 
        mu(2,count)=m2;
    end
    %classify each test data point and construct the confusion matrix
    for i=1:160
        d=Inf;
        for j=0:9
            x=testdata(:,i);
            dist=(x-mu(:,j+1))'*sigma(:,(2*j+1):(2*j+2))^(-1)*(x-mu(:,j+1));
            if dist < d
                c(i)=j+1;
                d=dist;
            end
        end
        conf(truth(i),c(i))=conf(truth(i),c(i))+1;
    end
    %calculate error probabilities
    img=zeros(10,1);
    for i=1:10
        img(i)=(sum(conf(i,:))-conf(i,i))/sum(conf(i,:))*100;
    end
    img
    nt=sum(diag(conf));
    ne=sum(sum(conf))-sum(diag(conf));
    PE=ne/(nt+ne)*100;
end

