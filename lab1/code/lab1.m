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
subplot(2,2,1)

n_pts = 400;
colours = {'red' 'blue'};
classes = {A B};

x_range = -5:0.5:20;
y_range = 4:0.5:20;
contours = 1.5;

Tools.ParametricPlot(classes, colours, n_pts, x_range, y_range, contours)

subplot(2,2,2)

x_range = -3:0.25:20;
y_range = 5:0.25:23;

Tools.NonParametricPlot(classes, colours, n_pts, x_range, y_range, contours)

% TESTING
Tools.Testing(classes, {200 200})

%% CASE 2: C,D,E
% PLOTS
% Plot clusters and standard deviations
subplot(2,2,3)

n_pts = 450;
colours = {'red' 'blue' 'green'};
classes = {C D E};

% Plot bounds
x_range =  -20:0.5:30;
y_range = -10:0.5:35;
contours = [1.5 2.5];

Tools.ParametricPlot(classes, colours, n_pts, x_range, y_range, contours)

subplot(2,2,4)

%Plot KNN and NN
x_range =  -1:0.25:25;
y_range = -6:0.25:28;

Tools.NonParametricPlot(classes, colours, n_pts, x_range, y_range, contours)

% TESTING
Tools.Testing(classes, {100 200 150})