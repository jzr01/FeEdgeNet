y3 = test_data(30).data;
y2 = test_data(29).data;
for i = 1:length(test_data)
    x1 = 695:0.02:735;
    y1 = test_data(i).data;
    fe = [x1;y1]';

%     figure;
%     plot(x1,y2,'.')
%     hold on;
%     plot(x1,y3,'.')
%     hold on;
%     plot(x1,y1,'.')
%     legend('2+','3+',test_data(i).name)
%     
    
    func = @(x) sum((y1-x(1).*y3-x(2).*y2).^2);
    x0 = [0.5,0.5];
    x =  fminsearch(func,x0);
    
    figure;
    plot(y1,'rs');
    hold on;
    plot(x(1)*y3);
    plot(x(2)*y2);
    plot(x(1)*y3+x(2)*y2,'linewidth',2);
    legend(test_data(i).name,'2+','3+','fitted');
    test_data(i).fitting = x(1)/sum(x);
end


