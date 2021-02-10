function [X, Y, Z, C] = vrml2patch_func(nel, w3d)
% VRML2PATCH - VRML struct conversion
% Usage [X Y Z C] = vrml2patch(nel, w3d)
% creates X Y Z and C matrices for patch function from the w3d struct (and
% number of elements nel) given by the read_vrml function.
%
% See also READ_VRML, PATCH
shape= [3,sum([w3d(:).polynum])];
c = zeros(flip(shape));
[X, Y, Z]=deal(zeros(shape));
ind=1;
for i = 1:nel
    vertex = [];
    num = w3d(i).polynum;
    points = w3d(i).pts(w3d(i).knx(:), :);
    vertex(:,:, 1) = points(1:num,:);
    vertex(:,:, 2) = points(num+1:2*num,:);
    vertex(:,:, 3) = points(num*2+1:end,:);
    
    X(:,ind:ind+num-1) = squeeze(vertex(:, 1, :))';
    Y(:,ind:ind+num-1) = squeeze(vertex(:, 2, :))';
    Z(:,ind:ind+num-1) = squeeze(vertex(:, 3, :))';
    c(ind:ind+num-1,:) = repmat(w3d(i).color,num,1);
    ind=ind+num;
end
C(1,:,:) = c;
end