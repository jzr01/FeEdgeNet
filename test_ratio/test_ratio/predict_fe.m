fe = readmatrix("Fe3O4_test.txt");
fe(:,2) = fe(:,2) -min(fe(:,2));
s = fe(1,2);
xs = fe(1,1);
xe = fe(end,1);
e = fe(end,2);
en = 695:0.02:735;
fe = interp1(fe(:,1),fe(:,2),en,'linear','extrap');
fe(en <= xs) = s;
fe(en >= xe) = e;
plot(en,fe);

fe = (fe - mean(fe))/std(fe);
test_data(41).data = fe;
w = predict(cnn_lstm_2,fe);