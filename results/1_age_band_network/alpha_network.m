%% 作图——各频带下各年龄下脑网络
function[] = alpha_network(age_group)

%% 提取作图年龄点1
n=1;
% 5 8 11 14 17
for i=1:3:13
    need_draw(n).age=age_group(i).age;
    need_draw(n).band_coh=age_group(i).band_coh;
    n=n+1;
end
% 27 37 47 57 67 77
for i=23:10:73
    need_draw(n).age=age_group(i).age;
    need_draw(n).band_coh=age_group(i).band_coh;
    n=n+1;
end
% 85
need_draw(n).age=age_group(81).age;
need_draw(n).band_coh=age_group(81).band_coh;

%% alpha band
thr=0.4;
figure(1)
for i=1:length(need_draw)
    colorbar;
    caxis([0.4,1]);
    name = [num2str(need_draw(i).age),'yrs.'];
    subplot(2,6,i);
    %drawtop(age_group(i).band_coh(:,:,j),thr);
    drawtop_alphaband(need_draw(i).band_coh(:,:,3),thr);
    title(name,'FontSize',14);
    hold on;
end
