for i = 1:15
    Fe2_normalize(i).x = Fe2_data(i).x;
    Fe2_normalize(i).y = 4/Fe2_data(i).Area_under_L3*Fe2_data(i).y;
    Fe2_normalize(i).name = Fe2_data(i).paper;
    Fe2_normalize(i).group = Fe2_data(i).group;
end

for i = 1:17
    Fe3_normalize(i).x = Fe3_data(i).x;
    Fe3_normalize(i).y = 5/Fe3_data(i).Area_under_L3*Fe3_data(i).y;
    Fe3_normalize(i).name = Fe3_data(i).paper;
    Fe3_normalize(i).group = Fe3_data(i).group;
end