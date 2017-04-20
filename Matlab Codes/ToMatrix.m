function [DMat,DataMat]=ToMatrix(DATA,AddVal,MsgLen)
% Converts a given Bit Stream to Linear Matrix

% Appending Zeros to BitStream
Zeros=dec2base(0,2,AddVal);
DATA=[DATA,Zeros];

% Reshaping BitStream to Matrix
DataMat=reshape(DATA,[],MsgLen);
[L1 L2]=size(DataMat);
DMat=zeros(L1,L2);

for i=1:L1
    for j=1:L2
        if DataMat(i,j)=='1'
            DMat(i,j)=1;
        elseif DataMat(i,j)=='0'
            DMat(i,j)=0;
        end
    end
end

end