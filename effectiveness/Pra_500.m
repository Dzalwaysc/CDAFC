function out = Pra_500(R,u)
    fun = @(x,u) dead_zone_500(x,u,R);
    out = integral(@(x) fun(x,u),0,R,'ArrayValued', true);
end
