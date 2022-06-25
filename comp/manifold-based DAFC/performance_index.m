%% 性能指标计算，把误差累加

for i=1:7
    Eta_Err{i} = [desPos{i},desYaw{1}]-Eta{i};
    for j=1:size(desPos{1},1)
        if abs(Eta_Err{i}(j,3))>0.1
            Eta_Err{i}(j,3) = Eta_Err{i}(j,3) - 0.1*sign(Eta_Err{i}(j,3));
        end
    end
end


len = size(Eta_Err{i},1); Theorem1_IAE = 0;
for i=1:len-1
    Theorem1_IAE = Theorem1_IAE + norm([Eta_Err{4}(i,:), Eta_Err{5}(i,:), Eta_Err{6}(i,:), Eta_Err{7}(i,:)]);
    if i == 2000
         Theorem1_IAE2000 = Theorem1_IAE;
    elseif i == 4000
        Theorem1_IAE4000 = Theorem1_IAE;
    elseif i == 6000
        Theorem1_IAE6000 = Theorem1_IAE;
    elseif i == 8000
        Theorem1_IAE8000 = Theorem1_IAE;
    elseif i == 10000
        Theorem1_IAE10000 = Theorem1_IAE;
    end
end