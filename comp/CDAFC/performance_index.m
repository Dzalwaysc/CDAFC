%% 性能指标计算，把误差累加

for i=1:7
    Eta_Err{i} = [desPos{i},desYaw{1}]-Eta{i};
    for j=1:size(desPos{1},1)
        if abs(Eta_Err{i}(j,3))>0.1
            Eta_Err{i}(j,3) = Eta_Err{i}(j,3) - 0.1*sign(Eta_Err{i}(j,3));
        end
    end
end


len = size(Eta_Err{i},1); Theorem2_IAE = 0;
for i=1:len-1
    Theorem2_IAE = Theorem2_IAE + norm([Eta_Err{4}(i,:), Eta_Err{5}(i,:), Eta_Err{6}(i,:), Eta_Err{7}(i,:)]);
    if i == 2000
         Theorem2_IAE2000 = Theorem2_IAE;
    elseif i == 4000
        Theorem2_IAE4000 = Theorem2_IAE;
    elseif i == 6000
        Theorem2_IAE6000 = Theorem2_IAE;
    elseif i == 8000
        Theorem2_IAE8000 = Theorem2_IAE;
    elseif i == 10000
        Theorem2_IAE10000 = Theorem2_IAE;
    end
end

t = [0, 20, 40, 60, 80, 100, 115];
Back_method = [0, Back_IAE2000, Back_IAE4000, Back_IAE6000, Back_IAE8000, Back_IAE10000, Back_IAE]/1000;
Theorem1_method = [0, Theorem1_IAE2000, Theorem1_IAE4000, Theorem1_IAE6000, Theorem1_IAE8000, Theorem1_IAE10000, Theorem1_IAE]/1000;
Theorem2_method = [0, Theorem2_IAE2000, Theorem2_IAE4000, Theorem2_IAE6000, Theorem2_IAE8000, Theorem2_IAE10000, Theorem2_IAE]/1000;
plot(t,Back_method,'-.sb', t,Theorem1_method,'--or', t,Theorem2_method,':hm', 'LineWidth', 1);
ylabel('IAE=$\int_{0}^{t}\left\| e\left( o \right) \right\|$d$o$', 'Interpreter', 'latex');
xlabel('Time(s)');
legend('backstepping-based DAFC', 'manifold-based DAFC', 'CDAFC');
set(gca, 'FontSize', 16);