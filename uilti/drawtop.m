function drawtop(w,thr)
% thr=0;
p=locc;
w=threshold_absolute(w,thr);
chanlocs=readlocs('Standard-10-20-Cap19.locs');
% map=zeros(256,3);
% for i=0:255
%     map(i+1,1)=100/255;
%     map(i+1,2)=i/255;
%     map(i+1,3)=150/255;
% end

% figure(1)
% topoplot([],chanlocs,'style','blank','electrodes','labels');%labels
topoplot([],chanlocs,'style','blank');%labels
hold on
c=colormap('jet');

hold on
for i=1:length(p)
    for j=(i+1):length(p)
        x=zeros(1,2);
        y=zeros(1,2);
        if w(i,j) ~= 0
            x(1,1)=p(1,i);
            x(1,2)=p(1,j);
            y(1,1)=p(2,i);
            y(1,2)=p(2,j);
            wid=w(i,j);
            co=(wid-thr)/(1-thr);
%             plot(x,y,'Color',[100/255 abs(co) 150/255],'LineWidth',co*10);
%             plot(x,y,'Color',[100/255 abs(co) 150/255]);
            bb = round(co*255);
            plot(x,y,'Color',c(bb+1,:));
            hold on
        end
    end
end
caxis([thr,1]);
colorbar;
hold off

