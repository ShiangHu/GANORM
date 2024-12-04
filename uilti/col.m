%% limin国家颜色
function color = col(n)

if n==9
    % 9个
    color = [199 227 188 ; 44 129 189 ; 164 118 42 ; 44 162 81 ; 215 120 81 ; 97 97 98 ; 114 105 174 ;...
    %           bbd         中国          哥伦比亚    古巴          德国      马来西亚        俄罗斯   
             245 139 61 ; 251 216 44]/255;
    %       瑞士          美国
elseif n==14
    color= [199 227 188 ; 245 139 61 ; 44 162 81 ; 44 129 189 ; 54 139 199 ; 164 118 42 ; 54 172 91 ; 64 182 101 ; 215 120 81 ;...
        %       Barbados          bern      CHBMP       Chengdu        Chongqing    Colombia    Cuba2003    Cuba90      Germany
        97 97 98 ; 251 216 44 ; 114 105 174 ; 124 115 184 ; 255 149 71]/255;
    %       Malaysia    NewYork     Russia-nvx136   Russia      Switzerland
end