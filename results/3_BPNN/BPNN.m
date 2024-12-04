
%% CNN神经网络回归，年龄预测
% function [fa] = BPNN(indata,outdata)
clc;clear
load('\data\fa.mat')
load('\data\predata\all_easy.mat')
indata = fa;
outdata = all_easy;

%% 输入
%% 1AGE,2CPL,3GE,4CC,5LE,6M,7BC,8PC
for i = 1:length(indata)
    % log年龄      归一化
    alpha(1,i) = (log(indata(i).age))/(log(100)-log(5));
    alpha(2,i) = (indata(i).charpath(3))/(2-0);
    alpha(3,i) = indata(i).eglob(3);
    alpha(4,i) = indata(i).cluster(3);
    alpha(5,i) = indata(i).eloc(3);
    alpha(6,i) = indata(i).modularity(3);
    alpha(7,i) = (indata(i).betweenness(3))/(50-0);
    alpha(8,i) = indata(i).participation(3);
end
input = alpha;

%% 输出
for i=1:length(outdata)
    output(:,i) = dow(outdata(i).band_coh(:,:,3));
end

%% 相关性（中间层神经元数量）
[n2] = num_neru([ input ; output ]);

%% K-fold Cross Validation  k折交叉验证  CV
% 1.将所有数据集分成5份
% 2.不重复地每次取其中一份做测试集，用其他四份做训练集训练模型，之后计算该模型在测试集上的MSE
% 3.将5次的MSE取平均得到最后的MSE
k = 5;%k折
indices = crossvalind('Kfold', size(input,2), k);%将数据样本随机分割为k部分

for i = 1:k    %循环k次，分别取出第i部分作为测试样本，其余k-1部分作为训练样本
    % 划分训练集和测试集
    test = (indices == i);
    trai = ~test;
    x_train = input(: , trai)';
    y_train = output(: , trai)';

    x_test = input(: , test)';
    y_test = output(: , test)';

    %% 构造网络结构
    % Peng H, Gong W, Beckmann C F, et al. Accurate brain age prediction with lightweight deep neural networks[J]. Medical image analysis, 2021, 68: 101871.
    layers = [
        featureInputLayer(size(x_train,2),"Name","featureinput")
        fullyConnectedLayer(round(size(x_train,2)*size(output,1)),"Name","fc_1")
        reluLayer("Name","relu_1")
        fullyConnectedLayer(round(n2),"Name","fc_2")
%         fullyConnectedLayer(200,"Name","fc_2")
        reluLayer("Name","relu_2")
        fullyConnectedLayer(size(output,1),"Name","fc_3")
        regressionLayer("Name","regressionoutput")];

    %% 参数设置
    options = trainingOptions('adam',...
        'MiniBatchSize',20,...
        'MaxEpochs',50,...
        'InitialLearnRate',1e-2,...
        'LearnRateSchedule','piecewise',...
        'LearnRateDropFactor',0.5,...
        'LearnRateDropPeriod',200,...
        'Shuffle','every-epoch',...
        'Plots','training-progress',...
        'Verbose',false);

    %% 训练模型
    net = trainNetwork(x_train,y_train,layers,options);

    %% 模型预测
    y_sim1 = predict(net,x_train);
    y_sim2 = predict(net,x_test);

    % R2
    R1(i) = 1-norm(y_train - y_sim1)^2 / norm(y_train - mean(y_train))^2;
    R2(i) = 1-norm(y_test - y_sim2)^2 / norm(y_test - mean(y_test))^2;

    % MAE
    mae1(i) = mean(mean(abs(y_sim1 - y_train)));
    mae2(i) = mean(mean(abs(y_sim2 - y_test)));

    % 均方根误差
    rmse1(i) = mean(sqrt(mean(y_sim1 - y_train).^2));
    rmse2(i) = mean(sqrt(mean(y_sim2 - y_test ).^2));

    disp(['第',num2str(i),'次：','训练数据的R2为',num2str(R1(i)),';','测试数据的R2为',num2str(R2(i))])
    disp(['第',num2str(i),'次：','训练数据的MAE为',num2str(mae1(i)),';','测试数据的MAE为',num2str(mae2(i))])
    disp(['第',num2str(i),'次：','训练数据的RMSE为',num2str(rmse1(i)),';','测试数据的RMSE为',num2str(rmse2(i))])
end
% %% 绘制网格分析图
% analyzeNetwork(layers)
disp([num2str(k),'次训练数据的平均R2为',num2str(mean(R1)),num2str(k),'次测试数据的平均R2为',num2str(mean(R2))])
disp([num2str(k),'次训练数据的平均MAE为',num2str(mean(mae1)),num2str(k),'次测试数据的平均MAE为',num2str(mean(mae2))])
disp([num2str(k),'次训练数据的平均RMSE为',num2str(mean(rmse1)),num2str(k),'次测试数据的平均RMSE为',num2str(mean(rmse2))])

%% 指标统计
% 训练
disp(['训练数据R2：',num2str(mean(R1)),'±',num2str(max(R1-mean(R1)))])
% 测试
disp(['测试数据R2：',num2str(mean(R2)),'±',num2str(max(R2-mean(R2)))])

% 训练
disp(['训练数据MAE：',num2str(mean(mae1)),'±',num2str(max(mae1-mean(mae1)))])
% 测试
disp(['测试数据MAE：',num2str(mean(mae2)),'±',num2str(max(mae2-mean(mae2)))])

% 训练
disp(['训练数据RMSE：',num2str(mean(rmse1)),'±',num2str(max(rmse1-mean(rmse1)))])
% 测试
disp(['测试数据RMSE：',num2str(mean(rmse2)),'±',num2str(max(rmse2-mean(rmse2)))])
