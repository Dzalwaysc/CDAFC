function [tao] = ctrEta(index, w, D, Eta, Etad, Etadd, M__, C__, D__, loop)
    epos = [0, 0]; eyaw = 0; eposd = [0, 0]; eyawd = 0;
    posdd = [0, 0]; yawdd = 0; alpha = 0;
    edge_ind = find(D(index,:)~=0);
    
    for k=edge_ind
        % 找相邻的节点
        node_ind = find(D(:,k)~=0);
        j = node_ind(node_ind~=index);
        % 计算相关变量
        epos = epos + w(k)*(Eta{index}(loop,1:2)-Eta{j}(loop,1:2));
        eposd = eposd + w(k)*(Etad{index}(loop,1:2)-Etad{j}(loop,1:2));
        eyaw = eyaw + Eta{index}(loop,3)-Eta{j}(loop,3);
        eyawd = eyawd + Etad{index}(loop,3)-Etad{j}(loop,3);
        
        alpha = alpha - diag([w(k), w(k), 1]);
        posdd = posdd + -w(k)*Etadd{j}(loop,1:2);
        yawdd = yawdd + -1*Etadd{j}(loop,3);
    end
    k1 = diag([300,300,18]); h = 300;
    z = [epos, eyaw]; zd = [eposd, eyawd]; zdd = [posdd, yawdd];
    s = zd + z*k1;
    
    M__ = reshape(M__{index}(loop,:), 3, 3);
    C__ = reshape(C__{index}(loop,:), 3, 3);
    D__ = reshape(D__{index}(loop,:), 3, 3);
    
    tao = Etad{index}(loop,:) * C__' + Etad{index}(loop,:) * D__' ...
        + (zdd + h*s) * M__' * inv(alpha);

    for i = 1:3
        if abs(tao(i))>500
            tao(i) = sign(tao(i))*500;
        end
    end
end
