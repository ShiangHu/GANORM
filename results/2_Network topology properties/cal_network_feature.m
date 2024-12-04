%% 计算网络属性  使用加权的功能连接矩阵
function [charpath,eglob,cluster,eloc,modularity,betweenness,participation]=cal_network_feature(w,thr)

%阈值化
threshold_w = threshold_absolute(w, thr);

%% Measures of integration 网络整合的度量
% Characteristic path length 特征路径长度
% spl为最短路径长度矩阵,charpath为特征路径长度
spl = distance_wei_floyd(w,'log');
charpath = mean(mean(spl));

% Global efficiency 全局效率(与特征路径长度呈负相关)
eglob = efficiency_wei(w);

%% Measures of segregation 网络分离的度量
% Clustering coefficient 聚类系数
cluster = mean(clustering_coef_wu(w));

% % Transitivity 传递性（值与聚类系数一样）
% transitivity = transitivity_wu(w);

% Local efficiency 局部效率
eloc = mean(efficiency_wei(w,2));

% Modularity 模块化    Ci:optimal community structure
[ci,modularity]=modularity_und(w);

%% Measures of centrality 中心性度量
% Betweenness centrality 节点介数中心性 平均
betweenness = mean(betweenness_wei(-log(w)));

% Participation coefficient 参与系数
participation = mean(participation_coef(w,ci,0));

% %% Measures of resilience 弹性度量
% % Assortativity coefficient 同配系数(值有问题)
% assortativity = assortativity_wei(w,0);

% %% 小世界性(值有问题)
% ITER = 100; %%不确定  文献The organization of physiological brain networks中，p=1是完全随机网络 p=0.05是小世界网络 p=0规则图
% [r,eff] = randmio_und(w, ITER); %%生成随机网络
% %R = threshold_absolute(r, thr);
% C_rand = mean(clustering_coef_wu(r));
% spl_rand = distance_wei_floyd(r,'log');
% charpath_rand = mean(mean(spl_rand));
% sw = (cluster/C_rand)/(charpath/charpath_rand);



% %% test
% for i=5:85
%     n1=1;
%     for j = 1:length(all_easy)
%         if round(all_easy(j).age)==i
%             group(n1,:)=dow(all_easy(j).pre_coh(:,:,24));
%             n1=n1+1;
%         end
%     end
%     age_group(i-4,1) = i;
%     w = indow(mean(group));
%     %计算特征路径长度
%     spl = distance_wei_floyd(w,'log');
%     age_group(i-4,2) = mean(mean(spl));
%     %计算聚类系数
%     age_group(i-4,3) = mean(clustering_coef_wu(w));
%     %全局效率
%     age_group(i-4,4) = efficiency_wei(w);
%     %局部效率
%     age_group(i-4,5) = mean(efficiency_wei(w,2));  
% end
% plot(age_group(:,1),age_group(:,2),'g',age_group(:,1),age_group(:,3),'c',age_group(:,1),age_group(:,4),'m',age_group(:,1),age_group(:,5),'y','LineWidth',2); %线性，颜色，标记
% % axis([0,18,0,1.9])  %确定x轴与y轴框图大小
% set(gca,'XTick',[5:5:85]) %x轴范围1-6，间隔1
% set(gca,'xticklabels',{'5-10','10-15','15-20','20-25','25-30','30-35','35-40','40-45','45-50','50-55','55-60','60-65','65-70','70-75','75-80','80-85','85-97'})
% legend('charpath','cluster','Eloc','Eglob');   %右上角标注
% xlabel('年龄段')  %x轴坐标描述
% % ylabel('') %y轴坐标描述
% title('网络属性随年龄的变化')