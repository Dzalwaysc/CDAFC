function via_ = sttraj(r, edge, m)
    via = [  0,   0;
           100,   0;
           200,   0;
           200,  50;
           200, 100;
           200, 150;
           200, 200;
           150, 200;
             0, 200;
             0, 150;
             0, 100;
             0, 50
              ];

    for j=1:size(via,1)
        if j==1
            T1 = eye(2);
            T2 = rot2(0*pi/180);
        elseif j==2
            T1 = eye(2);
            T2 = rot2(0*pi/180);
        elseif j==3
            T1 = eye(2);
            T2 = rot2(0*pi/180);
        elseif j==4
            % T1 = diag([0.5,0.5]);
            T1 = [0 0; tan(pi/4), 1];
            T2 = rot2(90*pi/180);
        elseif j==5
            % T1 = diag([0.5,0.5]);
            T1 = [0 0; tan(pi/4), 1];
            T2 = rot2(90*pi/180);
        elseif j==6
            % T1 = diag([0.5,0.5]);
            T1 = [0 0; tan(pi/4), 1];
            T2 = rot2(90*pi/180);
        elseif j==7
            T1 = diag([0.5,0.5]);
            T2 = rot2(90*pi/180);
        elseif j==8
            T1 = diag([0.5,0.5]);
            T2 = rot2(180*pi/180);
        elseif j==9
            T1 = diag([0.5,0.5]);
            T2 = rot2(180*pi/180);
        elseif j==10
            T1 = diag([0.5,0.5]);
            T2 = rot2(-90*pi/180);
        elseif j==11
            T1 = eye(2);
            T2 = rot2(-90*pi/180);
        else
            T1 = eye(2); % diag([0.5,0.5]);
            T2 = rot2(-90*pi/180);
        end
        via_(j,:) = [vec(T1*T2)', via(j,:)];
        
%         % 查看轨迹具体情况
%         figure(1);
%         trashape{j} = r*T2'*T1' + via(j,:);    
%         for i=1:m
%           plot(trashape{j}(edge(:,i),1), trashape{j}(edge(:,i),2), 'k', 'LineWidth', 2); hold on;
%         end
    end
end
