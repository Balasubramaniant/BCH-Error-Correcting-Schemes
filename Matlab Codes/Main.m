clear all;
close all;
clc;

% Input From User
Input=input('Enter the Message: ', 's');
MessBin=dec2base(Input,2,7);                        %Converting Inputted Message to ASCII Binary Values
Message=reshape(MessBin,1,[]);                      %Reshaping Message Binary Values to Binary Stream
[~,MS]=size(Message);

% Displaying Message
disp('Message in BitStream:');
disp(Message);

% BCH Encoding
CodeLen=5;
MsgLen=6;
[EncBin,EncBB,Nwords,AddVal,ErrorCap]=BCHGaloisRSEnc(CodeLen,MsgLen,Message);

disp('BCH Encoded Message in BitStream:');
disp(EncBB);

% Generating Error
[~,EncSize]=size(EncBB);
%[1 ErrorCap]
Error=randerr(1,EncSize,100);              %'ErrorCap' denotes the capability of changes in Bit, BCH can Handle
disp('Error Added to BitStream:');
disp(ToBinStream(Error));

% Adding Error to Encoded Message
MESS=double(xor(EncBin,Error));                     %Data is in BitStream, hence XOR is used to input bit errors
disp('Noisy BitStream:');
disp(ToBinStream(MESS));

% Displaying Message After Adding Error
MessageErr=bin2dec(reshape(ToBinStream(MESS(1:MS)),[],7));
disp('Message after Adding ERROR:');
disp(char(MessageErr'));

% BCH Decoding
[DecVal,Err,Error]=BCHGRSDec(MESS,CodeLen,MsgLen,AddVal,Nwords);

%Extracting Message
MessageExct=bin2dec(reshape(DecVal,[],7));         %Reshaping Bit Stream to ASCII Binary Values
disp('Extracted Message after BCH Decryption:');
disp(char(MessageExct'));