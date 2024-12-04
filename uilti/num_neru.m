function [n] = num_neru(data)
% data = [input ; output];

% 求维度之间的相关系数
[rho,p] = corr(data', 'type','pearson');
rho = abs(rho);
s = abs(rho(1:8,:));
n = sum(sum(s>0.6))-8;

s_cor = abs(rho(1:8,9:end));
s_p = abs(p(1:8,9:end));

%% 个数统计图
% figure(1)
% h = histogram(s_cor(:,9:end),[0:0.1:1]);
% h.FaceColor = [0.53,0.84,0.84];
% h.EdgeColor = [0.65,0.65,0.65];
% h.FaceAlpha = 0.4;
% set(gca, 'FontSize', 14);

% nu = 0;
% for i=1:size(s_p,1)
%     for j = 1:size(s_p,2)
%         if s_cor(i,j)>=0.6 && s_p(i,j)<=0.05
%             nu = nu+1;
%         end
%     end
% end

% 将相关性小于0.6的置0，显著性大于0.05的置1
for i = 1:size(s_p,1)
    for j = 1:size(s_p,2)
        if(s_p(i,j)>0.05)
            s_p(i,j) = NaN;
        end
        if(s_cor(i,j)<0.6)
            s_cor(i,j) = NaN;
        end

        s_p(i,j) = 1 - s_p(i,j);
    end
end


% 绘制相关性图
name = ["AGE","CPL","GE","CC","LE","M","BC","PC"];

figure(1)
for i = 1:8
    cva = indow(s_cor(i,:));
    pva = indow(s_p(i,:));
    for j = 1:length(cva)
        cva(j,j) = NaN;
        pva(j,j) = NaN;
    end
    Tit = name(i);
    subplot(2,4,i)
    draw_heat_cor(pva,cva,Tit)
end





% 1AGE,2CPL,3GE,4CC,5LE,6M,7BC,8PC
% name = ["AGE","CPL","GE","CC","LE","M","BC","PC"];
% minrho = min(min(rho(:,9:end)));
% maxrho = max(max(rho(:,9:end)));
% 
% minp = min(min(p(:,9:end)));
% maxp = max(max(p(:,9:end)));
% 
% num = 1;
% cva = indow(rho(num,9:end));
% pva = indow(p(num,9:end));
% Tit = name(num);
% figure(num)
% draw_heat_cor(pva,cva,Tit)
% 
% for i = 1:8
%     cva = indow(rho(i,9:end));
%     pva = indow(p(i,9:end));
%     Tit = name(i);
%     subplot(2,4,i)
%     draw_heat_cor(pva,cva,Tit)
% end

% for i = 1:8
%     cva = indow(rho(i,9:end));
%     pva = indow(p(i,9:end));
%     Tit = name(i);
%     figure(i)
%     set(gcf,'Position',[500 500 325 275])
% %     set(gcf,'Position',[500 500 260 220])
%     draw_heat_cor(pva,cva,Tit)
% end















% colormap:https://blog.csdn.net/slandarer/article/details/127719784

% 179*1945
figure(1)
subplot(2,1,1)
imagesc(data(1:8,:))
colormap(slanCM('GnBu'));
axis off
subplot(2,1,2)
imagesc(data(9:end,:))
colormap(slanCM('GnBu'));
axis off

% rho 179*179
figure(2)
subplot(2,2,1)
imagesc(rho(1:8,:))
colormap(slanCM('GnBu'));
axis off
subplot(2,2,4)
imagesc(rho(9:end,:))
colormap(slanCM('GnBu'));
axis off

% p 179*179
figure(3)
subplot(2,2,1)
imagesc(p(1:8,:))
colormap(slanCM('GnBu'));
axis off
subplot(2,2,4)
imagesc(p(9:end,:))
colormap(slanCM('GnBu'));
axis off



% % 统计
% x1 = 0:0.01:1;
% y1 = ones(1,101)*0.05;
% x2 = ones(1,101)*0.6;
% y2 = 0:0.01:1;
% vec_cor = reshape(rho(1:8,9:end),1368,1);
% vec_p = reshape(p(1:8,9:end),1368,1);
% scatter(vec_cor,vec_p,'g.')
% hold on
% plot(x1,y1)
% hold on
% plot(x2,y2)
% xlabel('corr')
% ylabel('p')
% %ylim([0.05 1])
% ylim([0 0.05])
% xlim([0.6 1])
% 
% xege = [-Inf 0:0.1:1 Inf];
% yege = [-Inf 0:0.05:1 Inf];
% figure(2)
% h = histogram2(vec_cor,vec_p,[10 20],'FaceColor','flat','Normalization','probability');
% colormap(slanCM('GnBu'));
% colorbar
% xlabel('corr')
% ylabel('p')



