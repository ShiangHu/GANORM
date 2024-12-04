%% 跨站点验证-BrainLata

clear;clc
%% 导入常模
load('\data\norm_net.mat')

% MNCS数据
load('\data\predata\all_easy.mat')
for i = 1:length(all_easy)
    age_mncs(1,i) = round(all_easy(i).age);
    mean_mae_mncs(i) = mean(mean(abs(all_easy(i).band_coh(:,:,3) - indow(norm_net(round(all_easy(i).age)-4,:)))));
end

% HY-AHU数据
load('\data\predata\HY-AHU.mat')
for i = 1:length(all_qiang)
    age_qiang(i) = all_qiang(i).age;
    mean_mae_qiang(i) = mean(mean(abs(all_qiang(i).alphaband - indow(norm_net(round(all_qiang(i).age)-4,:)))));
end

% Brain AD 数据
load('\data\predata\BrainLata_AD.mat')
%BrainLata_AD = [];
for i = 1:length(BrainLata_AD)
    age_AD(i) = BrainLata_AD(i).age;
    mean_mae_AD(i) = mean(mean(abs(BrainLata_AD(i).alphaband - indow(norm_net(round(BrainLata_AD(i).age)-4,:)))));
end

% Brain bvFTD 数据
load('\data\predata\BrainLata_bvFTD.mat')
% BrainLata_bvFTD = [];
for i = 1:length(BrainLata_bvFTD)
    age_bvFTD(i) = BrainLata_bvFTD(i).age;
    mean_mae_bvFTD(i) = mean(mean(abs(BrainLata_bvFTD(i).alphaband - indow(norm_net(round(BrainLata_bvFTD(i).age)-4,:)))));
end

% Brain PD 数据
load('\data\predata\BrainLata_PD.mat')
% BrainLata_PD = [];
for i = 1:length(BrainLata_PD)
    age_PD(i) = BrainLata_PD(i).age;
    mean_mae_PD(i) = mean(mean(abs(BrainLata_PD(i).alphaband - indow(norm_net(round(BrainLata_PD(i).age)-4,:)))));
end

% Brain MS 数据
load('\data\predata\BrainLata_MS.mat')
% BrainLata_MS = [];
for i = 1:length(BrainLata_MS)
    age_MS(i) = BrainLata_MS(i).age;
    mean_mae_MS(i) = mean(mean(abs(BrainLata_MS(i).alphaband - indow(norm_net(round(BrainLata_MS(i).age)-4,:)))));
end

% Brain HC 数据
load('\data\predata\BrainLata_HC.mat')
%BrainLata_HC = [];
for i = 1:length(BrainLata_HC)
    age_HC(i) = BrainLata_HC(i).age;
    mean_mae_HC(i) = mean(mean(abs(BrainLata_HC(i).alphaband - indow(norm_net(round(BrainLata_HC(i).age)-4,:)))));
end

