figure;
box on;
X = categorical({'SNR = 5','SNR = 10','SNR = 20','SNR = 30','Original'});
X = reordercats(X,{'SNR = 5','SNR = 10','SNR = 20','SNR = 30','Original'});
b = bar(X,accuarcy_list, 'BarWidth', 0.5);
set(gca,'FontSize',12,'Linewidth',1.5,"FontWeight",'bold');
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData*100)+'%';
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',13,"FontWeight",'bold')
ylim([0 1])
exportgraphics(gcf,"Accuarcy_bar.png",'Resolution',2400)
figure;
box on;
X = categorical({'SNR = 5','SNR = 10','SNR = 20','SNR = 30','Original'});
X = reordercats(X,{'SNR = 5','SNR = 10','SNR = 20','SNR = 30','Original'});
b = bar(X,MSE_loss, 'BarWidth', 0.5);
set(gca,'FontSize',12,'Linewidth',1.5,"FontWeight",'bold');
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(round(b(1).YData,3));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',13,"FontWeight",'bold')
ylim([0 0.5])
exportgraphics(gcf,"MSE_bar.png",'Resolution',2400)
