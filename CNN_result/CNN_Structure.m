layers1 = [
    imageInputLayer([1 2001 1])
    convolution2dLayer([1 11],32,'Stride',2,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([1 3],'Stride',2)    
    convolution2dLayer([1 11],32,'Stride',2,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([1 3],'Stride',1)  
    convolution2dLayer([1 11],32,'Stride',1,'Padding','same')
    batchNormalizationLayer
    reluLayer
    dropoutLayer(0.2)
    fullyConnectedLayer(100)
    %batchNormalizationLayer
    %% 
    leakyReluLayer   
    dropoutLayer(0.2)
    fullyConnectedLayer(200)
    %batchNormalizationLayer
    leakyReluLayer   
    dropoutLayer(0.2)
    fullyConnectedLayer(256)
    %batchNormalizationLayer
    leakyReluLayer  
    dropoutLayer(0.2)
    fullyConnectedLayer(1)
    sigmoidLayer
    regressionLayer
    ];

analyzeNetwork(layers1);

layers = [
    imageInputLayer([1 2001 1],"Normalization","none")
    convolution2dLayer([1 13],64)
    leakyReluLayer
    dropoutLayer(0.1)
    maxPooling2dLayer([1 2])    
    
    convolution2dLayer([1 13],64)
    leakyReluLayer
    dropoutLayer(0.1)
    maxPooling2dLayer([1 2]) 
    
    convolution2dLayer([1 7],64)
    leakyReluLayer
    dropoutLayer(0.1)
    maxPooling2dLayer([1 2]) 

    fullyConnectedLayer(512)
    leakyReluLayer
    dropoutLayer(0.1)
       
    fullyConnectedLayer(256)
    leakyReluLayer   
    dropoutLayer(0.1)

    fullyConnectedLayer(1)
    sigmoidLayer
    regressionLayer
    ];

analyzeNetwork(layers);