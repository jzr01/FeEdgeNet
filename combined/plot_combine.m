close all;
figure;
set(gcf,'position',[510,10,350,1600])
ylim([0,15.5]);
title('Fe^2^+ and Fe^3^+ combined');
set(gca,'FontSize',15,'Linewidth',1.5);
hold on;
for i = 1 : length(Fe_combined)
    x = Fe_combined(i).x;
    y = Fe_combined(i).y;
    y = normalize(y,'range');
    plot(x,y + (i-1)*0.5,'Linewidth',1.5);
    text(x(end),y(end)+ (i-1)*0.5,Fe_combined(i).group);
end

exportgraphics(gcf,'Fe_combined.png','Resolution',1000)