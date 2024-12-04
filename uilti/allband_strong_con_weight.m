
%% 取连接较强的电极对进行分析
function [path] = allband_strong_con_weight(re_ww,thr)

%% 阈值化
th_re_w = threshold_absolute(re_ww, thr);
bin_re_w = dthreshold_absolute(th_re_w, thr);

for i = 1:size(bin_re_w,3)
    for j = 1:size(bin_re_w,1)
        num_zero(j,i) = length(find(bin_re_w(j,:,i)==0));
    end
end

th_delta = re_ww(find(num_zero(:,1)<size(bin_re_w,2)*0.7),:,1);
th_delta_cha = xtl(find(num_zero(:,1)<size(bin_re_w,2)*0.7));
d1=d(find(num_zero(:,1)<size(bin_re_w,2)*0.7));

th_theta = re_ww(find(num_zero(:,2)<size(bin_re_w,2)*0.7),:,2);
th_theta_cha = xtl(find(num_zero(:,2)<size(bin_re_w,2)*0.7));
d2=d(find(num_zero(:,2)<size(bin_re_w,2)*0.7));

th_alpha = re_ww(find(num_zero(:,3)<size(bin_re_w,2)*0.7),:,3);
th_alpha_cha = xtl(find(num_zero(:,3)<size(bin_re_w,2)*0.7));
d3=d(find(num_zero(:,3)<size(bin_re_w,2)*0.7));

th_lowbeta = re_ww(find(num_zero(:,4)<size(bin_re_w,2)*0.7),:,4);
th_lowbeta_cha = xtl(find(num_zero(:,4)<size(bin_re_w,2)*0.7));
d4=d(find(num_zero(:,4)<size(bin_re_w,2)*0.7));

path = 'D:\matlab\long\1118\result\allband_strong_con_weight';
% mkdir(path) %创建名为a图片库t的文件夹

% %画四个频带下的imagesc
% figure(1)
% imagesc(th_delta)
% colorbar
% caxis([0 1]);
% title('delta频带下部分脑网络连接变化','FontSize',22)
% xlabel('年龄','FontSize',22)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',22)
% yticks(1:length(th_delta_cha))
% yticklabels(th_delta_cha)
% set (gca, 'FontSize', 19)
% saveas(gcf,[path,'\','th_delta','.fig']);
% 
% figure(2)
% imagesc(th_theta)
% colorbar
% caxis([0 1]);
% title('theta频带下部分脑网络连接变化','FontSize',20)
% xlabel('年龄','FontSize',20)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',20)
% yticks(1:length(th_theta_cha))
% yticklabels(th_theta_cha)
% set (gca, 'FontSize', 19)
% saveas(gcf,[path,'\','th_theta','.fig']);
% 
% figure(3)
% imagesc(th_alpha)
% colorbar
% caxis([0 1]);
% title('alpha频带下部分脑网络连接变化','FontSize',20)
% xlabel('年龄','FontSize',20)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',20)
% yticks(1:length(th_alpha_cha))
% yticklabels(th_alpha_cha)
% set (gca, 'FontSize', 19)
% saveas(gcf,[path,'\','th_alpha','.fig']);
% 
% figure(4)
% imagesc(th_lowbeta)
% colorbar
% caxis([0 1]);
% title('lowbeta频带下部分脑网络连接变化','FontSize',20)
% xlabel('年龄','FontSize',20)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',20)
% yticks(1:length(th_lowbeta_cha))
% yticklabels(th_lowbeta_cha)
% set (gca, 'FontSize', 19)
% saveas(gcf,[path,'\','th_lowbeta','.fig']);
% 
% figure(5)
% sgtitle('各频带下较强连接电极对随年龄的变化')
% subplot(2,2,1)
% imagesc(th_delta)
% colorbar
% caxis([0 1]);
% title('delta','FontSize',15)
% xlabel('年龄','FontSize',15)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',15)
% yticks(1:length(th_delta_cha))
% yticklabels(th_delta_cha)
% 
% subplot(2,2,2)
% imagesc(th_theta)
% colorbar
% caxis([0 1]);
% title('theta','FontSize',15)
% xlabel('年龄','FontSize',15)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',15)
% yticks(1:length(th_theta_cha))
% yticklabels(th_theta_cha)
% 
% subplot(2,2,3)
% imagesc(th_alpha)
% colorbar
% caxis([0 1]);
% title('alpha','FontSize',15)
% xlabel('年龄','FontSize',15)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',15)
% yticks(1:length(th_alpha_cha))
% yticklabels(th_alpha_cha)
% 
% subplot(2,2,4)
% imagesc(th_lowbeta)
% colorbar
% caxis([0 1]);
% title('lowbeta','FontSize',15)
% xlabel('年龄','FontSize',15)
% xticks(1:2:77)
% xticklabels(5:2:80)
% ylabel('电极-电极','FontSize',15)
% yticks(1:length(th_lowbeta_cha))
% yticklabels(th_lowbeta_cha)
% saveas(gcf,[path,'\','allband_coh','.fig']);
