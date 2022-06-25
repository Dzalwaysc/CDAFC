% clear all
% topology graph
[r, edge, D, L, Omega, w] = affineGraph();
[n,m] = size(D);
d = size(r,2);

% trajectory xr = Ar+b
via_ = sttraj(r, edge, m);
dt = 0.01; acc = 10;
[rTra, rTrad, rTradd, tr] = mstraj_(via_, ones(1,6), dt, acc);
[desPos, desPosd, desPosdd] = dptraj(r, rTra, rTrad, rTradd, tr);
[desYaw, desYawd, desYawdd] = dytraj(desPosd, tr, dt);
% verify_desPos(desPos, desPosd, desPosdd, tr, dt);
% verify_desYaw(desPos, desYaw, desYawd, desYawdd, tr, dt);

%% initial position
for i=1:3
    Eta{i}(1,:) = [desPos{i}(1,:), desYaw{i}(1)];
    Etad{i}(1,:) = [desPosd{i}(1,:), desYawd{i}(1)];
    R = [cos(desYaw{i}(1)) -sin(desYaw{i}(1))  0;
         sin(desYaw{i}(1))  cos(desYaw{i}(1))  0;
                 0                     0       1];
    V{i}(1,:) = inv(R) * Etad{i}(1,:)';
    Ada{i}(1,:) = [0, 0, 0, 0, 0];
end

Pos{4}(1,:) = [0 15]; Yaw{4}(1) = 30*pi/180;
Pos{5}(1,:) = [0 -17]; Yaw{5}(1) = -30*pi/180;
Pos{6}(1,:) = [-10 10]; Yaw{6}(1) = 145*pi/180;
Pos{7}(1,:) = [-16 -16]; Yaw{7}(1) = 5*pi/180;
for i=4:7
    Eta{i}(1,:) = obEta(Pos{i}(1,:), Yaw{i}(1));
    V{i}(1,:) = zeros(1,3);
    Tao{i}(1,:) = zeros(1,3); 
    [Eta{i}(1,:), Etad{i}(1,:), V{i}(1,:)] = ...
            platform([Eta{i}(1,:)'; V{i}(1,:)'], Tao{i}(1,:)', dt, 0);     
    
    Ada{i}(1,:) = [0, 0, 0, 0, 0];
end

%% simulation
loop = 0;
gamma1 = diag(Omega);
gamma2 = diag(L);

for t=tr(1):dt:tr(end-1)
    loop = loop+1;
        
    for i=1:3
        Eta{i}(loop+1,:) = [desPos{i}(loop+1,:), desYaw{i}(loop+1)]; 
        Etad{i}(loop+1,:) = [desPosd{i}(loop+1,:), desYawd{i}(loop+1)];
        R = [cos(desYaw{i}(loop+1)) -sin(desYaw{i}(loop+1))  0;
             sin(desYaw{i}(loop+1))  cos(desYaw{i}(loop+1))  0;
                     0                           0           1];
        V{i}(loop+1,:) = inv(R) * Etad{i}(loop+1,:)';
    end        
    
    for i=4:7
        [tao, ada] = ctrEta(i, w, D, Eta, Etad, loop, Ada, V, dt);
        Tao{i}(loop,:) = tao;
        Ada{i}(loop+1,:) = ada;
        [Eta{i}(loop+1,:), Etad{i}(loop+1,:), V{i}(loop+1,:)] = ...
            platform([Eta{i}(loop,:)'; V{i}(loop,:)'], Tao{i}(loop,:)', dt, t);
    end
    fprintf('The time is %f\n', t);
end