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

n = length(data3);
a = zeros(1,n);
b = 0;
flag = 1;

while flag == 1
    flag = 0;
    for i = 1 : n
        acc = 0;
        for j = 1 : n
            acc = acc + a(j) * theclass(j) * (data3(i,:) * data3(j,:)')^2;
        end
        acc = (acc + b)* theclass(i);
        if( acc <= 0 )
            a(i) = a(i) + 1;
            b = b + theclass(i);
            flag = 1;
        end
    end
end

judge = zeros(n,1);
for i = 1 : n
    acc = 0;
    for j = 1 : n
        acc = acc + a(j) * theclass(j) * (data3(i,:) * data3(j,:)')^2;
    end
    acc = acc + b;
    judge(i) = acc;
end

for i = 1 : n
    if judge(i) < 0
        judge(i) = -1 ;
    else
        judge(i) = 1 ;
    end
end
err_rate = sum(judge ~= theclass)/n;
sprintf('error rate is %f',err_rate)
[X,Y] = meshgrid(min(data3(:,1)):0.1:max(data3(:,1)),min(data3(:,2)):0.1:max(data3(:,2)));
%mesh_n = length(X);
Grid = [X(:),Y(:)];
Z = zeros(1,length(Grid));
for xi = 1 : length(Grid)
    vec = Grid(xi,:);
    acc = 0;
    for j = 1 : n
        acc = acc + a(j) * theclass(j) * (vec * data3(j,:)')^2;
    end
    acc = acc + b;
    if acc < 0 
        Z(xi) = -1;
    else
        Z(xi) = 1;
    end
    %Z(xi) = acc;
end

figure; 
hold all
plot(data1(:,1),data1(:,2),'r.','MarkerSize',15) 
%hold on 
plot(data2(:,1),data2(:,2),'b.','MarkerSize',15) 
%ezpolar(@(x)1);ezpolar(@(x)2);
axis equal
%hold off
contour(X,Y,reshape(Z,size(X)));