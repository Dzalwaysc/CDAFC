% 控制律
figure(8);
subplot(3,1,1)
plot(tr(1:size(Tao{4},1)), Tao{4}(:,1), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{5}(:,1), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{6}(:,1), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{7}(:,1), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
set(gca,'Fontsize',16);
ylabel('$$\tau_i,u$$(N)', 'interpreter', 'latex');
legend('i=4', 'i=5', 'i=6', 'i=7', 'NumColumns', 4);
subplot(3,1,2)
plot(tr(1:size(Tao{4},1)), Tao{4}(:,2), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{5}(:,2), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{6}(:,2), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{7}(:,2), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
set(gca,'Fontsize',16);
ylabel('$$\tau_i,v$$(N)', 'interpreter', 'latex');

subplot(3,1,3)
plot(tr(1:size(Tao{4},1)), Tao{4}(:,3), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{5}(:,3), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{6}(:,3), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr(1:size(Tao{4},1)), Tao{7}(:,3), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
ylabel('$$\tau_i,r$$(N*m)', 'interpreter', 'latex');
xlabel('Time(s)');
set(gca,'Fontsize',16);
set(gcf,'Position',[100 100 860 520]);
