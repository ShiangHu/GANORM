
clear;clc
%% 提取 强 静息态数据



raw_data_path='D:\matlab\long\117配图\data\baseline\eeg_set';
%out_path='F:\脑子🧠\0.Norm\3. Data\predata\country';
[~,sub_path] = recorrer_folders(raw_data_path);

steps={'ave','gsf'};
% steps={'ave','reg','gsf'};
% n2=0;
% n3=0;
all = [];
dt = [];
n1 = 1;

for i = 2:2:size(sub_path,2)
    [~, sub_name, ~] = fileparts(cell2mat(sub_path(i))); 
    EEG = pop_loadset([sub_name '.set'],raw_data_path);

    % 提取19通道，将数据转为三维形式
    EEG_data=EEG.data(1:19,:);
    % epoch 的长度
    epoch_length = 500;
    % EEG数据的总长度
    total_samples = size(EEG_data, 2);
    %epoch 之间的重叠
    overlap = epoch_length / 2; % 50% 的重叠
    % 初始化epochs的
    epochs = cell(1, 0);

    % 创建滑动窗口
    for start_index = 1 : epoch_length : (total_samples - epoch_length + 1)
        end_index = start_index + epoch_length - 1;

        % 提取当前窗口的 EEG 数据，并存储到 epochs 中
        current_epoch = EEG_data(:,start_index:end_index)';
        epochs{end + 1} = current_epoch';
    end
    % 将 cell 数组转换为三维数组，其中每个切片是一个epoch
    epochs_data = cat(3, epochs{:});

    EEG_data = epochs_data;
    fs = EEG.srate; % 采样频率
    % 定义其他参数
    cnames = {'Fp1', 'Fp2', 'F3', 'F4', 'C3', 'C4', 'P3', 'P4', 'O1', 'O2', 'F7', 'F8', 'T3', 'T4', 'T5', 'T6', 'Fz', 'Cz','Pz'};
    data_code = 'data_code';
    reference = 'ref';
    age = 'age';
    sex = 'sex';
    country = 'anhui';
    eeg_device = 'eeg_device';

    % 调用 data_gatherer 函数
    [data_struct, error_msg] = data_gatherer(EEG_data, fs, cnames, data_code, reference, age, sex, country, eeg_device);


    dt(n1).name = sub_name;
    dt(n1).age = data_struct.age;
    dt(n1).sex = data_struct.sex;
    dt(n1).country = data_struct.pais;
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

    all = [all , dt];
    %op=[out_path filesep data_code];
    %save(op,"dt");
    %disp([data_code,'所有数据已整合到',op]);
end

all_11=[];
%% 简易版所有数据
for i = 1:length(all)
    all_11(i).name = all(i).name;
    all_11(i).country = all(i).country;
    all_11(i).age = all(i).age;
    all_11(i).sex = all(i).sex;
    all_11(i).freqrange = all(i).freqrange;
    all_11(i).dname = all(i).dname;
    all_11(i).pre_coh = all(i).pre_coh;
%     all_easy(i).spec = all(i).spec;
end
 %save('F:\脑子🧠\0.Norm\3. Data\predata\all_easy.mat',"all_11")

 
 %% 计算网络属性
 thr = 0.5;  %% cal_network_feature函数内没使用阈值化矩阵
 for i = 1:length(all_11)
     all_11(i).alphaband = mean(all_11(i).pre_coh(:,:,19:29),3);
%      [charpath(i),eglob(i),...
%          cluster(i),eloc(i),modularity(i),...
%          betweenness(i),participation(i)]=cal_network_feature(all_11(i).alphaband(:,:),thr);

     [all_11(i).charpath,all_11(i).eglob,...
         all_11(i).cluster,all_11(i).eloc,all_11(i).modularity,...
         all_11(i).betweenness,all_11(i).participation] = cal_network_feature(all_11(i).alphaband(:,:),thr);
 end
 


%  %% 验证
% load('D:\matlab\long\117配图\data\all_11.mat')











