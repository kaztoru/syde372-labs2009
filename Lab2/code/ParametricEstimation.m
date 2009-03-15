classdef ParametricEstimation
    
    properties
        Mu
        Sigma
        Lamda
        a
        b
        TrueMu
        TrueSigma
        TrueLamda
    end
    
    methods
        
        function PE = ParametricEstimation(sample,para)
            if(length(para)==2)
                PE.TrueMu=para*[1,0]';
                PE.TrueSigma=para*[0,1]';
                PE.TrueLamda=0;
            else
                PE.TrueLamda=para;
            end
            R=size(sample);
            N=R*[0;1];
            PE.Mu = (sample*ones(N,1))/N;
            PE.Sigma = sqrt((sample-(PE.Mu*ones(1,N)))*(sample-(PE.Mu*ones(1,N)))'/N);
            PE.Lamda = N/(sample*ones(N,1));
            PE.a = min(sample);
            PE.b = max(sample);
        end
        
        function Gaussian = plotGauss(PE)
            figure;
            Y = normpdf(
%             for x=PE.Mu-5*PE.Sigma:0.01:PE.Mu+5*PE.Sigma
%                 p=exp(-(x-PE.Mu)^2/(2*(PE.Sigma)^2)/sqrt(2*pi*PE.Sigma));
%                 plot(x,p)
%                 hold on
%             end
        end

        function Exponential = plotExp(PE)
            figure; 
            for x=PE.Mu-5*PE.Sigma:0.01:PE.Mu+5*PE.Sigma
                p=PE.Lamda*exp(-PE.Lamda*x);
                plot(x,p)
                hold on
             end
        end
        
        function Uniform = plotUni(PE)
            figure; 
            for x=PE.Mu-5*PE.Sigma:0.01:PE.Mu+5*PE.Sigma
                p=1/(PE.b-PE.a);
                plot(x,p)
                hold on
             end
        end
        
        function T = plotTrue(PE)
            if (PE.TrueLamda == 0)
                for x=PE.TrueMu-5*PE.TrueSigma:0.01:PE.TrueMu+5*PE.TrueSigma
                    p=exp(-(x-PE.TrueMu)^2/(2*PE.TrueSigma)^2)/sqrt(2*pi*PE.TrueSigma);
                    plot(x,p,'black')
                    hold on
                end
            else
                for x=0:0.01:5*PE.TrueLamda
                    p=PE.TrueLamda*exp(-PE.TrueLamda*x);
                    plot(x,p,'black')
                    hold on
                end
            end   
        end
        
    end
end
