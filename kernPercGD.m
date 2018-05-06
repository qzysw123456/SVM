function [a b] = kernPercGD(train)
%train = load('optdigits79_train.txt');
n = length(train);
d = size(train,2) - 1;

theclass = train(:,d+1);
judge = zeros(n,1);

train = train(:,1:d);

a = zeros(1,n);
b = 0;
flag = 1;
max_iter = 10;
    while flag == 1
        flag = 0;
        for i = 1 : n
            acc = 0;
            for j = 1 : n
                acc = acc + a(j) * theclass(j) * (train(i,:) * train(j,:)')^2;
            end
            acc = (acc + b)* theclass(i);
            if( acc <= 0 )
                a(i) = a(i) + 1;
                b = b + theclass(i);
                flag = 1;
            end
        end
        max_iter = max_iter - 1;
        if(max_iter == 0) 
            break;
        end
    end
    
    for i = 1 : n
        acc = 0;
        for j = 1 : n
            acc = acc + a(j) * theclass(j) * (train(i,:) * train(j,:)')^2;
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
    sprintf('training error is %.5f',err)
end