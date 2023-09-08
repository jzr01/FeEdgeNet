fn = fieldnames(test_data);
for k=4:numel(fn)
    loss1 = zeros(2,length(test_data));
    for i = 1:length(test_data)
        loss1(1,i) = -log(1-abs(test_data(i).truth-test_data(i).(fn{k})));
        if abs(test_data(i).truth-test_data(i).(fn{k})) <= 0.1
            loss1(2,i) = 1;
        else
            loss1(2,i) = 0;
        end
    end
    log_loss_list(k-3) = sum(loss1(1,:));
    acc_list(k-3) = sum(loss1(2,:))/length(test_data);

end