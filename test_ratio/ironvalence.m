close all;
fe2y = test_data(29).data;
fe3y = test_data(30).data;
en = 695:0.02:735;
for i = 1:length(test_data)
    y1 = test_data(i).data;

    figure;
    plot(en,fe2y,'.')
    hold on;
    plot(en,fe3y,'.')
    hold on;
    plot(en,y1,'.')
    legend('2+','3+',test_data(i).name)
    
    y3 = fe2y';
    y2 = fe3y';
    
    func = @(x) sum((y1'-x(1).*y3-x(2).*y2).^2);
    x0 = [0.5,0.5];
    x =  fminsearch(func,x0);
    
    figure;
    plot(y1,'rs');
    hold on;
    plot(x(1)*y3);
    plot(x(2)*y2);
    plot(x(1)*y3+x(2)*y2,'linewidth',2);
    legend(test_data(i).name,'2+','3+','fitted');
    test_data(i).fitting = x(2)/sum(x);
end


