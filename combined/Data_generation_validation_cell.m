close all
Validation_amount = 25000;
en = 695:0.02:740;
X_Validation = cell(Validation_amount,1); Y_Validation = cell(Validation_amount,1);
for i = 1 :Validation_amount 
    
    if i <= Validation_amount*0.9

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
    
    elseif i > Validation_amount*0.9 && i <= Validation_amount*0.95
        
        %select a random combination
        index = randi(length(Fe2_normalize));
        w = 1;
        %get the 2+ data
        x = Fe2_normalize(index).x;
        y = Fe2_normalize(index).y;

    else
        
        %select a random combination
        index = randi(length(Fe3_normalize));
        w = 0;
        %get the 3+ data
        x = Fe3_normalize(index).x;
        y = Fe3_normalize(index).y;

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
    
    %convolution

    
    %add noise 
    
        sd = std(y)/100;
    
        %possion noise
        possionnoise =  random('Poisson',sd,1,length(en));
        y = y + possionnoise;
        
        %white noise
        whitenoise=  random('normal',0,sd,1,length(en)); 
        y = y + whitenoise;
        
        %impulse noise
        
    
    %normalization (Question here)
    y = y - mean(y);
    y = y / std(y);
    
    %plot the data
%     figure;
%     subplot(1,2,1)
%     plot(en,y);
%     title('Spectrum')
%     
%     subplot(1,2,2);
%     name1 = categorical({'Fe^2^+','Fe^3^+'});
%     bar(name1,[w 1-w]);
%     title('Composition');
%     ylim([0,1]);
%     text(1:2,[w 1-w],num2str([w 1-w]'),'vert','bottom','horiz','center'); 

    %save the date
    
    X_Validation{i} = y;
    Y_Validation{i} = w;
end

    
