for i = 1:length(test_data)
    data = test_data(i).data{1};
    test_data(i).data = {data(1:2001)};
end