%% File Info
%SYDE 372 Lab 1 - Clusters and Classification Boundaries
%Feb 5, 2009

clear

%% Set Up Classes
A = ParametricClass([5;10], [8 0; 0 4], 0.5);
B = ParametricClass([10;15], [8 0; 0 4], 0.5);
C = ParametricClass([5;10], [8 4; 4 40], 100/450);
D = ParametricClass([15;10], [8 0; 0 8], 200/450);
E = ParametricClass([10;5], [10 -5; -5 20], 150/450);

%% CASE 1: A,B
% PLOTS
% Plot clusters and standard deviations
figure;

n_pts = 400;
colours = {'r' 'b'};
classes = {A B};

x_range = -5:0.2:20;
y_range = 4:0.2:20;
contours = 1.5;

Tools.ParametricPlot(classes, colours, n_pts, x_range, y_range, contours, {'A' '\sigma_A' 'B' '\sigma_B' 'MED' 'GED' 'MAP'})

figure;

x_range = -3:0.15:20;
y_range = 5:0.15:23;

Tools.NonParametricPlot(classes, colours, n_pts, x_range, y_range, contours, {'A' 'B' 'NN' '5NN'})

% TESTING
Tools.Testing(classes, {200 200})

%% CASE 2: C,D,E
% PLOTS
% Plot clusters and standard deviations
figure;

n_pts = 450;
colours = {'red' 'blue' 'green'};
classes = {C D E};

% Plot bounds
x_range =  -20:0.2:30;
y_range = -10:0.2:35;
contours = [1.5 2.5];

Tools.ParametricPlot(classes, colours, n_pts, x_range, y_range, contours, {'C' '\sigma_C' 'D' '\sigma_D' 'E' '\sigma_E' 'MED' 'GED' 'MAP'})

figure;

%Plot KNN and NN
x_range =  -1:0.15:25;
y_range = -6:0.15:28;

Tools.NonParametricPlot(classes, colours, n_pts, x_range, y_range, contours, {'C' 'D' 'E' 'NN' '5NN'})

% TESTING
Tools.Testing(classes, {100 200 150})

%% Extra Fun Stuff
% % Investigating effect of choice of k on probability of error
% classes = {A B};
% n_pts = {200 200};
% 
% np_classes = cell(size(classes));
% test_data = cell(size(classes));
% conf_kNN_play = cell(200);
% 
% for i=1:length(classes)
%     np_classes{i} = classes{i}.TestData(n_pts{i}); %n_pts
%     test_data{i} = classes{i}.TestData(n_pts{i});
% end
% 
% for k = 1:200
%     conf_kNN_play{k} = NonParametricClass.ConfusionMatrixKNN(np_classes, test_data, k);
%     prob_kNN_play(k) = NonParametricClass.ErrorProbability(conf_kNN_play{k});
% end
% 
% figure
% line(1:200,prob_kNN_play);
% 
% classes = {C D E};
% n_pts = {100 200 150};
% 
% np_classes = cell(size(classes));
% test_data = cell(size(classes));
% conf_kNN_play = cell(100);
% 
% for i=1:length(classes)
%     np_classes{i} = classes{i}.TestData(n_pts{i}); %n_pts
%     test_data{i} = classes{i}.TestData(n_pts{i});
% end
% 
% for k = 1:100
%     conf_kNN_play{k} = NonParametricClass.ConfusionMatrixKNN(np_classes, test_data, k);
%     prob_kNN_play2(k) = NonParametricClass.ErrorProbability(conf_kNN_play{k});
% end
% size(1:100)
% size(prob_kNN_play2)
% figure
% line(1:100,prob_kNN_play2);