%% 做四个频带下的视频
function [] = make_allband_video(ww)

%% 阈值化
th_re_ww = threshold_absolute(ww, thr);
bin_re_ww = dthreshold_absolute(th_re_ww, thr);
% imagesc(bin_re_w(:,:,1))

%% 取权重大的电极对进行分析
for i = 1:size(bin_re_ww,3)
    for j = 1:size(bin_re_ww,1)
        num_zero(j,i) = length(find(bin_re_ww(j,:,i)==0));
    end
end

%将弱连接置为0
re_ww_th = ww;
for i = 1:4
    re_ww_th(find(num_zero(:,i)>size(bin_re_ww,2)*0.7),:,i) = zeros(length(find(num_zero(:,i)>size(bin_re_ww,2)*0.7)),size(bin_re_ww,2),1);
end

%做四个频带内强连接电极对随年龄变化的视频
% alpha
fps = 4;
myVideo = VideoWriter('strong_allband.avi'); 
myVideo.FrameRate = fps; 
open(myVideo); 

figure
for i = 1:76
    w1 = indow(re_ww_th(:,i,1));
    w2 = indow(re_ww_th(:,i,2)); 
    w3 = indow(re_ww_th(:,i,3));
    w4 = indow(re_ww_th(:,i,4));
    age=i+4;
    sgtitle(age)
    subplot(2,2,1,'Position',[.1 .48 0.4 0.4])
    drawtop(w1,thr)
    title('delta')
    subplot(2,2,2,'Position',[.5 .48 0.4 0.4])
    drawtop(w2,thr)
    title('theta')
    subplot(2,2,3,'Position',[.1 0 0.4 0.4])
    drawtop(w3,thr)
    title('alpha')
    subplot(2,2,4,'Position',[.5 0 0.4 0.4])
    drawtop(w4,thr)
    title('lowbeta')
    frame = getframe(gcf);
    im = frame2im(frame);
    writeVideo(myVideo,im);
end
close(myVideo); 

