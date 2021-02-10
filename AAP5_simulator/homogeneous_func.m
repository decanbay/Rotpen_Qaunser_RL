function [T] = homogeneous_func(ROLL, PITCH, YAW, X, Y, Z)
% T=zeros(4,4);
cy=cos(YAW);
cp=cos(PITCH);
cr=cos(ROLL);
sp=sin(PITCH);
sr=sin(ROLL);
sy=sin(YAW);
T=[cy*cp, cy*sp*sr-sy*cr, cy*sp*cr+sy*sr, X; sy*cp, sy*sp*sr+cy*cr, sy*sp*cr-cy*sr, Y;
    -sp, cp*sr, cp*cr, Z; 0,0,0,1];
% T(1,1) = cy*cp;
% T(1,2) = cy*sp*sr-sy*cr;
% T(1,3) = cy*sp*cr + sy*sr;
% T(1,4) = X;
% T(2,1) = sy*cp;
% T(2,2) = sy*sp*sr+cy*cr;
% T(2,3) = sy*sp*cr-cy*sr;
% T(2,4) = Y;
% T(3,1) = -sp;
% T(3,2) = cp*sr;
% T(3,3) = cp*cr;
% T(3,4) = Z;
% T(4,4) = 1;
end
