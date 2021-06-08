function [norm_x] = normVec_in_Mat(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

norm_x = 0;
for ii = 1:size(x,2)
    norm_x = norm_x + norm(x(:,ii));
end



end

