classdef NonParametricEstimation
    
    properties
        sample
    end
    
    methods
        
        function NPE = NonParametricEstimation(sample)
            NPE.sample = sample;
        end
        
        function plotNPE(NPE, sigma)
            N=length(NPE.sample);
            figure;
            for x=0:0.1:10
                p=0;
                for i=1:N
                    xi=NPE.sample(i);
                    phi=exp(-((x-xi)^2)/(2*(sigma)^2))/(sqrt(2*pi)*sigma);
                    p=p+phi;
                end
                plot(x,p)
                hold on
            end
        end
    end
end
