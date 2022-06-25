function tao2 = ctrYaw(index, D, gamma2, Eta, Etad, Etadd, F, loop)
    eyaw = 0; eyawd = 0; eycc = 0; eyccd = 0;
    edge_ind = find(D(index,:)~=0);
    
    for k=edge_ind
        % 找相邻的节点
        node_ind = find(D(:,k)~=0);
        j = node_ind(node_ind~=index);
        % 计算相关变量
        eyaw = eyaw + Eta{index}(loop,3)-Eta{j}(loop,3);
        eyawd = eyawd + Etad{index}(loop,3)-Etad{j}(loop,3);
        eycc = eycc + Etad{j}(loop,3);
        eyccd = eyccd + Etadd{j}(loop,3);
    end
    
    % 控制器输出
    k3 = 10; k4 = 1.5;
    z3{index}(loop,:) = eyaw;
    alpha2{index}(loop,:) = -1/gamma2(index)*(k3*z3{index}(loop,:)-eycc);
    z4{index}(loop,:) = Etad{index}(loop,3)-alpha2{index}(loop,:);
    alpha2d{index}(loop,:) = -1/gamma2(index)*(k3*eyawd-eyccd);
    M2 = 2.76;
    tao2 = (alpha2d{index}(loop,:)-F{index}(loop,3)-gamma2(index)*z3{index}(loop,:) ...
            -k4*z4{index}(loop,:))*M2;
        
    if abs(tao2)>500
        tao2 = sign(tao2)*500;
    end
end