close all
figure;
hold on;
for i = 1:length(test_data)
    x = test_data(i).x;
    y = test_data(i).y;
    x1 = x(x<= 729 & x >= 702);
    y = y(x<= 729 & x >= 702);
    test_data(i).x = x1;
    test_data(i).y = y;
    plot( test_data(i).x, normalize(test_data(i).y,'range'));
    title(test_data(i).name);
end