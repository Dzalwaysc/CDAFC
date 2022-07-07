% 误差轨迹
for i=1:7
    Eta_Err{i} = [desPos{i},desYaw{1}]-Eta{i};
end

figure(5);
subplot(3,1,1);
plot(tr, Eta_Err{4}(:,1), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, Eta_Err{5}(:,1), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, Eta_Err{6}(:,1), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, Eta_Err{7}(:,1), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
ylabel('$$e_x$$(m)', 'interpreter', 'latex');
xlim([0,114]);
set(gca,'Fontsize',16);

subplot(3,1,2);
plot(tr, Eta_Err{4}(:,2), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, Eta_Err{5}(:,2), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, Eta_Err{6}(:,2), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, Eta_Err{7}(:,2), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
ylabel('$$e_y$$(m)', 'interpreter', 'latex');
xlim([0,114]);
set(gca,'Fontsize',16);

subplot(3,1,3);
plot(tr, Eta_Err{4}(:,3), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, Eta_Err{5}(:,3), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, Eta_Err{6}(:,3), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, Eta_Err{7}(:,3), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlabel('Time(s)');
ylabel('$$e_\psi$$(rad)', 'interpreter', 'latex');
xlim([0,114]);
set(gca,'Fontsize',16);

set(gcf,'Position',[100 100 860 520]);
