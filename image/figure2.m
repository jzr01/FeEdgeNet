close all;
subplot(1,2,1);
box on;
hold on;
grid('on');
title("Fe^2^+")
for i = 1: length(Fe2_data)
    x = Fe2_data(i).x;
    y = normalize(Fe2_data(i).y,'range');
    y = y(x <= 730);
    x = x(x <= 730);
    plot(x,y+ (i-1)*0.5,"LineWidth",1.5)
    text(730,y(end)+ (i-1)*0.5,Fe2_data(i).group,"FontSize",12)
end
xlim([700 740])
ylim([0 8.7])
set(gca,'FontSize',15,'Linewidth',1.5);
%exportgraphics(gcf,'Fe^2^+.png','Resolution',300)

subplot(1,2,2);
box on;
hold on;
grid('on');
title("Fe^3^+")
for i = 1: length(Fe3_data)
    x = Fe3_data(i).x;
    y = normalize(Fe3_data(i).y,'range');
    y = y(x <= 730);
    x = x(x <= 730);
    plot(x,y + (i-1)*0.5,"LineWidth",1.5)
    text(730,y(end)+ (i-1)*0.5,Fe3_data(i).group,"FontSize",12)
end
xlim([700 740])
ylim([0 13.2])
set(gca,'FontSize',15,'Linewidth',1.5);
set(gcf,'position',[510,10,800,1600])
exportgraphics(gcf,'figure2.png','Resolution',1000)