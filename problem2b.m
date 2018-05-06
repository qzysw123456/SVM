rng(1); % For reproducibility
r = sqrt(rand(100,1)); % Radius
t = 2*pi*rand(100,1); % Angle
data1 = [r.*cos(t), r.*sin(t)]; % Points
r2 = sqrt(3*rand(100,1)+2); % Radius
t2 = 2*pi*rand(100,1); % Angle
data2 = [r2.*cos(t2), r2.*sin(t2)]; % points

data3 = [data1;data2];
theclass = ones(200,1);
theclass(1:100) = -1;

SVMModel = fitcsvm(data3,theclass,'KernelFunction','polynomial','BoxConstraint',1);

X = data3;

svInd = SVMModel.IsSupportVector;
h = 0.02; % Mesh grid step size
[X1,X2] = meshgrid(min(X(:,1)):h:max(X(:,1)),...
    min(X(:,2)):h:max(X(:,2)));
[label,score] = predict(SVMModel,[X1(:),X2(:)]);
scoreGrid = reshape(score(:,1),size(X1,1),size(X2,2));
label = reshape(label,size(X1,1),size(X2,2));

figure
plot(X(:,1),X(:,2),'k.')
hold on
plot(X(svInd,1),X(svInd,2),'ro','MarkerSize',10)
%contour(X1,X2,scoreGrid)
contour(X1,X2,label)
colorbar;
title('{\bf Iris Outlier Detection via One-Class SVM}')
xlabel('Sepal Length (cm)')
ylabel('Sepal Width (cm)')
legend('Observation','Support Vector')
hold off