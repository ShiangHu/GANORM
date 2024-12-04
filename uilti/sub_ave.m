function [age_coh,agenum] = sub_ave(smallage,bigage,all_easy)

agenum=zeros(1,length(smallage:bigage));%每个组数量
age_coh=[];%各组对应的coh
ageidx=1;
for i=smallage:bigage
    n1=1;
    group=[];
    for j = 1:length(all_easy)
        if round(all_easy(j).age) == i
            for z = 1:4
                group(:,z,n1) = dow(all_easy(j).band_coh(:,:,z));
            end
            n1=n1+1;
        end
    end
    age_coh(i-4).age=i;
    age_coh(i-4).coh=mean(group,3);
    agenum(ageidx)=n1-1;
    ageidx=ageidx+1;
end