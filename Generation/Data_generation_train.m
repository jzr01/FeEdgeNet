close all
train_amount = 500000;
en = 695:0.1:740;
en1 = 698:0.1:735;
X_Train1 = zeros(1,length(en1),1,train_amount); Y_Train1 = zeros(1,1,1,train_amount);
meta_info_Train = cell(train_amount,5); 
%each column is: group info, combination info, thickness of covolution,fwhm_zlp, fwhm_loren
is_conv = randperm(train_amount,train_amount*0.7);
is_addnoise = randperm(train_amount,train_amount*0.9);
for i = 1 :train_amount 


    %select a random combination 
    index = randi(length(Fe3O4_data));
    
    y = Fe3O4_data(index).data;
    x = 695:0.02:735 ;
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

    y = y(en<=735 & en >= 698);
    
    if sum(ismember(is_addnoise,i)) == 1
        %add noise 
        r = random('Uniform',40,150);
        sd = max(y)/r;
    
        %white noise
        whitenoise=  random('normal',0,sd,1,length(y)); 
        y = y + whitenoise;
        
        % Define the probability of adding salt and pepper noise and the noise magnitude
        p = 0.1;
        noise_magnitude = 0.5;
        
        % Add salt and pepper noise to the vector
        y_noisy = y;
        y_noisy(rand(size(y)) < p/2) = noise_magnitude;
        y_noisy(rand(size(y)) < p/2) = -noise_magnitude;
        
    end
    
        
    %normalization 
    y = y - mean(y);
    y = y / std(y);
    
    %plot(en1,y);

    %save the date
    
    X_Train1(:,:,:,i) = y;
    Y_Train1(:,:,:,i) = 1/3;
end

