%% 按年龄分组
function [age_group,agenum] = age_groupp(age_begin,age_end,data)

agenum=zeros(1,length(age_begin:age_end));%每个组数量
age_group=[];%各组对应的coh
ageidx=1;
for i=age_begin:age_end
    n1=1;
    for j = 1:length(data)
        if round(data(j).age)==i
            for z = 1:4
                a(z,:) = dow(data(j).band_coh(:,:,z));
            end
            group(:,:,n1)=a;
            n1=n1+1;
        end
    end
    age_group(i-4).age=i;
    age_group(i-4).dname=data(i).dname;
    groupend = mean(group,3);
    for z=1:4
        age_group(i-4).band_coh(:,:,z)=indow(groupend(z,:));
    end
    agenum(ageidx)=n1-1;
    ageidx=ageidx+1;
end
% age_group(80).coh=indow(data(1586,1:153));

% %% 每个年龄下的人数
% x = age_begin:age_end;
% plot(x,agenum,'g','LineWidth',2)
% xlabel('Age')
% ylabel('Number')
% title('Number of persons under each age')
%  
% x = 5:85;
% h = bar(x,agenum);
% title('Number of persons under each age group')
% xlabel('Age')
% ylabel('Number')
% set(h,'FaceColor',[239/255,138/255,102/255],'EdgeColor',[200/255,200/255,200/255]);

