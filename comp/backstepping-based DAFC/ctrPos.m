function tao1 = ctrPos(index, w, D, gamma1, Eta, Etad, Etadd, F, loop)
    epos = [0, 0]; eposd = [0, 0]; eacc = [0, 0]; eaccd = [0, 0];
    edge_ind = find(D(index,:)~=0);
    
    for k=edge_ind
        % 找相邻的节点
        node_ind = find(D(:,k)~=0);
        j = node_ind(node_ind~=index);
        % 计算相关变量
        epos = epos + w(k)*(Eta{index}(loop,1:2)-Eta{j}(loop,1:2));
        eposd = eposd + w(k)*(Etad{index}(loop,1:2)-Etad{j}(loop,1:2));
        eacc = eacc + w(k)*Etad{j}(loop,1:2);
        eaccd = eaccd + w(k)*Etadd{j}(loop,1:2);
    end
    
    % 控制器输出
    k1 = 10; k2 = 1.5;
    z1{index}(loop,:) = epos;
    alpha1{index}(loop,:) = -1/gamma1(index)*(k1*z1{index}(loop,:)-eacc);
    z2{index}(loop,:) = Etad{index}(loop,1:2)-alpha1{index}(loop,:);
    alpha1d{index}(loop,:) = -1/gamma1(index)*(k1*eposd-eaccd);
    M1 = [25.8 0; 0 33.8];
    tao1 = (alpha1d{index}(loop,:)-F{index}(loop,1:2)-gamma1(index)*z1{index}(loop,:) ...
             -k2*z2{index}(loop,:))*M1;
         
    for i = 1:2
        if abs(tao1(i))>500
            tao1(i) = sign(tao1(i))*500;
        end
    end
end