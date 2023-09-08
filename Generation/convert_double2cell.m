X_Train_c = cell(train_amount,1); Y_Train_c = cell(train_amount,1);
for i = 1:train_amount
    X_Train_c{i} = X_Train(1,:,1,i);
    Y_Train_c{i} = Y_Train(1,:,1,i);
end
X_Validation_c = cell(Validation_amount,1); Y_Validation_c = cell(Validation_amount,1);
for i = 1:Validation_amount
    X_Validation_c{i} = X_Validation(1,:,1,i);
    Y_Validation_c{i} = Y_Validation(1,:,1,i);
end
