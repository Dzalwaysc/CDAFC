function [] = verify_desYaw(desPos, desYaw, desYawd, desYawdd, tr, dt)
    figure(2);
    axis([-5 15 -15 5]);
    interval = 400;
    
    % 验证desYaw
    for i=1:interval:length(tr)
        scatter(desPos{1}(i,1), desPos{1}(i,2), 'r'); hold on
        draw_arrow(desPos{1}(i,:), desYaw{1}(i), 0.7, 'r'); hold on
    end
    
    % 验证desYawd
    Yaw = zeros(size(desYaw{1}));
    Yaw(1) = desYaw{1}(1);
    for i=1:length(tr)-1
        Yaw(i+1) = Yaw(i)+desYawd{1}(i)*dt;        
    end
    for i=1:interval:length(tr)
        scatter(desPos{1}(i,1), desPos{1}(i,2), 'xg'); hold on
        draw_arrow(desPos{1}(i,:), Yaw(i), 0.5, 'g'); hold on
    end
    
    % 验证desYawd
    Yaw = zeros(size(desYaw{1})); Yaw(1) = desYaw{1}(1);
    Yawd = zeros(size(desYaw{1})); Yawd(1) = desYawd{1}(1);
    for i=1:length(tr)-1
        Yawd(i+1) = Yawd(i)+desYawdd{1}(i)*dt;
        Yaw(i+1) = Yaw(i)+Yawd(i)*dt;        
    end
    for i=1:interval:length(tr)
        scatter(desPos{1}(i,1), desPos{1}(i,2), '+b'); hold on
        draw_arrow(desPos{1}(i,:), Yaw(i), 0.3, 'b'); hold on
    end
end
