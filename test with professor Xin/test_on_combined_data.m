close all
train_amount = length(Fe_combine_data);
en = 695:0.02:740;
en1 = 698:0.02:735;
X_Train = zeros(1,length(en1),1,train_amount); Y_Train = zeros(1,1,1,train_amount);
meta_info_Train = cell(train_amount,5); 
%each column is: group info, combination info, thickness of covolution,fwhm_zlp, fwhm_loren
for i = 1 :train_amount 
    

    %select a random combination
    index = i;
    
    %get the 2+ and 3+ data
    x2 = Fe_combine_data(index).x2;
    x3 = Fe_combine_data(index).x3;
    y2 = Fe_combine_data(index).y2;
    y3 = Fe_combine_data(index).y3;
        
    w = 0.5;
       
    %save info to meta
    meta_info_Train{i,1} = Fe_combine_data(index).group;
    meta_info_Train{i,2} = Fe_combine_data(index).info;


    %add 2+ and 3+ up
    x = intersect(x2,x3);
    c2 = ismember(x2,x);
    c3 = ismember(x3,x);
    y = w * y2(c2) + (1-w)* y3(c3);


    %add a random shift
    shift = 5;
    x = x + shift;
    
    ystart = y(1);
    yend = y(end);
    
    %extend the spectrum to 695 to 740ev
    y = interp1(x,y,en,'linear','extrap');
    y(en <= x(1)) = ystart;
    y(en >= x(end)) = yend;
    


    %save info to meta


    thickness = random('uniform',0,1);
    fwhm_zlp = random('uniform',0.01,1.5);
    fwhm_loren = random('uniform',0.1,0.4);
    [~, f] = pluralKernel_Gaussian(thickness,fwhm_zlp,fwhm_loren);

    indzero = find(f==max(f));
    yconv = conv(y,f);
    N = length(y);
    
    yconv = circshift(yconv,-indzero);
    
    y = yconv(1:N);



    meta_info_Train{i,3} = thickness;
    meta_info_Train{i,4} = fwhm_zlp;
    meta_info_Train{i,5} = fwhm_loren;

    y = y(en<=735 & en >= 698);
    %add noise 
    
    sd = std(y)/50;

    %white noise
    whitenoise=  random('normal',0,sd,1,length(y)); 
    y = y + whitenoise;
    
    %impulse noise
    IN = createimpulsiven( -sd, sd, 0.5 );
    imnoise = getimpulsiven( IN, length(y));
    y = y + imnoise;

        
    %normalization 
    y = y - mean(y);
    y = y / std(y);
    
    %plot the data
    figure;
    subplot(1,2,1)
    plot(698:0.02:735,y);
    title(Fe_combine_data(i).info)
    
    subplot(1,2,2);
    name1 = categorical({'Fe^2^+','Fe^3^+'});
    bar(name1,[w 1-w]);
    title('Composition');
    ylim([0,1]);
    text(1:2,[w 1-w],num2str([w 1-w]'),'vert','bottom','horiz','center'); 

    %save the date
    
    X_Train(:,:,:,i) = y;
    Y_Train(:,:,:,i) = w;
end
% run Data_generation_validation.m
% cd 'C:\Users\Zhengran Ji\Desktop\Fe edge\training\CNN';
% run CNN_network.m;