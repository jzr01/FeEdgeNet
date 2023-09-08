close all;
m = 0;
for i = 1:
    x_2 = Fe2_normalize(i).x;
    y_2 = Fe2_normalize(i).y;
    for j = 1:26
      if strcmp(Fe2_normalize(i).group,Fe3_normalize(j).group) == 1
        m = m + 1;
        x_3 = Fe3_normalize(j).x;
        y_3 = Fe3_normalize(j).y;
        x = intersect(x_2,x_3);
        c2 = ismember(x_2,x);
        c3 = ismember(x_3,x);
        y = y_2(c2)+y_3(c3);
        Fe_combined(m).x = x;
        Fe_combined(m).y = y;
        Fe_combined(m).group = Fe2_normalize(i).group;
        Fe_combined(m).info = strcat(string(i),'+',string(j));
        Fe_combined(m).name = Fe2_normalize(i).name;
      end
    end
end