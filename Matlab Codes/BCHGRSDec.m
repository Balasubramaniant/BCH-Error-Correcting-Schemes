function [DecVal,Err,Error]=BCHGRSDec(RecCode,CodeLen,MsgLen,AddVal,Nwords)

% Initial Setup
CodeLen=2^(CodeLen)-1;
RR=reshape(RecCode,Nwords,[]);

% Converting BitStream to Matrix
[L1 L2]=size(RR);
RRMat=zeros(L1,L2);
for i=1:L1
    for j=1:L2
        if RR(i,j)=='1'
            RRMat(i,j)=1;
        elseif RR(i,j)=='0'
            RRMat(i,j)=0;
        end
    end
end

% GF Setup
Input=gf(RR);

% Decoding using BCH
[MsgRx Error]= bchdec(Input,CodeLen,MsgLen);

%Error Matrix
[LL1,~]=size(Error);
Err=[];
Maa=MsgRx.x;
for i=1:LL1
    if Error(i)<0
        Err(i,:)=Maa(i,:);
    end
end

% Output BitStream
MsgMat=reshape(MsgRx.x,1,[]);
DecVal=MsgMat(1:end-AddVal);
DecVal=ToBinStream(DecVal);
end