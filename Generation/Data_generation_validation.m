close all
Validation_amount = 200000;
en = 695:0.1:740;
en1 = 698:0.1:735;
X_Validation = zeros(1,length(en1),1,Validation_amount); Y_Validation = zeros(1,1,1,Validation_amount);
meta_info_Validation = cell(Validation_amount,5); 
%each column is: group info, combination info, thickness of covolution,fwhm_zlp, fwhm_loren
is_conv = randperm(Validation_amount,Validation_amount*0.8);
is_addnoise = randperm(Validation_amount,Validation_amount*0.9);
for i = 1 :Validation_amount 
    

    %select a random combination
    index = randi(length(Fe_combine_data));
    
    %get the 2+ and 3+ data
    x2 = Fe_combine_data(index).x2;
    x3 = Fe_combine_data(index).x3;
    y2 = Fe_combine_data(index).y2;
    y3 = Fe_combine_data(index).y3;
        
    if i <= Validation_amount*0.9
        %set a random weight 
        w = rand(1);
    elseif i > Validation_amount*0.9 && i <= Validation_amount*0.95
        w = 1;
    else
        w = 0;
    end
       
    %save info to meta
    meta_info_Validation{i,1} = Fe_combine_data(index).group;
    meta_info_Validation{i,2} = Fe_combine_data(index).info;


    %add 2+ and 3+ up
    x = intersect(x2,x3);
    c2 = ismember(x2,x);
    c3 = ismember(x3,x);
    y = w * y2(c2) + (1-w)* y3(c3);


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

    meta_info_Validation{i,3} = thickness;
    meta_info_Validation{i,4} = fwhm_zlp;
    meta_info_Validation{i,5} = fwhm_loren;

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
   
    %save the date
    
    X_Validation(:,:,:,i) = y;
    Y_Validation(:,:,:,i) = w;
end