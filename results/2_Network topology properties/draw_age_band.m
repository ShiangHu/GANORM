
%% 作图
function [] = draw_age_band(data,x,ylab,titl)

% x=1:1:length(data);%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,data(:,1),'g',x,data(:,2),'b',x,data(:,3),'c',x,data(:,4),'y','LineWidth',2); %线性，颜色，标记
% axis([0,18,0,1.9])  %确定x轴与y轴框图大小
set(gca,'XTick',[5:5:85]) %x轴范围1-6，间隔1
set(gca,'xticklabels',{'5','10','15','20','25','30','35','40','45','50','55','60','65','70','75','80','85'})
% set(gca,'FontSize',15);
legend('Delta','Theta','Alpha','Lowbeta');   %右上角标注
% xlabel('Age')  %x轴坐标描述
ylabel(ylab)
title(titl);
