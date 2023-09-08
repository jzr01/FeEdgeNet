close all;
y =  test_data(12).data{1};
ind = find(en>=727.36);
y(ind) = y(en == 727.36);
test_data(12).data = {y};