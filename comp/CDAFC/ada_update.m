function dada = ada_update(ada, s, z, V)
    gain1 = 0.008; gain1_ = 20;
    dada1 = gain1*(norm(s)-gain1_*ada(1));
    
    gain2 = 0.005; gain2_ = 20;
    dada2 = gain2*(norm(s)*norm(z)-gain2_*ada(2));
    
    gain3 = 0.001; gain3_ = 30;
    dada3 = gain3*(norm(s)*norm(V)*norm(z)-gain3_*ada(3));
    
    gain4 = 0.0005; gain4_ = 200;
    dada4 = gain4*(norm(s)^2*norm(V)-gain4_*ada(4));
    
    gain5 = 0.001; gain5_ = 0.1;
    dada5 = gain5*(norm(s)^2-gain5_*ada(5));
    
    dada = [dada1, dada2, dada3, dada4, dada5];
end