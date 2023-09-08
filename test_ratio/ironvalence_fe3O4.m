close all
% fe2 = importdata("FeO.txt");
% fe3 = importdata("Fe2O3.txt");
% fe = importdata("Fe3O4.txt");
% 
% en = 701:0.02:729;
% fe2_new = interp1(fe2(:,1),fe2(:,2),en,'linear');
% fe_new = interp1(fe(:,1),fe(:,2),en,'linear');
% fe3_new = interp1(fe3(:,1),fe3(:,2),en,'linear');
% 
% fe_new = fe_new -min(fe_new);
% fe2_new = fe2_new -min(fe2_new);
% fe3_new = fe3_new -min(fe3_new);

figure;
plot(en,fe2_new ,'.')
hold on;
plot(en,fe3_new ,'.')
hold on;
plot(en,fe_new,'.')
legend('2+','3+','Fe3O4')



func = @(x) sum((fe_new-x(1).*fe2_new-x(2).*fe3_new).^2)
x0 = [0.5,0.5];
x =  fminsearch(func,x0);

figure;
plot(fe_new,'rs');
hold on;
plot(x(1).*fe2_new);
plot(x(2).*fe3_new);
plot(x(1).*fe2_new+x(2).*fe3_new,'linewidth',2);
legend('Fe3O4','2+','3+','fitted');

w = x(1)/sum(x)

