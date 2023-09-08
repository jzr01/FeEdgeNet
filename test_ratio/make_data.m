close all
dinfo = dir('*.txt');
figure;
hold on;
for i = 1:length(dinfo)
    data = importdata(dinfo(i).name);
    x = ceil(data(1,1)):0.02:floor(data(end,1));
    y = interp1(data(:,1),data(:,2),x,'linear');
    test_data(i).x = x;
    test_data(i).y = normalize(y,'range');
    filename = dinfo(i).name;
    test_data(i).name = filename(1:end-4); 
    plot( test_data(i).x, test_data(i).y);
    title(test_data(i).name);
end

