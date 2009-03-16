classdef SequentialEstimation < handle
    %SEQUENTIALESTIMATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        classes = {};
        class_pts = {};
        discriminants = {};
    end
    
    methods
        function SE = SequentialEstimation(classes)
            SE.classes = classes;
            SE.class_pts = classes;
            SE.discriminants = {};
        end
        
        function [conf, points] = Confusion(SE)
            % Decede on the random point pair
            pc_1 = ParametricClass(SE.class_pts{1}(randi(size(SE.class_pts{1},1),1),:)',0,0);
            pc_2 = ParametricClass(SE.class_pts{2}(randi(size(SE.class_pts{2},1),1),:)', 0, 0);
            points = {pc_1 pc_2};
            
            tc_1 = NonParametricClass(SE.class_pts{1});
            tc_2 = NonParametricClass(SE.class_pts{2});
            conf = ParametricClass.ConfusionMatrixMED(points, {tc_1 tc_2});
        end
        
        function [correct_class_no, points, remaining] = GenerateDiscriminant(SE)
            % Find a good discriminant. Returns a set of ParametricClasses
            % that comprise the discriminant when the MED is used.
            [c, points] = SE.Confusion();
            while c(1,2) > 0 && c(2,1) > 0
                [c, points] = SE.Confusion();
            end
            
            if c(1,2) == 0
                %'a' is all within the correct classifier
                %remove 'b's that are classed as 'b'
                correct_class_no = 1;
            else
                %'b' is all within the correct classifier
                %remove 'a's that are classed as 'a'
                correct_class_no = 2;
            end
            
            % Remove properly classified points from the other class
            r = 0;
            for p=1:size(SE.class_pts{correct_class_no},1)
                class = ParametricClass.ClassifyMED(SE.class_pts{correct_class_no}(p-r, :)', points);
                if class == correct_class_no
                   SE.class_pts{correct_class_no}(p-r,:) = [];
                   r = r+1;
                end
            end
            
            remaining = SE.class_pts{correct_class_no};
%             Plot Stuff
%             x_range =  50:1:550;
%             y_range = 0:1:450;
%             m = ParametricClass.BoundMatrixMED(points, x_range, y_range);
%             contour(x_range, y_range, m', [1 1], 'LineWidth', 1)
%             hold on;
%             scatter(incomplete_class(:,1), incomplete_class(:,2), 5, strcat('green'))
%             hold on
        end
        
        function FindDiscriminants(SE)
            while (size(SE.class_pts{1},1) > 0) && (size(SE.class_pts{2},1) > 0)
                [class_no, pts, remaining] = SE.GenerateDiscriminant();
                SE.discriminants = [SE.discriminants {{class_no, pts}}];
                SE.class_pts{class_no} = remaining;
            end
        end
        
        function class = Classify(SE,point)
            class = 0;
            for i = 1:size(SE.discriminants, 2)
                med_class = ParametricClass.ClassifyMED(point, SE.discriminants{i}{2});
                if med_class == SE.discriminants{i}{1}
                    class = med_class;
                    break
                elseif med_class == 1
                    class = 2;
                else
                    class = 1;
                end
            end
        end
        
        function PlotDiscriminants(SE)
            x_range =  50:5:550;
            y_range = 0:5:450;
            
            for i = 1:size(SE.discriminants,2)
                m = ParametricClass.BoundMatrixMED(SE.discriminants{i}{2}, x_range, y_range);
                
                if SE.discriminants{i}{1} == 1
                    col = 'green';
                else
                    col = 'cyan';
                end

                contour(x_range, y_range, m', [1 1], 'LineWidth', 1, 'Edgecolor', col)
                hold on;
            end
            
%                 scatter(SE.class_pts{class_no}(:,1), SE.class_pts{class_no}(:,2), 5, strcat('green'))
%                 hold on
            % Plots
            scatter(SE.classes{1}(:,1), SE.classes{1}(:,2), 5, strcat('*', 'red'))
            hold on
            scatter(SE.classes{2}(:,1), SE.classes{2}(:,2), 5, strcat('*', 'blue'))
            hold on
        end
        
        function PlotBoundary(SE)
            x_range =  50:2.5:550;
            y_range = 0:2.5:450;
            map = zeros(length(x_range),length(y_range));
            for i = 1:length(x_range)
               for j = 1:length(y_range)
                   map(i,j) = SE.Classify([x_range(i) y_range(j)]');
               end
            end
            
            contour(x_range, y_range, map', [1 1], 'LineWidth', 3, 'Edgecolor', 'black')
            hold on;
        end
    end
    
end

