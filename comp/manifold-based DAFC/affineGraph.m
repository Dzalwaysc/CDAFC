function [r, edge, D, L, Omega, w] = affineGraph2()
%% 通信拓扑
% Incidence matrix H: rows indexed by edges and columns by vertices
% Laplacian matrix L: L = H'*H
D = [1,-1, 0, 0, 0, 0, 0, 0, 0,-1, 0, 1;
    -1, 0, 0, 0, 0, 0, 1,-1, 0, 0, 0, 0;
     0, 1,-1, 0, 0, 0, 0, 0, 1, 0, 0, 0;
     0, 0, 0, 0, 0, 1,-1, 0, 0, 1,-1, 0;
     0, 0, 1,-1, 0, 0, 0, 0, 0, 0, 1,-1;
     0, 0, 0, 0, 1,-1, 0, 0,-1, 0, 0, 0;
     0, 0, 0, 1,-1, 0, 0, 1, 0, 0, 0, 0];
[n,m] = size(D);
L = D*D';
H = D';

%% 边
edge = mod(reshape(find(D~=0),2,m),n);
edge(edge==0) = n;

%% 构型
% r = [ 2,  0;
%       1,  1;
%       1, -1;
%       0,  1;
%       0, -1;
%      -1,  1;
%      -1, -1];
r = [ 32,  0;
      16,  16;
      16, -16;
      0,  16;
      0, -16;
     -16,  16;
     -16, -16];
d = size(r,2); 
% for i=1:m
%     plot(r(edge(:,i),1), r(edge(:,i),2), 'k', 'LineWidth', 2); hold on;
% end
% for i=1:n
%     plot(r(i,1), r(i,2), '.', 'MarkerSize', 50);
% end
% axis([-4 4 -4 4]);

%% 应力矩阵
E = [];
barP = [r,ones(n,1)];
for i=1:n
    E = [E;barP'*H'*diag(H(:,i))];
end
[U,S,V] = svd(barP);
% calculate M
U1 = U(:,1:d+1);
U2 = U(:,d+2:end);
z = null(E);
for i=1:size(z,2)
    M{i} = U2'*H'*diag(z(:,i))*H*U2;
end
% LMI solver
c = zeros(size(z,2),1);
setlmis([]);
for i=1:size(z,2)
    c(i) = lmivar(1, [1,0]);
    lmiterm([-1,1,1,c(i)],1,M{i});
end
lmi = getlmis;
[tmin,csol] = feasp(lmi);
for i=1:size(z,2)
    c(i) = dec2mat(lmi,csol,c(i));
end
M = [M{:}]*kron(c,eye(size(M{1},2)));

% check if all svd(U2'*H'*diag(z)*H*U2)>0
if all(eig(M)>0)
    w = z*c;
    Omega = H'*diag(w)*H;
    disp('M is positive definite.')
else
    error('M is not positive definite.')
end