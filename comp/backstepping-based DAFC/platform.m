function [eta, etad, etadd, V, C__, D__, M__, F_] = platform(state, tao, step, t)
    % start stage
    dstate = plant(t, state, tao);
    K1 = dstate;
    
    % middle stage
    state_ = state + (step/2)*K1;
    dstate_ = plant(t, state_, tao);
    K2 = dstate_;
    
    % middle stage
    state_ = state + (step/2)*K2;
    dstate_ = plant(t, state_, tao);
    K3 = dstate_;
    
    % final stage
    state_ = state + (step/2)*K3;
    dstate_ = plant(t, state_, tao);
    K4 = dstate_;
    
    state = state + (step/6)*(K1+2*K2+2*K3+K4);
    
    eta = state(1:3); phi = eta(3);
    V = state(4:6); u = V(1); v = V(2); r = V(3);
    R = [cos(phi) -sin(phi)  0;
         sin(phi)  cos(phi)  0;
            0        0       1];
    etad = R*V;
    
    %% 计算Euler-Lagrange下的参数
    M = [25.8  0  0;  0  33.8  1.0115; 0  1.0948  2.76];
    c13 = -33.8*v - 1.0115*r; c23 = 25.8*u; c31 = 33.8*v + 1.0115*r; c32 = -25.8*u;
    C = [0  0  c13;  0  0  c23;  c31  c32  0];
    d11 = 0.72 + 1.33 * abs(u) + 5.87 * (u)^2; d22 = 0.8896 + 36.5 * abs(v) + 0.805 * abs(r);
    d23 = 7.25 + 0.845 * abs(v) + 3.45 * abs(r); d32 = 0.0313 + 3.96 * abs(v) + 0.13 * abs(r);
    d33 = 1.9 - 0.08 * abs(v) + 0.75 * abs(r);
    D = [d11  0  0;  0  d22  d23;  0  d32  d33];
    
    W = [0 -r 0; r 0 0; 0 0 0]; dR = R*W;
    M_ = R*M*R'; M__ = M_(:);
    C_ = R*(C-M*R'*dR)*R'; C__ = C_(:);
    D_ = R*D*R'; D__ = D_(:);
    F_ = inv(M_)*(-C_*etad-D_*etad);
    etadd = F_+inv(M_)*R*tao;
end