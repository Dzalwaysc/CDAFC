function [tao, dada] = ctrEta(index, w, D, Eta, Etad, loop, ada, V)
    epos = [0, 0]; eyaw = 0; eposd = [0, 0]; eyawd = 0;
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
    end
    k1 = diag([15,15,8]);
    z = [epos, eyaw];
    s = Etad{index}(loop,:) + z*k1;
    
    xita = 30;
    sum_ada = ada{index}(loop,1)^2/sqrt(norm(s)^2*ada{index}(loop,1)^2+xita^2)...
            + (ada{index}(loop,2)*norm(z))^2/sqrt(norm(s)^2*(ada{index}(loop,2)*norm(z))^2+xita^2)...
            + (ada{index}(loop,3)*norm(V{index}(loop,:))*norm(z))^2/sqrt(norm(s)^2*(ada{index}(loop,3)*norm(V{index}(loop,:))*norm(z))^2+xita^2)...
            + (ada{index}(loop,4)*norm(V{index}(loop,:))*norm(s))^2/sqrt(norm(s)^2*(ada{index}(loop,4)*norm(V{index}(loop,:))*norm(s))^2+xita^2);   
    
    tao = -sum_ada*s-ada{index}(loop,5)*s;
%     for i = 1:3
%         if abs(tao(i))>500
%             tao(i) = sign(tao(i))*500;
%         end
%     end
    [tao(1), d1] = constraint_input(tao(1), 500);
    [tao(2), d2] = constraint_input(tao(2), 500);
    [tao(3), d3] = constraint_input(tao(3), 300);
    
    % 自适应律
    gain1 = 0.008; gain1_ = 20;
    dada1 = gain1*(norm(s)-gain1_*ada{index}(loop,1));
    
    gain2 = 0.005; gain2_ = 20;
    dada2 = gain2*(norm(s)*norm(z)-gain2_*ada{index}(loop,2));
    
    gain3 = 0.001; gain3_ = 30;
    dada3 = gain3*(norm(s)*norm(V{index}(loop,:))*norm(z)-gain3_*ada{index}(loop,3));
    
    gain4 = 0.0005; gain4_ = 200;
    dada4 = gain4*(norm(s)^2*norm(V{index}(loop,:))-gain4_*ada{index}(loop,4));
    
    gain5 = 0.001; gain5_ = 0.1;
    dada5 = gain5*(norm(s)^2-gain5_*ada{index}(loop,5));
           
    dada = [dada1, dada2, dada3, dada4, dada5, sum_ada];

end
