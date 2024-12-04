function drawtop_alphaband(w,thr)
% thr=0.4;
% w=all(1).pre_coh(:,:,1);
p=locc;
w=threshold_absolute(w,thr);
chanlocs=readlocs('Standard-10-20-Cap19.locs');

topoplot([],chanlocs,'style','blank','electrodes','on');%labels
hold on
c=colormap;

for i=1:length(p)
    for j=(i+1):length(p)
        x=zeros(1,2);
        y=zeros(1,2);
        if w(i,j)~=0
            x(1,1)=p(1,i);
            x(1,2)=p(1,j);
            y(1,1)=p(2,i);
            y(1,2)=p(2,j);
            wid=w(i,j);
            co=(wid-thr)/(1-thr);
%             plot(x,y,'Color',[100/255 abs(co) 150/255],'LineWidth',1);
%             plot(x,y,'Color',[100/255 abs(co) 150/255]);
            bb = round(co*255);
            plot(x,y,'Color',c(bb+1,:),'LineWidth',1);
            hold on
        end
    end
end
caxis([thr,1]);
colorbar;
hold off
%#66A9D6