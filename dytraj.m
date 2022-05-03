function [desYaw,desYawd,desYawdd] = dytraj(desPosd, tr, dt)
    % 艏向
    for i=1:length(tr)
        for j=1:size(desPosd,2)
            desYaw{j}(i,1) = atan2(desPosd{j}(i,2), desPosd{j}(i,1));
            if desYaw{j}(i,1) < 0
                desYaw{j}(i,1) = desYaw{j}(i,1) + 2*pi;
            end
        end   
    end
    
    % 艏向的一阶导
    for j=1:size(desPosd,2)
        desYawd{j} = [diff(desYaw{j})./dt; zeros(1)];
    end
    
    % 艏向的二阶导
    for j=1:size(desPosd,2)
        desYawdd{j} = [diff(desYawd{j})./dt; zeros(1)];
    end
end