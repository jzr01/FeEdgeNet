%    t_ind= randperm(10^6, 2*10^5);
%    v_ind = randperm(2*10^5,5*10^4);
%    v_ind = sort(v_ind);
%    t_ind = sort(t_ind);
%    v_ind = sort(v_ind);
%    t_ind = sort(t_ind);
%    XT = zeros(1,186,1,2*10^5);
%    YT = zeros(1,1,1,2*10^5);
   for i = 1:2*10^5
        XT(:,:,:,i) = interp1(698:0.1:735, X_Train(:,:,:,t_ind(i)),698:0.2:735,"linear");
        YT(:,1,:,i) = Y_Train(:,:,:,t_ind(i));
        %YT(:,2,:,i) = 1 - Y_Train(:,:,:,t_ind(i));
   end

   XV = zeros(1,186,1,5*10^4);
   YV = zeros(1,1,1,5*10^4);
   for i = 1:5*10^4
       XV(:,:,:,i) = interp1(698:0.1:735, X_Validation(:,:,:,v_ind(i)),698:0.2:735,"linear");
       YV(:,1,:,i) = Y_Validation(:,:,:,v_ind(i));
       %YV(:,2,:,i) = 1 - Y_Validation(:,:,:,v_ind(i));
   end

   YV1 = zeros(1,1,2,length(YV));
   for i = 1: length(YV)
       YV1(:,:,1,i) = YV(:,:,:,i);
       YV1(:,:,2,i) = 1- YV1(:,:,1,i);
   end

   YT1 = zeros(1,1,2,length(YT));
   for i = 1: length(YT)
       YT1(:,:,1,i) = YT(:,:,:,i);
       YT1(:,:,2,i) = 1- YT1(:,:,1,i);
   end
