%%将n维对称矩阵取下三角保存为向量
%n*n
% x = rand(4,4);
%[0,1,2,3
% 0,0,4,5
% 0,0,0,6]
%a=[1,2,3,4,5,6]

function a=dow(x)
n=length(x);
a=[];
%%不含对角线
for z=1:n-1
    l=(z-1)*(2*n-z)/2+1;
    a(l:(l+n-z-1))=x(z,(z+1):end);
end

% %%含对角线
% for z=1:n
%     if z==1
%         l0=1;
%     else
%         l0=(z-1)*n-z+3;
%     end
%     l1=z*n-(z-1);
%     a(l0,l1)=x(z:end,z);
% end