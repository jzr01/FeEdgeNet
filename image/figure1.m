close all;
subplot(1,2,1)
plot(Fe2_normalize(3).x,Fe2_normalize(3).y./max(Fe2_normalize(3).y),'LineWidth',1.5);
xlim([700 735]);
ylim([0 1.2]);
set(gca,'FontSize',13,'Linewidth',1.5);
grid("on")
subtitle("Fe^2^+")

subplot(1,2,2)
plot(Fe3_normalize(6).x,Fe3_normalize(6).y./max(Fe3_normalize(6).y),'LineWidth',1.5);
xlim([700 735]);
ylim([0 1.2]);
set(gca,'FontSize',13,'Linewidth',1.5);
grid("on")
subtitle("Fe^3^+")
set(gcf,'position',[100,100,800,400]);
exportgraphics(gcf,'figure1.png','Resolution',1000)