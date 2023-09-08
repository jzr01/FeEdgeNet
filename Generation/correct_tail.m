close all;
for i = 1:length(Fe_combine_data)
    en1 = Fe_combine_data(i).x2;
    en2 = Fe_combine_data(i).x3;
    Fe2 = Fe_combine_data(i).y2;
    Fe3 = Fe_combine_data(i).y3;

    Fe2_avg = mean(Fe2(en1 >= 728));
    Fe3_avg = mean(Fe3(en2 >= 728));
    Fe2 = Fe2*Fe3_avg/Fe2_avg;

    Fe_combine_data(i).y2 = Fe2;
    Fe_combine_data(i).y3 = Fe3;
end

for i = 1:length(Fe_combine_data)
    figure;
    hold on;
    plot(Fe_combine_data(i).x2,Fe_combine_data(i).y2);
    plot(Fe_combine_data(i).x3,Fe_combine_data(i).y3);
end


for i = 1:length(Fe_combine_data)
    en = Fe_combine_data(i).x2;
    data = Fe_combine_data(i).y2;
    max_x = en(data == max(data));
    x = en + 708.5 - max_x(1);
    x_end = x(end);
    y_end = data(end);
    y = interp1(x,data,en,'linear','extrap');
    y(x >= x_end) = y_end;
    Fe_combine_data(i).y2 = y;

    en = Fe_combine_data(i).x3;
    data = Fe_combine_data(i).y3;
    max_x = en(data == max(data));
    x = en + 709.5 - max_x(1);
    x_end = x(end);
    y_end = data(end);
    y = interp1(x,data,en,'linear','extrap');
    y(x >= x_end) = y_end;
    Fe_combine_data(i).y3 = y;
end