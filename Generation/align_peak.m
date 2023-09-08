close all;

for i = 1:length(Fe_combine_data)
    x = Fe_combine_data(i).x2;
    y = Fe_combine_data(i).y2;
    ind = x(y == max(y));
    x1 = x+ 708.5 - ind(1);
    x2 = ceil(x1(1)):0.2:floor(x1(end));
    y = interp1(x1,y,x2,'linear');

    Fe_combine_data(i).x2 = x2;
    Fe_combine_data(i).y2 = y;
end