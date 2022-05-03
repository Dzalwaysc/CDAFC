function [tao_contraint, d] = constraint_input(tao, max_tao)
        R = 1000;
        d = Pra_500(R,tao);
        tao_contraint = p0_500(R)*tao - d;      
end