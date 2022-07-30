function [eta, deta, ddeta, V, C__, D__, M__, F_] = plant(eta, V, tao, t, dt)
%% In
phi = eta(3);
u = V(1); v = V(2); r = V(3);

%% Newton-form
% M = [25.8 0 0; 0 33.8 0; 0 0 2.76];
M = [25.8     0        0;
      0    33.8    1.0115;
      0   1.0948    2.76];
% C = [0 0 -33.8*v; 0 0 25.8*u; 33.8*v -25.8*u 0];
c13 = -33.8*v - 1.0115*r;
c23 = 25.8*u;
c31 = 33.8*v + 1.0115*r;
c32 = -25.8*u;
C = [0    0    c13;
     0    0    c23;
    c31  c32    0];
% D = [2 0 0; 0 7 0; 0 0 0.5];
d11 = 0.72 + 1.33 * abs(u) + 5.87 * (u)^2;
d22 = 0.8896 + 36.5 * abs(v) + 0.805 * abs(r);
d23 = 7.25 + 0.845 * abs(v) + 3.45 * abs(r);
d32 = 0.0313 + 3.96 * abs(v) + 0.13 * abs(r);
d33 = 1.9 - 0.08 * abs(v) + 0.75 * abs(r);
D = [d11  0     0;
      0  d22  d23;
      0  d32  d33];

taod = [-2*cos(0.05*t)*cos(0.3*t)-3; 1.5*sin(0.03*t); 0.6*sin(0.05*t)*cos(0.01*t)];
  
R = [cos(phi) -sin(phi)  0;
     sin(phi)  cos(phi)  0;
        0        0       1];
tao = R'*tao;
deta = R*V;
dV = inv(M)*(tao-C*V-D*V + taod);

%% Euler-from
W = [0 -r 0; r 0 0; 0 0 0];
dR = R*W;

M_ = R*M*R'; M__ = M_(:);
C_ = R*(C-M*R'*dR)*R'; C__ = C_(:);
D_ = R*D*R'; D__ = D_(:);
F_ = inv(M_)*(-C_*deta-D_*deta+R*taod);
ddeta = F_+inv(M_)*R*tao;

%% itertive
eta = eta+deta*dt;
V = V+dV*dt;
