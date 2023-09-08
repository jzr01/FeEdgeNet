close all;
en_bs=test_data(1).x';
sig_bs = test_data(1).y';

%figure;
plot(en_bs,sig_bs);
title('**Please click 5 times**')
%set(gca,'xlim',[min(en_bs),min(en_bs)+120]);
hold off
drawnow;
fprintf('\n**Please click 5 times**\n');
fprintf('l: click on the start of L3\n2: click on peak of L3\n3: click on the valley between L3 and L2\n4: click on the peak of L2\n5: click on where the L2 ends\n');
pos = ginput(5);
%l: click on the start of L3
%2: click on peak of L3
%3: click on the valley between L3 and L2
%4: click on the peak of L2
%5: click on where the L2 ends


enL3start = pos(1,1); %where L3 starts
en1 = pos(2,1); %initial guess for enL3
en2 = pos(3,1); %initial guess for envalley
en3 = pos(4,1); %initial guess for enL2
enL2end = pos(5,1); %where L2 ends
bgsig = pos(5,2); %the L2 ending intensity


ind = en_bs>=en1-2.5 & en_bs<=en1+2.5;
ensel = en_bs(ind);
sigsel = sig_bs(ind);
enL3 = ensel(sigsel==max(sigsel)); %L3 peak

ind = en_bs>=en3-2.5 & en_bs<=en3+2.5;
ensel = en_bs(ind);
sigsel = sig_bs(ind);
enL2 = ensel(sigsel==max(sigsel)); %L2 peak

ind = en_bs>=en2-2.5 & en_bs<=en2+2.5;
ensel = en_bs(ind);
sigsel = sig_bs(ind);
envalley = ensel(sigsel==min(sigsel)); %L2,3 valley


stepfunc = zeros(size(sig_bs));
ind3 = en_bs>=enL2;
ind2 = en_bs>=enL3 & en_bs<enL2;
ind1 = en_bs<enL3;
stepfunc(ind3) = bgsig;
stepfunc(ind2) = bgsig*2/3; %the L2,3 step function

errfunc = (erf(en_bs-enL3)+1)/2*bgsig*2/3 + (erf(en_bs-enL2)+1)/2*bgsig*1/3; %the L2,3 error function

figure;
plot(en_bs,sig_bs);
hold on;
plot(en_bs,stepfunc,'r-');
plot(en_bs,sig_bs-stepfunc,'r--');

figure;
plot(en_bs,sig_bs);
hold on;
plot(en_bs,errfunc,'r-');
plot(en_bs,sig_bs-errfunc,'r--');
plot(en_bs,sig_bs-stepfunc,'k--');


indL3 = en_bs>=enL3start & en_bs<=envalley(1);
indL2 = en_bs>=envalley(1) & en_bs<=enL2end;
indrange = en_bs>=enL3start & en_bs<=enL2end;

L32 = zeros(1,5);
L3 = zeros(1,5);
L2 = zeros(1,5);
%1: Area, step function
%2: Area, err function
%3: 2 Gaussians, step function
%4: 2 Gaussians, err function
%5: triangle subtraction

sig_sub = sig_bs-stepfunc;
sig_sub_step = sig_sub;
L32(1) = sum(sig_sub(indL3))/sum(sig_sub(indL2));
L3(1) = sum(sig_sub(indL3));
L2(1) = sum(sig_sub(indL2));

sig_sub = sig_bs-errfunc; 
sig_sub_err = sig_sub; 
L32(2) = sum(sig_sub(indL3))/sum(sig_sub(indL2));
L3(2) = sum(sig_sub(indL3)); %this one
L2(2) = sum(sig_sub(indL2));




sig_sub = sig_bs-stepfunc;
indsel = en_bs>=enL3start & en_bs<=enL2end;
gauss2_step = fit(en_bs(indsel),sig_sub(indsel),'gauss2');
if gauss2_step.b1<gauss2_step.b2
    areaL3 = gauss2_step.a1*gauss2_step.c1*sqrt(pi);
    areaL2 = gauss2_step.a2*gauss2_step.c2*sqrt(pi);
else
    areaL2 = gauss2_step.a1*gauss2_step.c1*sqrt(pi);
    areaL3 = gauss2_step.a2*gauss2_step.c2*sqrt(pi);
end
L32(3) = areaL3/areaL2;
L3(3) = areaL3;
L2(3) = areaL2;

sig_sub = sig_bs-errfunc;
indsel = en_bs>=enL3start & en_bs<=enL2end;
gauss2_err = fit(en_bs(indsel),sig_sub(indsel),'gauss2');
if gauss2_err.b1<gauss2_err.b2
    areaL3 = gauss2_err.a1*gauss2_err.c1*sqrt(pi);
    areaL2 = gauss2_err.a2*gauss2_err.c2*sqrt(pi);
else
    areaL2 = gauss2_err.a1*gauss2_err.c1*sqrt(pi);
    areaL3 = gauss2_err.a2*gauss2_err.c2*sqrt(pi);
end
L32(4) = areaL3/areaL2;
L3(4) = areaL3;
L2(4) = areaL2;

test_data(1).y = 4/L3(2)*test_data(1).y;