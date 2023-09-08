function [x1,y1] = align_spec(standard,data)
x2 = data(:,1);
y2 = data(:,2);
difference = x2(y2 == max(y2))-standard;
y1 = y2;
x1 = x2 - difference;
end