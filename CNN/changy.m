YV = zeros(2,1,1,200000);
for i = 1:200000
    YV(1,1,1,i) = Y_Train(1,1,1,i);
    YV(2,1,1,i) = 1 - Y_Train(1,1,1,i);
end

Y_Train = YV;