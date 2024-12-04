%% 所需结果及图

clear;clc;
%% 载入数据
load('\data\predata\all_easy.mat')
[~,index] = sortrows([all_easy.age].'); all_easy = all_easy(index); clear index  %%%排序
all_easy(1946:1949)=[];     %%去掉了85岁以上的数据

%% 分频带求平均得到各被试频带内coh
% all_easy(i).band_coh(:,:,1)   1-6   1.17-3.12Hz    Delta
% all_easy(i).band_coh(:,:,2)   7-18  3.51-7.81      Theta
% all_easy(i).band_coh(:,:,3)   20-29  8.20-12.1     Alpha
% all_easy(i).band_coh(:,:,4)   30-47  12.5-19.14    Lowbeta
for i = 1:length(all_easy)
    all_easy(i).band_coh(:,:,1) = mean(all_easy(i).pre_coh(:,:,1:6),3);
    all_easy(i).band_coh(:,:,2) = mean(all_easy(i).pre_coh(:,:,7:18),3);
    all_easy(i).band_coh(:,:,3) = mean(all_easy(i).pre_coh(:,:,19:29),3);
    all_easy(i).band_coh(:,:,4) = mean(all_easy(i).pre_coh(:,:,30:47),3);
end

%% 按年龄分组
%%按年龄分组
age_begin = 5;
age_end = 85;
[age_group,agenum] = age_groupp(age_begin,age_end,all_easy);

%% 作图——各频带下脑网络随年龄的变化规律
% draw_age_band_network(age_group);

%% 网络拓扑属性分析
% 计算网络属性并回归
% [fa] = all_people_feature(all_easy);

% %% 神经网络建模
% BPNN(fa)