%% 绝对误差
% 平均水平
% 平均数据
mean_mncs = mean(mean_mae_mncs)
mean_hyAHU = mean(mean_mae_qiang)
mean_hc = mean(mean_mae_HC)
mean_ad = mean(mean_mae_AD)
mean_bvftd = mean(mean_mae_bvFTD)
mean_pd = mean(mean_mae_PD)
mean_ms = mean(mean_mae_MS)
% 作图
figure(1)
subplot(7,1,1)
histogram(mean_mae_mncs,[0 0:0.02:0.5 2],'Normalization','probability');
title('MNCS')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_mncs,mean_mncs],ylim,'r-','LineWidth',1.5)
text(mean_mncs,0.45,num2str(mean_mncs))
subplot(7,1,2)
histogram(mean_mae_HC,[0 0:0.02:0.5 2],'Normalization','probability');
title('HC')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_hc,mean_hc],ylim,'r-','LineWidth',1.5)
text(mean_hc,0.45,num2str(mean_hc))
subplot(7,1,3)
histogram(mean_mae_qiang,[0 0:0.02:0.5 2],'Normalization','probability');
title('HY-AHU')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_hyAHU,mean_hyAHU],ylim,'r-','LineWidth',1.5)
text(mean_hyAHU,0.45,num2str(mean_hyAHU))
subplot(7,1,4)
histogram(mean_mae_AD,[0 0:0.02:0.5 2],'Normalization','probability');
title('AD')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_ad,mean_ad],ylim,'r-','LineWidth',1.5)
text(mean_ad,0.45,num2str(mean_ad))
subplot(7,1,5)
histogram(mean_mae_bvFTD,[0 0:0.02:0.5 2],'Normalization','probability');
title('bvFTD')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_bvftd,mean_bvftd],ylim,'r-','LineWidth',1.5)
text(mean_bvftd,0.45,num2str(mean_bvftd))
subplot(7,1,6)
histogram(mean_mae_PD,[0 0:0.02:0.5 2],'Normalization','probability');
title('PD')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_pd,mean_pd],ylim,'r-','LineWidth',1.5)
text(mean_pd,0.45,num2str(mean_pd))
subplot(7,1,7)
histogram(mean_mae_MS,[0 0:0.02:0.5 2],'Normalization','probability');
title('MS')
ylim([0 0.5])
xlim([0 0.4])
hold on
plot([mean_ms,mean_ms],ylim,'r-','LineWidth',1.5)
text(mean_ms,0.45,num2str(mean_ms))




%个体水平
figure(2)
scatter(log(age_mncs(509:end)),mean_mae_mncs(509:end),'b.');
hold on;
scatter(log(age_AD),mean_mae_AD,'r.');
hold on;
scatter(log(age_bvFTD),mean_mae_bvFTD,'r*');
hold on;
scatter(log(age_PD),mean_mae_PD,'r+');
hold on;
scatter(log(age_MS),mean_mae_MS,'rx');
hold on;
scatter(log(age_HC),mean_mae_HC,'go');
hold on;
scatter(log(age_qiang),mean_mae_qiang,'g.');
legend('MN-CS','BrainLat-AD','BrainLat-bvFTD','BrainLat-PD','BrainLat-MS','BrainLat-HC','HY-AHU')
xlabel("Age")
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])
ylabel('Erro')



%% 网络属性
% 常模属性
 thr = 0.5;  %% cal_network_feature函数内没使用阈值化矩阵
 for i = 1:size(norm_net,1)
     [charpath_norm(i),eglob_norm(i),...
         cluster_norm(i),eloc_norm(i),modularity_norm(i),...
         betweenness_norm(i),participation_norm(i)] = cal_network_feature(indow(norm_net(i,:)),thr);
 end

% mn属性
 thr = 0.5;  %% cal_network_feature函数内没使用阈值化矩阵
 for i = 1:length(all_easy)
     [charpath_mncs(i),eglob_mncs(i),...
         cluster_mncs(i),eloc_mncs(i),modularity_mncs(i),...
         betweenness_mncs(i),participation_mncs(i)] = cal_network_feature(all_easy(i).band_coh(:,:,3),thr);
 end

% ahu-qiang属性
for i = 1:length(all_qiang)
     charpath_qiang(i) = all_qiang(i).charpath;
     eglob_qiang(i) = all_qiang(i).eglob;
     cluster_qiang(i) = all_qiang(i).cluster;
     eloc_qiang(i) = all_qiang(i).eloc;
     modularity_qiang(i) = all_qiang(i).modularity;
     betweenness_qiang(i) = all_qiang(i).betweenness;
     participation_qiang(i) = all_qiang(i).participation;
end


