function [p,juli,d,zuobiao,xtl]=loc
%电极位置
Fp1=[-0.13;0.44];
Fp2=[0.13;0.44];
F3=[-0.2;0.23];
F4=[0.2;0.23];
C3=[-0.24;0];
C4=[0.24;0];
P3=[-0.2;-0.23];
P4=[0.2;-0.23];
O1=[-0.13;-0.44];
O2=[0.13;-0.44];
F7=[-0.38;0.26];
F8=[0.38;0.26];
T3=[-0.45;0];
T4=[0.45;0];
T5=[-0.38;-0.26];
T6=[0.38;-0.26];
Fz=[0;0.245];
Cz=[0;0];
Pz=[0;-0.245];

p=[Fp1, Fp2 , F3,F4,C3,C4,P3,P4,O1,O2,F7,F8,T3,T4,T5,T6,Fz,Cz,Pz];
name = {'Fp1','Fp2','F3','F4','C3','C4','P3','P4','O1','O2','F7','F8','T3','T4','T5','T6','Fz','Cz','Pz'};
%计算距离
juli = ones(length(p),length(p));
for i=1:length(p)
    for j=i:length(p)
        juli(i,j) = distance([p(1,i),p(2,i)],[p(1,j),p(2,j)]);
        if i==j
            juli(i,j) = 1;
        end
    end
end

%从小到大排序
for i = 1:length(dow(juli))
    [m,h] = min(juli);
    [d(i),l] = min(m);
    zuobiao(i,:) = [h(l),l];
    juli(zuobiao(i,1),zuobiao(i,2)) = 1;%找出最小后置1
    xtl(i) = {[name{zuobiao(i,1)},'-',name{zuobiao(i,2)}]};
end

% 将升序排列的电极对按矩阵排列
% w = indow(d);
% figure(1)
% imagesc(w)
% % axis xy
% colorbar
% n = 1;
% for i = 1:size(w,1)
%     for j = i+1:size(w,2)
%         text(i-0.2,j,[num2str(d(n)),xtl(n)],'FontSize',8)
%         n=n+1;
%     end
% end

