dif = 0;
for i = 1:length(Fe3_data)
    for j =  1:length(Fe_data)
        if length(Fe3_data(i).paper) == length(Fe_data(j).Name)
            dif = Fe_data(j).DeltaE_2;
            break;
        end
    my_ind = Fe3_data(i).y == max(Fe3_data(i).y);
    x_high = Fe3_data(i).x(my_ind);
    Fe3_data(i).x = Fe3_data(i).x - x_high(1) + 709.12 + dif;
    end
end

