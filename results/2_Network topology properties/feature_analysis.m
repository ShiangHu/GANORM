%% Network topology properties analysis
function [] = feature_analysis(data)
% data=age_group;
%fa为几个网络属性四个频带下的值
for i = 1:length(data)
    thr = 0.4;
    for j = 1:4
        [charpath(j),cluster(j),eglob(j),eloc(j)]=cal_network_feature(data(i).band_coh(:,:,j),thr);
    end
        fa(i).age = data(i).age;
        fa(i).charpath = charpath;
        fa(i).cluster = cluster;
        fa(i).eglob = eglob;
        fa(i).eloc = eloc;
%         fa(i).sw = sw;
end

for i = 1:length(fa)
    x(i) = fa(i).age;
    cha(i,:) = fa(i).charpath;
    clu(i,:) = fa(i).cluster;
    egl(i,:) = fa(i).eglob;
    elo(i,:) = fa(i).eloc;
end

%% 作图
%draw_age_band(data,x,ylab,titl) data数据，x横坐标，ylab纵坐标标签，titl标题
%% 四个频带下各网络属性随年龄的变化
figure(1)
sgtitle('Changes in network properties with age')
subplot(4,1,1)
draw_age_band(cha,x,'Charpath Value',[])

subplot(4,1,2) 
draw_age_band(clu,x,'Cluster Value',[])

subplot(4,1,3)
draw_age_band(egl,x,'Eglob Value',[])

subplot(4,1,4)
draw_age_band(elo,x,'Eloc Value',[])

%% 不分频带
allcha = mean(cha,2);
allclu = mean(clu,2);
allegl = mean(egl,2);
allelo = mean(elo,2);
figure(2)
plot(x,allcha,'g',x,allclu,'b',x,allegl,'c',x,allelo,'y','LineWidth',2)
axis([5,85,0,1.9])  %确定x轴与y轴框图大小
set(gca,'XTick',[5:5:85])
set(gca,'xticklabels',{'5','10','15','20','25','30','35','40','45','50','55','60','65','70','75','80','85'})
legend('charpath','cluster','Eglob','Eloc');   %右上角标注
xlabel('Age')  %x轴坐标描述
ylabel('Value')
% title('');

