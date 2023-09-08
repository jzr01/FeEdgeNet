X_Train1 = zeros(1,1851,1,1000000);
for i = 1:length(X_Train)
    X_Train1(1,:,1,i) = interp1(698:0.1:735,X_Train(1,:,1,i),698:0.02:735,'linear');
end

X_Validation1 = zeros(1,1851,1,200000);
for i = 1:length(X_Validation)
    X_Validation1(1,:,1,i) = interp1(698:0.1:735,X_Validation(1,:,1,i),698:0.02:735,'linear');
end