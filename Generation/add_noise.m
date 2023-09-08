close all;
X_test_noise1 = zeros(1,371,1,length(X_Validation));    
noise_list = [5 10 20 30];
for j = 1:4
    for i = 1:length(X_Validation)
        %add noise 
        y = X_Validation(:,:,:,i);
        y = y +1;
       
        snr = noise_list(j);
    
        sd =  mean(y)/snr;
    
        %white noise
        whitenoise=  random('normal',0,sd,1,length(y)); 
        a = y + whitenoise;
        a = a -mean(a);
        a = a/std(a);
        X_test_noise1(:,:,:,i) = a;
    
    end
    
    Y_predict = predict(cnn1,X_test_noise1);
    Y_test_noise = reshape(Y_Validation,1000,1);
    figure;
    hold on;
    box on;
    scatter(1-Y_predict,1-Y_test_noise,5,'filled');
    plot(0:0.1:1,0:0.1:1,'LineWidth',1.5,'Color','#D95319');
    plot(0.1:0.1:1,0:0.1:0.9,'--','LineWidth',1.5,'Color','#D95319');
    plot(0:0.1:0.9,0.1:0.1:1,'--','LineWidth',1.5,'Color','#D95319');
    xlabel('Predict Ratio of Fe^{3+}') 
    ylabel('True Ratio of Fe^{3+}') 
    title("SNR = "+string(noise_list(j)))
    ylim([-0.02, 1.02])
    xlim([-0.02 1.02])
    set(gca,'FontSize',13,'Linewidth',1.5,'FontWeight','bold');
    %exportgraphics(gcf,'figure_snr=' + string(noise_list(j))+'.png','Resolution',2400)
end