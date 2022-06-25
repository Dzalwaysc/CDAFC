function [tao, ada_] = ctrEta(index, w, D, Eta, Etad, loop, Ada, V, dt)
    %% 控制律
    epos = [0, 0]; eyaw = 0; eposd = [0, 0]; eyawd = 0;
    edge_ind = find(D(index,:)~=0); 
    adai = Ada{index}(loop,:); Vi = V{index}(loop,:);
    for k=edge_ind
        % 找相邻的节点
        node_ind = find(D(:,k)~=0);
        j = node_ind(node_ind~=index);
        % 计算相关变量
        epos = epos + w(k)*(Eta{index}(loop,1:2)-Eta{j}(loop,1:2));
        eposd = eposd + w(k)*(Etad{index}(loop,1:2)-Etad{j}(loop,1:2));
        eyaw = eyaw + Eta{index}(loop,3)-Eta{j}(loop,3);
        eyawd = eyawd + Etad{index}(loop,3)-Etad{j}(loop,3);
    end
    k1 = diag([100,100,8]);
    z = [epos, eyaw];
    s = Etad{index}(loop,:) + z*k1;
    
    %% 自适应律
    [ada_, sum_ada] = adaptive(adai, s, z, Vi, dt);    
    tao = -sum_ada*s-ada_(5)*s;
    for i = 1:3
        if abs(tao(i))>500
            tao(i) = sign(tao(i))*500;
        end
    end
%     [tao(1), d1] = constraint_input(tao(1), 500);
%     [tao(2), d2] = constraint_input(tao(2), 500);
%     [tao(3), d3] = constraint_input(tao(3), 300);
end