% HC属性
for i = 1:length(BrainLata_HC)
     charpath_HC(i) = BrainLata_HC(i).charpath;
     eglob_HC(i) = BrainLata_HC(i).eglob;
     cluster_HC(i) = BrainLata_HC(i).cluster;
     eloc_HC(i) = BrainLata_HC(i).eloc;
     modularity_HC(i) = BrainLata_HC(i).modularity;
     betweenness_HC(i) = BrainLata_HC(i).betweenness;
     participation_HC(i) = BrainLata_HC(i).participation;
end

% AD属性
for i = 1:length(BrainLata_AD)
     charpath_AD(i) = BrainLata_AD(i).charpath;
     eglob_AD(i) = BrainLata_AD(i).eglob;
     cluster_AD(i) = BrainLata_AD(i).cluster;
     eloc_AD(i) = BrainLata_AD(i).eloc;
     modularity_AD(i) = BrainLata_AD(i).modularity;
     betweenness_AD(i) = BrainLata_AD(i).betweenness;
     participation_AD(i) = BrainLata_AD(i).participation;
end

% bvFTD属性
for i = 1:length(BrainLata_bvFTD)
     charpath_bvFTD(i) = BrainLata_bvFTD(i).charpath;
     eglob_bvFTD(i) = BrainLata_bvFTD(i).eglob;
     cluster_bvFTD(i) = BrainLata_bvFTD(i).cluster;
     eloc_bvFTD(i) = BrainLata_bvFTD(i).eloc;
     modularity_bvFTD(i) = BrainLata_bvFTD(i).modularity;
     betweenness_bvFTD(i) = BrainLata_bvFTD(i).betweenness;
     participation_bvFTD(i) = BrainLata_bvFTD(i).participation;
end

% PD属性
for i = 1:length(BrainLata_PD)
     charpath_PD(i) = BrainLata_PD(i).charpath;
     eglob_PD(i) = BrainLata_PD(i).eglob;
     cluster_PD(i) = BrainLata_PD(i).cluster;
     eloc_PD(i) = BrainLata_PD(i).eloc;
     modularity_PD(i) = BrainLata_PD(i).modularity;
     betweenness_PD(i) = BrainLata_PD(i).betweenness;
     participation_PD(i) = BrainLata_PD(i).participation;
end

% MS属性
for i = 1:length(BrainLata_MS)
     charpath_MS(i) = BrainLata_MS(i).charpath;
     eglob_MS(i) = BrainLata_MS(i).eglob;
     cluster_MS(i) = BrainLata_MS(i).cluster;
     eloc_MS(i) = BrainLata_MS(i).eloc;
     modularity_MS(i) = BrainLata_MS(i).modularity;
     betweenness_MS(i) = BrainLata_MS(i).betweenness;
     participation_MS(i) = BrainLata_MS(i).participation;
end

  
% 画图
age_norm = 5:85;

% 网络属性图
figure(1)
subplot(3,3,1)
scatter(log(age_mncs(509:end)),charpath_mncs(509:end),'b.')
hold on
scatter(log(age_AD),charpath_AD,'r.')
hold on
scatter(log(age_bvFTD),charpath_bvFTD,'r*')
hold on
scatter(log(age_PD),charpath_PD,'r+')
hold on
scatter(log(age_MS),charpath_MS,'rx')
hold on
scatter(log(age_HC),charpath_HC,'go')
hold on
scatter(log(age_qiang),charpath_qiang,'g.')
hold on
plot(log(age_norm(14:end)),charpath_norm(14:end),'g','LineWidth', 2)
title('CPL')
ylim([0 4])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])

subplot(3,3,2)
scatter(log(age_mncs(509:end)),eglob_mncs(509:end),'b.')
hold on
scatter(log(age_AD),eglob_AD,'r.')
hold on
scatter(log(age_bvFTD),eglob_bvFTD,'r*')
hold on
scatter(log(age_PD),eglob_PD,'r+')
hold on
scatter(log(age_MS),eglob_MS,'rx')
hold on
scatter(log(age_HC),eglob_HC,'go')
hold on
scatter(log(age_qiang),eglob_qiang,'g.')
hold on
plot(log(age_norm(14:end)),eglob_norm(14:end),'g','LineWidth', 2)
title('GE')
ylim([0 1])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])

