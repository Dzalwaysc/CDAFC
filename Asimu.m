% clear all
% % topology graph
% [r, edge, D, L, Omega, w] = affineGraph();
% [n,m] = size(D);
% d = size(r,2);
% 
% % trajectory xr = Ar+b
% via_ = sttraj(r, edge, m);
% dt = 0.01; acc = 10;
% [rTra, rTrad, rTradd, tr] = mstraj_(via_, 2*ones(1,6), dt, acc);
% [desPos, desPosd, desPosdd] = dptraj(r, rTra, rTrad, rTradd, tr);
% [desYaw, desYawd, desYawdd] = dytraj(desPosd, tr, dt);
% verify_desPos(desPos, desPosd, desPosdd, tr, dt);
% verify_desYaw(desPos, desYaw, desYawd, desYawdd, tr, dt);

%% initial position
for i=1:3
    Eta{i}(1,:) = [desPos{i}(1,:), desYaw{i}(1)];
    Etad{i}(1,:) = [desPosd{i}(1,:), desYawd{i}(1)];
    Etadd{i}(1,:) = [desPosdd{i}(1,:), desYawdd{i}(1)];
    ada{i}(1,:) = [0, 0, 0, 0, 0];
    sum_ada{i}(1,:) = 0;
end

Pos{4}(1,:) = [8 3]; Yaw{4}(1) = 30*pi/180;
Pos{5}(1,:) = [9 -22]; Yaw{5}(1) = -30*pi/180;
Pos{6}(1,:) = [-12 5]; Yaw{6}(1) = 10*pi/180;
Pos{7}(1,:) = [-4 -8]; Yaw{7}(1) = -10*pi/180;
for i=4:7
    Eta{i}(1,:) = obEta(Pos{i}(1,:), Yaw{i}(1));
    V{i}(1,:) = zeros(1,3);
    Tao{i}(1,:) = zeros(1,3); 
    [Eta{i}(1,:), Etad{i}(1,:), Etadd{i}(1,:), V{i}(1,:), ...
         C__{i}(1,:), D__{i}(1,:), M__{i}(1,:), F{i}(1,:)] = ...
            plant(Eta{i}(1,:)', V{i}(1,:)', Tao{i}(1,:)', t, dt);     
    
    ada{i}(1,:) = [0, 0, 0, 0, 0];
    sum_ada{i}(1,:) = 0;
end

%% simulation
loop = 0;
gamma1 = diag(Omega);
gamma2 = diag(L);

for t=tr(1):dt:tr(end-1)
    loop = loop+1;
        
    for i=1:3
        Eta{i}(loop+1,:) = [desPos{i}(loop+1,:), desYaw{1}(loop+1)]; 
        Etad{i}(loop+1,:) = [desPosd{i}(loop+1,:), desYawd{1}(loop+1)];
        Etadd{i}(loop+1,:) = [desPosdd{i}(loop+1,:), desYawdd{1}(loop+1)];
    end        
    
    for i=4:7
        [tao, dada] = ctrEta(i, w, D, Eta, Etad, loop, ada, V);
        Tao{i}(loop,:) = tao;
        
        [Eta{i}(loop+1,:), Etad{i}(loop+1,:), Etadd{i}(loop+1,:), V{i}(loop+1,:), ...
         C__{i}(loop+1,:), D__{i}(loop+1,:), M__{i}(loop+1,:), F{i}(loop+1,:)] = ...
            plant(Eta{i}(loop,:)', V{i}(loop,:)', Tao{i}(loop,:)', t, dt);
       ada{i}(loop+1,:) = ada{i}(loop, 1:5) + dada(1:5)*dt;
       sum_ada{i}(loop+1,:) = sum_ada{i}(loop, 1) + dada(6)*dt;
    end
    fprintf('The time is %f\n', t);
end