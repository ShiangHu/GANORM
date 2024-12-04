%%原始数据汇总，以国家为单位保存到data\raw_data
clear;clc;

raw_data_path='\data\rawMNCS';
out_path='\data\predata';
[~,pathnames] = recorrer_folders(raw_data_path);

steps={'ave','gsf'};
% steps={'ave','reg','gsf'};
% n2=0;
% n3=0;
all = [];
for i=1:size(pathnames,2)
    [~, data_code, ~] = fileparts(cell2mat(pathnames(i))); 
    [~,path] = recorrer_folders(cell2mat(pathnames(i)));
    dt=[];
    n1 = 1;
    for j=1:length(path)
        load(cell2mat(path(j)));
        %%将信息存入结构体
        % age  将年龄为NAN的去掉，将年龄为字符串形式的转为num
        if isnan(data_struct.age)   %删掉年龄值为NAN，
%             n2=n2+1;
            continue
%         elseif strcmp(data_struct.sex,'U')
%             continue
        elseif ischar(data_struct.age) %将年龄变为数值型
            dt(n1).age=str2num(data_struct.age);
        else
            dt(n1).age=data_struct.age;
        end

        if data_struct.sex=='U'
            dt(n1).sex = data_struct.sex;
        elseif strcmp(data_struct.sex,'FEMALE')
            dt(n1).sex = 'F';
        elseif strcmp(data_struct.sex,'MALE')
            dt(n1).sex = 'M';
        else
            dt(n1).sex = data_struct.sex;
        end
%         dt(n1).sex = data_struct.sex;
        dt(n1).country = data_code;
        dt(n1).freqrange = data_struct.freqrange(3:49);
        dt(n1).dname = data_struct.dnames;
        dt(n1).crossM = data_struct.CrossM(:,:,3:49);   %%交叉谱
        dt(n1).coh = real(cs2coh(dt(n1).crossM)); %%求原始相干
        dt(n1).spec = data_struct.Spec(:,3:49);
        dt(n1).nepochs = data_struct.nepochs;
        M_ave = aveReference(dt(n1).crossM(:,:,:));
        M_ave_gsf = gsf(M_ave);
        dt(n1).pre_crossM = M_ave_gsf;%%预处理后的交叉谱
        dt(n1).pre_coh = real(cs2coh(M_ave_gsf)); %%求预处理后的相干
        % 将主对角线置为0
        for z=1:length(dt(n1).pre_coh)
            dt(n1).pre_coh(:,:,z) = dt(n1).pre_coh(:,:,z) - diag(diag(dt(n1).pre_coh(:,:,z)));
        end
        n1 = n1+1;
    end
    all = [all , dt];
    op=[out_path filesep data_code];
    %save(op,"dt");
    disp([data_code,'所有数据已整合到',op]);
end

all_easy=[];
%% 简易版所有数据
for i = 1:length(all)
    all_easy(i).country = all(i).country;
    all_easy(i).age = all(i).age;
    all_easy(i).sex = all(i).sex;
    all_easy(i).freqrange = all(i).freqrange;
    all_easy(i).dname = all(i).dname;
    all_easy(i).pre_coh = all(i).pre_coh;
end
 save('\predata\all_easy.mat',"all_easy")




