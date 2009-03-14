classdef TwoD

    properties
        data
        mean_estm
        cov_estm
        size
    end

    methods

        function PE= TwoD(sample)
            PE.data=sample;
            
            size=length(sample');
            
            PE.mean_estm = mean(sample);
            
            temp=ones(size,2);
            temp=temp*[PE.mean_estm(1,1),0 ; 0,PE.mean_estm(1,2)];
            
            PE.cov_estm = (PE.data-temp)'*(PE.data-temp)/(size-1)
                
                         
        end

        function plot=plotCluster(PE,colour)
            scatter([1,0]*PE.data',[0,1]*PE.data',colour);
            hold on
            plot=0;
        end

        function [p,x,y]=parametric(PE,res)
            x = [res(1,2):res(1,1):res(1,4)];
            y =[res(1,3):res(1,1):res(1,5)];
            p = zeros(length(x),length(y));
            for i=1:length(x)
                for j=1: length(y)
                    temp=[x(1,i),y(1,j)]-PE.mean_estm;
                    p(i,j)=exp(-temp*(PE.cov_estm)^(-1)*(temp')/2)/(2*pi)/sqrt(det(PE.cov_estm));
                end
            end
        end
        

        function [p,x,y] = parzen(PE, res, win )

            if (size(PE.data,2)>size(PE.data,1))
                PE.data = PE.data';
            end
            if (size(PE.data,2)==2)
                PE.data = [PE.data ones(size(PE.data))];
            end

            numpts = sum(PE.data(:,3));

            dl = min(PE.data(:,1:2));
            dh = max(PE.data(:,1:2));
            if length(res)>1
                dl = [res(2) res(3)];
                dh = [res(4) res(5)];
                res = res(1);
            end

            if (nargin == 2)
                win = 10;
            end
            if (max(dh-dl)/res>1000)
                error('Excessive PE.data range relative to resolution.');
            end

            if length(win)==1
                win = ones(1,win);
            end
            if min(size(win))==1
                win = win(:) * win(:)';
            end
            win = win / (res*res*sum(sum(win)));

            p = zeros(2+(dh(2)-dl(2))/res,2+(dh(1)-dl(1))/res);
            fdl1 = find(PE.data(:,1)>dl(1));
            fdh1 = find(PE.data(fdl1,1)<dh(1));
            fdl2 = find(PE.data(fdl1(fdh1),2)>dl(2));
            fdh2 = find(PE.data(fdl1(fdh1(fdl2)),2)<dh(2));

            for i=fdl1(fdh1(fdl2(fdh2)))'
                j1 = round(1+(PE.data(i,1)-dl(1))/res);
                j2 = round(1+(PE.data(i,2)-dl(2))/res);
                p(j2,j1) = p(j2,j1) + PE.data(i,3);
            end

            p = conv2(p,win,'same')/numpts;
            x = (dl(1):res:(dh(1)+res)); x = x(1:size(p,2));
            y = [dl(2):res:(dh(2)+res)]; y = y(1:size(p,1));

        end
    end
end

