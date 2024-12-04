%% 画出各频带所有电极对连接随年龄的变化
function [] = allband_allchannel(re_ww,thr)

%% 阈值化
th_re_w = threshold_absolute(re_ww, thr);
bin_re_w = dthreshold_absolute(th_re_w, thr);

% 画
figure(1)
imagesc(re_ww(:,:,1))
colorbar
caxis([0 1]);
title('各年龄下加权脑网络的向量化形式','FontSize',15)
xlabel('年龄')
xticks(1:5:77)
xticklabels(5:5:80)
ylabel('电极-电极')
yticks(1:10:length(xtl))
yticklabels(xtl(1:10:end))

% % 转置
% figure(2)
% imagesc(re_w')
% axis xy;
% % title('各年龄下加权脑网络的向量化形式')
% % xlabel('年龄')
% yticks(1:5:77)
% yticklabels(5:5:80)
% % ylabel('电极-电极')
% xticks(1:length(xtl))
% xticklabels(xtl)
% set(gca,'FontName','Times New Roman','FontSize',5)     %设置坐标轴刻度字体名称，大小

