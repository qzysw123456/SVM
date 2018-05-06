train = load('optdigits79_train.txt');
test = load('optdigits79_test.txt');

n = length(test);
d = size(test,2) -1;

judge = zeros(n,1);
theclass = test(:,d+1);
test = test(:,1:d);

[a b] = kernPercGD(train);

for i = 1 : n
        acc = 0;
        for j = 1 : length(train)
            acc = acc + a(j) * train(j,d+1) * (test(i,:) * train(j,1:d)')^2;
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
err = sum(judge ~= theclass)/n;
sprintf('79 test error rate is %.5f',err)

train = load('optdigits49_train.txt');
test = load('optdigits49_test.txt');

n = length(test);
d = size(test,2) -1;

judge = zeros(n,1);
theclass = test(:,d+1);
test = test(:,1:d);

[a b] = kernPercGD(train);

for i = 1 : n
        acc = 0;
        for j = 1 : length(train)
            acc = acc + a(j) * train(j,d+1) * (test(i,:) * train(j,1:d)')^2;
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
err = sum(judge ~= theclass)/n;
sprintf('49 test error rate is %.5f',err)