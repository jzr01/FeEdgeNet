close all;
m = 0;
for i = 1:length(Fe2_normalize)
    x_2 = Fe2_normalize(i).x;
    y_2 = Fe2_normalize(i).y;
    for j = 1:length(Fe3_normalize)
      if strcmp(Fe2_normalize(i).group,Fe3_normalize(j).group) == 1
        m = m + 1;
        x_3 = Fe3_normalize(j).x;
        y_3 = Fe3_normalize(j).y;
        Fe_combined(m).x2 = x_2;
        Fe_combined(m).y2 = y_2;
        Fe_combined(m).x3 = x_3;
        Fe_combined(m).y3 = y_3;
        Fe_combined(m).group = Fe2_normalize(i).group;
        Fe_combined(m).info = strcat(string(i),'+',string(j));
        Fe_combined(m).name = Fe2_normalize(i).name;
      end
    end
end