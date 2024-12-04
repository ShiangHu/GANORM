
%% 画四个频带下强连接网络模式
% ww未按电极对间距离大小排序
function [path] = allband_strong_connection_network_photo(ww,thr)

%% 阈值化
th_re_ww = threshold_absolute(ww, thr);
bin_re_ww = dthreshold_absolute(th_re_ww, thr);
% imagesc(bin_re_ww(:,:,1))

%% 取权重大的电极对进行分析
for i = 1:size(bin_re_ww,3)
    for j = 1:size(bin_re_ww,1)
        num_zero(j,i) = length(find(bin_re_ww(j,:,i)==0));
    end
end

vec1 = zeros(size(num_zero,1),1);
vec2 = zeros(size(num_zero,1),1);
vec3 = zeros(size(num_zero,1),1);
vec4 = zeros(size(num_zero,1),1);
vec1(find(num_zero(:,1)<size(bin_re_ww,2)*0.7),1) = ones(length(find(num_zero(:,1)<size(bin_re_ww,2)*0.7)),1);
vec2(find(num_zero(:,2)<size(bin_re_ww,2)*0.7),1) = ones(length(find(num_zero(:,2)<size(bin_re_ww,2)*0.7)),1);
vec3(find(num_zero(:,3)<size(bin_re_ww,2)*0.7),1) = ones(length(find(num_zero(:,3)<size(bin_re_ww,2)*0.7)),1);
vec4(find(num_zero(:,4)<size(bin_re_ww,2)*0.7),1) = ones(length(find(num_zero(:,4)<size(bin_re_ww,2)*0.7)),1);
w1 = indow(vec1);
w2 = indow(vec2);
w3 = indow(vec3);
w4 = indow(vec4);   

figure(1)
% sgtitle('各频带下较强连接脑网络模式')
subplot(2,2,1,'Position',[.12 .48 0.4 0.4])
drawtop_allband(w1,thr)
title('delta')
subplot(2,2,2,'Position',[.48 .48 0.4 0.4])
drawtop_allband(w2,thr)
title('theta')
subplot(2,2,3,'Position',[.12 0 0.4 0.4])
drawtop_allband(w3,thr)
title('alpha')
subplot(2,2,4,'Position',[.48 0 0.4 0.4])
drawtop_allband(w4,thr)
title('lowbeta')
% saveas(gcf,[path,'\','allband','.fig']);

% path = 'D:\matlab\long\1118\result\allband_strong_con';
% % mkdir(pic) %创建名为‘图片库’的文件夹
% figure(1)
% drawtop_allband(w1,thr)
% % saveas(gcf,[path,'\','delta','.fig']);
% 
% figure(2)
% drawtop_allband(w2,thr)
% % saveas(gcf,[path,'\','theta','.fig']);
% 
% figure(3)
% drawtop_allband(w3,thr)
% % saveas(gcf,[path,'\','alpha','.fig']);
% 
% figure(4)
% drawtop_allband(w4,thr)
% % saveas(gcf,[path,'\','lowbeta','.fig']);


