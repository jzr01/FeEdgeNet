close all
for i = 1:length(test_data)
    figure;
    plot(698:0.02:735, test_data(i).data(en >= 698))
    title(test_data(i).name);
end