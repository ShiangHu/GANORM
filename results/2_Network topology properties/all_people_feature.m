function [fa] = all_people_feature(data)

%fa为几个网络属性四个频带下的值
for i = 1:length(data)
    disp(num2str(i));
    thr = 0.5;  %% cal_network_feature函数内没使用阈值化矩阵
    for j = 1:4
        [charpath(j),eglob(j),...
         cluster(j),eloc(j),modularity(j),...
         betweenness(j),participation(j)]=cal_network_feature(data(i).band_coh(:,:,j),thr);
    end
    % 整合
    fa(i).country = data(i).country;
    fa(i).sex = data(i).sex;
    fa(i).age = data(i).age;
    fa(i).charpath = charpath;
    fa(i).eglob = eglob;
    % 分离
    fa(i).cluster = cluster;
    %fa(i).transitivity = transitivity;
    fa(i).eloc = eloc;
    fa(i).modularity = modularity;
    % 中心性
    fa(i).betweenness = betweenness;
    fa(i).participation = participation;
    % 弹性
    %fa(i).assortativity = assortativity;
%    fa(i).sw = sw;
end

country=zeros(length(fa),1);
sex = zeros(length(fa),1);
country = string(country);
sex = string(sex);
for i = 1:length(fa)
    age(i) = fa(i).age;
    country(i) =fa(i).country;
    sex(i) = fa(i).sex;
    

    cha(i,:) = fa(i).charpath;
    egl(i,:) = fa(i).eglob;

    clu(i,:) = fa(i).cluster;
    elo(i,:) = fa(i).eloc;
    modu(i,:) = fa(i).modularity;

    bet(i,:) = fa(i).betweenness;
    parti(i,:) = fa(i).participation;
end
%% 保存
xlswrite('\results\3_Network topology properties\feature_results\age.xlsx',age);
xlswrite('\results\3_Network topology properties\feature_results\country.xlsx',country);
xlswrite('\results\3_Network topology properties\feature_results\sex.xlsx',sex);

xlswrite('\results\3_Network topology properties\feature_results\cha.xlsx',cha);
xlswrite('\results\3_Network topology properties\feature_results\egl.xlsx',egl);

xlswrite('\results\3_Network topology properties\feature_results\clu.xlsx',clu);
xlswrite('\results\3_Network topology properties\feature_results\elo.xlsx',elo);
xlswrite('\results\3_Network topology properties\feature_results\modu.xlsx',modu);

xlswrite('\results\3_Network topology properties\feature_results\bet.xlsx',bet);
xlswrite('\results\3_Network topology properties\feature_results\parti.xlsx',parti);


%  n项式
n = 2;
% x的尺度
xx = log(age);

% 拟合x的点
x_fit = xx;

%% 整合
figure(1)
for j = 1:2
    for i=1:4
        switch j
            case 1
                subplot(4,2,1+(i-1)*2)
                scatter(xx,cha(:,i),'.')
                hold on;

                [p,s] = polyfit(xx,cha(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(2,2.8,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- cha(:,i)').^2) / sum((cha(:,i)' - mean(cha(:,i))).^2));
                text(2,2.4,sprintf("           R2       : %.4f",r2))
                legend('Charpath','Fitted Curve','95% Prediction Interval')
                ylim([0 3])
                xlabel('log(Age)')
            case 2
                subplot(4,2,2+(i-1)*2)
                scatter(xx,egl(:,i),'.')
                hold on;

                [p,s] = polyfit(xx,egl(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(2,0.75,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- egl(:,i)').^2) / sum((egl(:,i)' - mean(egl(:,i))).^2));
                text(2,0.65,sprintf("           R2       : %.4f",r2))
                legend('Eglob','Fitted Curve','95% Prediction Interval')
                ylim([0 0.8])
                xlabel('log(Age)')
        end
    end
end

