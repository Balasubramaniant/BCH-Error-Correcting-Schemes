function [MessBin]=ToBinStream(Mess)
% Converts a given Linear Matrix to Bit Stream

MessBin=[];
[L1 L2]=size(Mess);
for i=1:L1
    for j=1:L2
        if Mess(i,j)==1
            MessBin=[MessBin,'1'];
        elseif Mess(i,j)==0
            MessBin=[MessBin,'0'];
        end
    end
end

end