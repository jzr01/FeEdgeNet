close all
en = 695:0.02:735;
figure;
hold on
plot(en,test_data(29).data)
plot(en,test_data(30).data)

for i = 1:length(Fe_combine_data)
    figure;
    hold on;
    plot(Fe_combine_data(i).x2,Fe_combine_data(i).y2)
    plot(Fe_combine_data(i).x3,Fe_combine_data(i).y3)
    title(Fe_combine_data(i).group +" and "+ Fe_combine_data(i).info )
end