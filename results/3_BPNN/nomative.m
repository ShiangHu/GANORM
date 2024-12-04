% function [] = nomative(net)
% 导入数据
A = xlsread('D:\R\R_code\centiles\mat_CPL.xlsx');
B = xlsread('D:\R\R_code\centiles\mat_GE.xlsx');
C = xlsread('D:\R\R_code\centiles\mat_LE.xlsx');
D = xlsread('D:\R\R_code\centiles\mat_CC.xlsx');
E = xlsread('D:\R\R_code\centiles\mat_M.xlsx');
F = xlsread('D:\R\R_code\centiles\mat_BC.xlsx');
G = xlsread('D:\R\R_code\centiles\mat_PC.xlsx');
 
for i = 1:length(A)
    data(1,i) = (log(A(i,1)))/(log(100)-log(5));
    data(2,i) = A(i,4)/(2-0);
    data(3,i) = B(i,4);
    data(4,i) = D(i,4);
    data(5,i) = C(i,4);
    data(6,i) = E(i,4);
    data(7,i) = F(i,4)/(50-0);
    data(8,i) = G(i,4);
end

% 将输入数据放到net中预测
norm_net = predict(net,data');

%% 作图
% 提取作图年龄点
n=1;
% 5 8 11 14 17
for i=1:3:13
    need_draw(n).age = i+4;
    need_draw(n).alpha_coh = indow(norm_net(i,:));
    n=n+1;
end
% 27 37 47 57 67 77
for i=23:10:73
    need_draw(n).age = i+4;
    need_draw(n).alpha_coh = indow(norm_net(i,:));
    n=n+1;
end
% 85
need_draw(n).age = 85;
need_draw(n).alpha_coh = indow(norm_net(81,:));

thr = 0.4;
figure(1)
for i=1:length(need_draw)
    name = num2str(need_draw(i).age);
    %name = [num2str(need_draw(i).age),'\_Alpha'];
    %colorbar;
    %caxis([0.5,1]);
    subplot(2,6,i);
    %drawtop(age_group(i).band_coh(:,:,j),thr);
    %drawtop_allband(need_draw(i).alpha_coh(:,:),thr);
    drawtop(need_draw(i).alpha_coh(:,:),thr);
    title(name);
    set(gca, 'FontSize', 14);
    hold on;
end

% 计算norm网络属性
for i = 1:length(A)
    cha50(1,i) = A(i,1);
    cha50(2,i) = A(i,4);
    cha50(3,i) = B(i,4);
    cha50(4,i) = D(i,4);
    cha50(5,i) = C(i,4);
    cha50(6,i) = E(i,4);
    cha50(7,i) = F(i,4);
    cha50(8,i) = G(i,4);

    w = indow(norm_net(i,:));
    cha_norm(1,i) = A(i,1);

    spl = distance_wei_floyd(w,'log');
    cha_norm(2,i) = mean(mean(spl));

    % Global efficiency 全局效率(与特征路径长度呈负相关)
    cha_norm(3,i) = efficiency_wei(w);

    %% Measures of segregation 网络分离的度量
    % Clustering coefficient 聚类系数
    cha_norm(4,i) = mean(clustering_coef_wu(w));

    % Local efficiency 局部效率
    cha_norm(5,i) = mean(efficiency_wei(w,2));

    % Modularity 模块化    Ci:optimal community structure
    [ci,cha_norm(6,i)]=modularity_und(w);

    %% Measures of centrality 中心性度量
    % Betweenness centrality 节点介数中心性 平均
    cha_norm(7,i) = mean(betweenness_wei(-log(w)));

    % Participation coefficient 参与系数
    cha_norm(8,i) = mean(participation_coef(w,ci,0));
end

% 作图——gamlss50与norm
figure(1)
x = cha50(1,:);
n=2;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('CPL')
xlabel('Age')
ylim([0 2])
set(gca,'FontSize',18);
legend('real','norm')

figure(2)
x = cha50(1,:);
n=3;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('GE')
xlabel('Age')
ylim([0 1])
set(gca,'FontSize',18);
legend('real','norm')


figure(3)
x = cha50(1,:);
n=4;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('CC')
xlabel('Age')
ylim([0 1])
set(gca,'FontSize',18);
legend('real','norm')

figure(4)
x = cha50(1,:);
n=5;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('LE')
xlabel('Age')
ylim([0 1])
set(gca,'FontSize',18);
legend('real','norm')


figure(5)
x = cha50(1,:);
n=6;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('M')
xlabel('Age')
ylim([0 1])
set(gca,'FontSize',18);
legend('real','norm')

figure(6)
x = cha50(1,:);
n=7;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('BC')
xlabel('Age')
ylim([0 50])
set(gca,'FontSize',18);
legend('real','norm')

figure(7)
x = cha50(1,:);
n=8;
R = 1-norm(cha50(n,:) - cha_norm(n,:))^2 / norm(cha50(n,:) - mean(cha50(n,:)))^2;
plot(x,cha50(n,:),'r',x,cha_norm(n,:),'b','LineWidth', 3)
title('PC')
xlabel('Age')
ylim([0 1])
set(gca,'FontSize',18);
legend('real','norm')

