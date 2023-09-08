en = 695:0.02:735;
close all;
for i = 1:length(test_data)
    test_data(i).data2 = interp1(en,test_data(i).data,698:0.1:735,'linear');
    test_data(i).truth = 1 - test_data(i).truth;
    test_data(i).cnn=  predict(cnn1,test_data(i).data2);
end

count = 0;
for i = 1:length(test_data)
    if abs(test_data(i).cnn(1)-test_data(i).truth) <= 0.1
        count = count + 1;
    end
end

acc_real_test = count / length(test_data)