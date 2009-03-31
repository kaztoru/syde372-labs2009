%% Loading and setup
load feat.mat; % Load the feature data
x = f32(1:2,:); % Extract x_ij from f32

%% Perform clustering
[labels,c] = kmeans(x',10,'onlinephase','off');
cluster = cell(10,1);

for i=1:10
    match = labels == i;
    x_var = x(1,:);
    y_var = x(2,:);
    cluster{i} = [x_var(match); y_var(match)];
end

%% Plotting
figure;
colours = {'blue', 'green', 'red', 'cyan', 'magenta', 'yellow', 'black', [1 0.5 0], [0.5 0 0.5], [0 0.5 0.5]};
for i=1:10
    cluster{i};
    scatter(cluster{i}(1,:),cluster{i}(2,:),'.', 'MarkerEdgeColor', colours{i}); % Plot the original data
    hold on;
    scatter(c(i,1)',c(i,2)','filled', 'MarkerEdgeColor', 'black', 'MarkerFaceColor', colours{i});
    hold on;
end
hold off;

%% FUZZY K-MEANS
% Set-up
figure;
marks = {'+','o','*','x','s','d'};

%Plot
scatter(x(1,:),x(2,:),'.','MarkerEdgeColor',[0.5 0.5 0.5]);
hold on;
for i=1:6
    [centres, U] = fcm(x',10); % Run MATLAB's fuzzy c-means calculator
    scatter(centres(:,1)',centres(:,2)', marks{i}, 'filled','MarkerEdgeColor', 'black','MarkerFaceColor', colours{i},'SizeData',10^2);
    hold on;
end
hold off;

% Contour Plot
figure;
colours = [
    0 0 0;
    1 0 0;
    0 1 0;
    0 0 1;
    1 0 1;
    0 1 1;
    0.5 0.5 0.5;
    0.5 0 0;
    1 0.62 0.40;
    0.49 1 0.83
];

[centres, U] = fcm(x',10); % Run MATLAB's fuzzy c-means calculator

colourmap = U'*colours;
for i=1:160
    scatter(x(1,i),x(2,i),'s','filled', 'MarkerEdgeColor', colourmap(i,:), 'MarkerFaceColor', colourmap(i,:),'SizeData',3^2);
    hold on
end


for i=1:10
    scatter(centres(i,1)',centres(i,2)','filled','MarkerEdgeColor', 'black','MarkerFaceColor', colours(i,:),'SizeData',10^2);
    hold on;
end