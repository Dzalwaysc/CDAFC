function out = dead_zone_500(r,u,R)
    pr = density_500(r,R);
    zr = max(u-r, min(0,u+r));
    out = pr*zr;
end