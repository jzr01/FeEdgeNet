close all
Train_amount = 200000;
en = 695:0.02:740;
X_Train = cell(Train_amount,1); Y_Train = cell(Train_amount,1);
meta_info_Train = cell(Train_amount,5); 
%each column is: group info, combination info, thickness of covolution,fwhm_zlp, fwhm_loren
is_conv = randperm(Train_amount,Train_amount*0.8);
for i = 1 :Train_amount 
    
    if i <= Train_amount*0.9

        %select a random combination
        index = randi(length(Fe_combine_data));
        
        %get the 2+ and 3+ data
        x2 = Fe_combine_data(index).x2;
        x3 = Fe_combine_data(index).x3;
        y2 = Fe_combine_data(index).y2;
        y3 = Fe_combine_data(index).y3;
        
        %set a random weight 
        w = rand(1);
        
        %add 2+ and 3+ up
        x = intersect(x2,x3);
        c2 = ismember(x2,x);
        c3 = ismember(x3,x);
        y = w * y2(c2) + (1-w)* y3(c3);

        %save info to meta
        meta_info_Train{i,1} = Fe_combine_data(index).group;
        meta_info_Train{i,2} = Fe_combine_data(index).info;
    
    elseif i > Train_amount*0.9 && i <= Train_amount*0.95
        
        %select a random combination
        index = randi(length(Fe2_normalize));
        w = 1;
        %get the 2+ data
        x = Fe2_normalize(index).x;
        y = Fe2_normalize(index).y;

        %save info to meta
        meta_info_Train{i,1} = Fe2_normalize(index).group;
        meta_info_Train{i,2} = "None";

    else
        
        %select a random combination
        index = randi(length(Fe3_normalize));
        w = 0;
        %get the 3+ data
        x = Fe3_normalize(index).x;
        y = Fe3_normalize(index).y;

        %save info to meta
        meta_info_Train{i,1} = Fe3_normalize(index).group;
        meta_info_Train{i,2} = "None";

    end

    %add a random shift
    shift = random('uniform',-5,5);
    x = x + shift;
    
    ystart = y(1);
    yend = y(end);
    
    %extend the spectrum to 695 to 740ev
    y = interp1(x,y,en,'linear','extrap');
    y(en <= x(1)) = ystart;
    y(en >= x(end)) = yend;
    
    %save info to meta

    thickness = nan;
    fwhm_zlp = nan;
    fwhm_loren = nan;

    %convolution
    if sum(ismember(is_conv,i)) == 1
        thickness = random('uniform',0,1);
        fwhm_zlp = random('uniform',0.01,1.5);
        fwhm_loren = random('uniform',0.1,0.4);
        [~, f] = pluralKernel_Gaussian(thickness,fwhm_zlp,fwhm_loren);
    
        indzero = find(f==max(f));
        yconv = conv(y,f);
        N = length(y);
        
        yconv = circshift(yconv,-indzero);
        
        y = yconv(1:N);
    
    end

    meta_info_Train{i,3} = thickness;
    meta_info_Train{i,4} = fwhm_zlp;
    meta_info_Train{i,5} = fwhm_loren;

    y = y(en<=735);
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
%     figure;
%     subplot(1,2,1)
%     plot(695:0.02:735,y);
%     title('Spectrum')
%     
%     subplot(1,2,2);
%     name1 = categorical({'Fe^2^+','Fe^3^+'});
%     bar(name1,[w 1-w]);
%     title('Composition');
%     ylim([0,1]);
%     text(1:2,[w 1-w],num2str([w 1-w]'),'vert','bottom','horiz','center'); 

    %save the data
    
    X_Train{i} = y;
    Y_Train{i} = w;
end

run Data_generation_validation_cell.m;
cd 'C:\Users\Zhengran Ji\Desktop\Fe edge\training\CNN';
run CNN_network.m;