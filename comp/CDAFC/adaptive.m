function [ada_, sum_ada] = adaptive(adai, s, z, Vi, dt)
    xita = 30;
    % start stage
    dada_ = ada_update(adai, s, z, Vi);
    K1 = dada_;
    
    % middle stage
    ada_ = adai + (dt/2)*K1;
    dada_ = ada_update(ada_, s, z, Vi);
    K2 = dada_;
    
    % middle stage
    ada_ = adai + (dt/2)*K2;
    dada_ = ada_update(ada_, s, z, Vi);
    K3 = dada_;
    
    % final stage
    ada_ = adai + (dt/2)*K3;
    dada_ = ada_update(ada_, s, z, Vi);
    K4 = dada_;
    
    ada_ = adai + (dt/6)*(K1+2*K2+2*K3+K4);

    sum_ada = ada_(1)^2/sqrt(norm(s)^2*ada_(1)^2+xita^2)...
            + (ada_(2)*norm(z))^2/sqrt(norm(s)^2*(ada_(2)*norm(z))^2+xita^2)...
            + (ada_(3)*norm(Vi)*norm(z))^2/sqrt(norm(s)^2*(ada_(3)*norm(Vi)*norm(z))^2+xita^2)...
            + (ada_(4)*norm(Vi)*norm(s))^2/sqrt(norm(s)^2*(ada_(4)*norm(Vi)*norm(s))^2+xita^2);  

end