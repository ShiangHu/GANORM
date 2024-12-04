% a=[0.75, 0.27, 0.67, 0.11, 0.49, 0.22];
%a=[1,2,3,4,5,6]
%b=[0,1,2,3
%   0,0,4,5
%   0,0,0,6
%   0,0,0,0]


function b=indow(a)
% a=ans;
%%确定矩阵大小n*n
s=0;
for i=1:100
    s=s+i;
    if s==length(a)
        n=i+1;
        break
    end
end

%%还原矩阵上三角
b=zeros(n);
for i=1:n-1
    l=(i-1)*(2*n-i)/2+1;
    b(i,(i+1):end)=a(l:(l+n-i-1));
end

%%还原矩阵下三角
for j=1:n-1
     b(j+1:end,j)=b(j,j+1:end);
end