subplot(3,3,4)
scatter(log(age_mncs(509:end)),cluster_mncs(509:end),'b.')
hold on
scatter(log(age_AD),cluster_AD,'r.')
hold on
scatter(log(age_bvFTD),cluster_bvFTD,'r*')
hold on
scatter(log(age_PD),cluster_PD,'r+')
hold on
scatter(log(age_MS),cluster_MS,'rx')
hold on
scatter(log(age_HC),cluster_HC,'go')
hold on
scatter(log(age_qiang),cluster_qiang,'g.')
hold on
plot(log(age_norm(14:end)),cluster_norm(14:end),'g','LineWidth', 2)
title('CC')
ylim([0 1])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])

subplot(3,3,5)
scatter(log(age_mncs(509:end)),eloc_mncs(509:end),'b.')
hold on
scatter(log(age_AD),eloc_AD,'r.')
hold on
scatter(log(age_bvFTD),eloc_bvFTD,'r*')
hold on
scatter(log(age_PD),eloc_PD,'r+')
hold on
scatter(log(age_MS),eloc_MS,'rx')
hold on
scatter(log(age_HC),eloc_HC,'go')
hold on
scatter(log(age_qiang),eloc_qiang,'g.')
hold on
plot(log(age_norm(14:end)),eloc_norm(14:end),'g','LineWidth', 2)
title('LE')
ylim([0 1])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])

subplot(3,3,6)
scatter(log(age_mncs(509:end)),modularity_mncs(509:end),'b.')
hold on
scatter(log(age_AD),modularity_AD,'r.')
hold on
scatter(log(age_bvFTD),modularity_bvFTD,'r*')
hold on
scatter(log(age_PD),modularity_PD,'r+')
hold on
scatter(log(age_MS),modularity_MS,'rx')
hold on
scatter(log(age_HC),modularity_HC,'go')
hold on
scatter(log(age_qiang),modularity_qiang,'g.')
hold on
plot(log(age_norm(14:end)),modularity_norm(14:end),'g','LineWidth', 2)
title('M')
ylim([0 0.5])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])

subplot(3,3,7)
scatter(log(age_mncs(509:end)),participation_mncs(509:end),'b.')
hold on
scatter(log(age_AD),participation_AD,'r.')
hold on
scatter(log(age_bvFTD),participation_bvFTD,'r*')
hold on
scatter(log(age_PD),participation_PD,'r+')
hold on
scatter(log(age_MS),participation_MS,'rx')
hold on
scatter(log(age_HC),participation_HC,'go')
hold on
scatter(log(age_qiang),participation_qiang,'g.')
hold on
plot(log(age_norm(14:end)),participation_norm(14:end),'g','LineWidth', 2)
title('PC')
ylim([0 1])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])

subplot(3,3,8)
scatter(log(age_mncs(509:end)),betweenness_mncs(509:end),'b.')
hold on
scatter(log(age_AD),betweenness_AD,'r.')
hold on
scatter(log(age_bvFTD),betweenness_bvFTD,'r*')
hold on
scatter(log(age_PD),betweenness_PD,'r+')
hold on
scatter(log(age_MS),betweenness_MS,'rx')
hold on
scatter(log(age_HC),betweenness_HC,'go')
hold on
scatter(log(age_qiang),betweenness_qiang,'g.')
hold on
plot(log(age_norm(14:end)),betweenness_norm(14:end),'g','LineWidth', 2)
title('BC')
legend('MN-CS','BrainLata-AD','BrainLata-bvFTD','BrainLata-PD','BrainLata-MS','BrainLata-HC','HY-AHU')
ylim([0 50])
set(gca,'xtick',1.6:0.4:4.5)
xticklabels(["5", " ", " ", "18", "25", "35", "55","85"])