%% 分离
figure(2)
for j = 1:3
    for i=1:4
        switch j
            case 1
                subplot(4,3,1+(i-1)*3)
                scatter(xx,clu(:,i),'.')
                hold on;

                [p,s] = polyfit(xx,clu(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(1.7,0.7,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- clu(:,i)').^2) / sum((clu(:,i)' - mean(clu(:,i))).^2));
                text(1.7,0.62,sprintf("           R2       : %.4f",r2))
                legend('Cluster','Fitted Curve','95% Prediction Interval')
                ylim([0 .8])
                xlabel('log(Age)')
            case 2
                subplot(4,3,2+(i-1)*3)
                scatter(xx,elo(:,i),'.')
                hold on;
                [p,s] = polyfit(xx,elo(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(1.7,0.65,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- elo(:,i)').^2) / sum((elo(:,i)' - mean(elo(:,i))).^2));
                text(1.7,0.6,sprintf("           R2       : %.4f",r2))
                legend('Eloc','Fitted Curve','95% Prediction Interval')
                ylim([0 0.7])
                xlabel('log(Age)')
            case 3
                subplot(4,3,3+(i-1)*3)
                scatter(xx,modu(:,i),'.')
                hold on;
                [p,s] = polyfit(xx,modu(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(1.7,0.27,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- modu(:,i)').^2) / sum((modu(:,i)' - mean(modu(:,i))).^2));
                text(1.7,0.24,sprintf("           R2       : %.4f",r2))
                legend('Modularity','Fitted Curve','95% Prediction Interval')
                ylim([0 0.3])
                xlabel('log(Age)')
        end
    end
end

%% 中心性
figure(3)
for j = 1:2
    for i=1:4
        switch j
            case 1
                subplot(4,2,1+(i-1)*2)
                scatter(xx,bet(:,i),'.')
                hold on;

                [p,s] = polyfit(xx,bet(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(2,28,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- bet(:,i)').^2) / sum((bet(:,i)' - mean(bet(:,i))).^2));
                text(2,25,sprintf("           R2       : %.4f",r2))
                legend('Betweenness','Fitted Curve','95% Prediction Interval')
                ylim([-3 30])
                xlabel('log(Age)')
            case 2
                subplot(4,2,2+(i-1)*2)
                scatter(xx,parti(:,i),'.')
                hold on;
                [p,s] = polyfit(xx,parti(:,i)',n);
                [y_fit,delta] = polyval(p,x_fit,s);
                plot(x_fit,y_fit,'Color','r','LineWidth', 2);
                plot(x_fit,y_fit+2*delta,'m--',x_fit,y_fit-2*delta,'m--')
                %title('Linear Fit of Data with 95% Prediction Interval')

                equation = sprintf("Fitting formula: y = %.4f *x^2 + %.4f *x + %.4f",p(1),p(2),p(3));
                text(2,0.75,equation,LineWidth=1.6)
                r2 = 1 - (sum((y_fit- parti(:,i)').^2) / sum((parti(:,i)' - mean(parti(:,i))).^2));
                text(2,0.7,sprintf("           R2       : %.4f",r2))
                legend('Participation','Fitted Curve','95% Prediction Interval')
                ylim([0.2 .8])
                xlabel('log(Age)')
        end
    end
end





%% 画char 在四个频带的图
for i=1:4
    subplot(4,1,i);
    scatter(log(age),cha(:,i),'.')
    %scatter(x,cha(:,i),'.')
    %xlim([4 86])
    ylim([0 3])
    xlabel('log(Age)')
end

%% 画cluster 在四个频带的图
for i=1:4
    subplot(4,1,i);
    scatter(log(age),clu(:,i),'.')
    %scatter(x,clu(:,i),'.')
    %xlim([4 86])
    ylim([0 1])
    xlabel('log(Age)')
end

%% 画eglob 在四个频带的图
for i=1:4
    subplot(4,1,i);
    scatter(log(age),egl(:,i),'.')
    %scatter(x,egl(:,i),'.')
    %xlim([4 86])
    ylim([0 1])
    xlabel('log(Age)')
end

%% 画eloc 在四个频带的图
for i=1:4
    subplot(4,1,i);
    scatter(log(age),elo(:,i),'.')
    %scatter(x,elo(:,i),'.')
    %xlim([4 86])
    ylim([0 1])
    xlabel('log(Age)')
end





