
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
function res = reshapeToVector(matrix) 
width = length(matrix(1,:));
height = length(matrix(:,1));
    res = zeros(length(matrix(1,:))*length(matrix(:,1)),1);
    for iii = 0 : width-1 
        res(height * iii + 1 : height*(iii+1),1) = matrix(:,iii+1);
    end
res = res(:);
end

