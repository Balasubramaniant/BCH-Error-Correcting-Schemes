function [EncBin,EncBB,Nwords,AddVal,ErrorCap]=BCHGaloisRSEnc(CodeLen,MsgLen,Message)

% Setup
n = 2^CodeLen-1;   % Codeword length
k = MsgLen;        % Message length

% Conversion of BitStream to Matrix
[~, L1]=size(Message);
Rem=mod(L1,k);
AddVal=k-Rem;

[DMat,DataMat]=ToMatrix(Message,AddVal,MsgLen);
[Nwords,~] = size(DataMat);

% Galois Field
MsgTx = gf(DMat);
[~,ErrorCap] = bchgenpoly(n,k);

%Encoding
Enc = bchenc(MsgTx,n,k);

%Converting Encoded Matrix to BitStream
EncVal=double(Enc.x);
EncBin=reshape(EncVal,1,[]);

k=numel(EncBin);
EncBB=dec2base(EncBin(1),2,1);
for ok=2:k
    V=dec2base(EncBin(ok),2,1);
    EncBB=[EncBB,V];
end

end