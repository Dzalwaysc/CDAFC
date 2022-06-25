function via_ = sttraj(r, edge, m)
    via = [  0,   0;
            30,  30;
            60,  60;
            90,  90;];

    for j=1:size(via,1)
        if j==1
            T1 = eye(1);
            T2 = rot2(45*pi/180);
        elseif j==2
            T1 = eye(1);
            T2 = rot2(45*pi/180);
        elseif j==3
            T1 = 1/2*eye(1);
            T2 = rot2(45*pi/180);
        else
            T1 = 1/2*eye(1);
            T2 = rot2(45*pi/180);
        end
        via_(j,:) = [vec(T1*T2)', via(j,:)];
    end
    % 查看轨迹具体情况
%   figure(1);
%   trashape{j} = r*T2'*T1' + via(j,:);    
%   for i=1:m
%       plot(trashape{j}(edge(:,i),1), trashape{j}(edge(:,i),2), 'k', 'LineWidth', 2); hold on;
%   end
end