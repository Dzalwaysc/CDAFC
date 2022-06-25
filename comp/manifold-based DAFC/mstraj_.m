function [q,qd,qdd,t] = mstraj_(qvia,qdmax,dt,tacc)
% mstraj输入: 中间点矩阵: 每点对应矩阵一行; 每轴最大速度向量; 每段运动时间向量;
%                         起点各轴坐标; 采样时间间隔; 加速度时间
% 可以增加加速时间使得轨迹更加平滑
% mstraj输出: 返回一个矩阵: 行对应节拍，列对应各个轴
% Generate trajectory from via points
qlen = size(qvia,2);
q0 = qvia(1,:);
q = mstraj(qvia(2:end,:),qdmax,[],q0,dt,tacc); % row vector for each xr
q = [q0;q];
qd = [diff(q)./dt;zeros(1,qlen)];
qdd = [diff(qd)./dt;zeros(1,qlen)];
t = 0:dt:(size(q,1)-1)*dt;
end