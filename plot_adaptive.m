% 自适应律
figure(3);
subplot(5,1,1)
plot(tr, ada{4}(:,1), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, ada{5}(:,1), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, ada{6}(:,1), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, ada{7}(:,1), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
ylabel('$$\hat{\xi}_{i,1}$$', 'interpreter', 'latex');
set(gca,'Fontsize',16);

subplot(5,1,2)
plot(tr, ada{4}(:,2), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, ada{5}(:,2), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, ada{6}(:,2), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, ada{7}(:,2), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
ylabel('$$\hat{\xi}_{i,2}$$', 'interpreter', 'latex');
set(gca,'Fontsize',16);

subplot(5,1,3)
plot(tr, ada{4}(:,3), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, ada{5}(:,3), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, ada{6}(:,3), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, ada{7}(:,3), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
ylabel('$$\hat{\xi}_{i,3}$$', 'interpreter', 'latex');
set(gca,'Fontsize',16);

subplot(5,1,4)
plot(tr, ada{4}(:,4), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, ada{5}(:,4), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, ada{6}(:,4), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, ada{7}(:,4), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
xlim([0,480]);
ylabel('$$\hat{\xi}_{i,4}$$', 'interpreter', 'latex');
set(gca,'Fontsize',16);


% 全分布式律
subplot(5,1,5)
plot(tr, ada{4}(:,5), '--', 'Color', [0 0.4470 0.7410], 'LineWidth', 1); hold on
plot(tr, ada{5}(:,5), ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); hold on
plot(tr, ada{6}(:,5), '-.', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1); hold on
plot(tr, ada{7}(:,5), '-', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1); hold on
ylabel('$$\hat{\Xi}_{i}$$', 'interpreter', 'latex');
xlim([0,480]);
xlabel('Time(s)');
set(gca,'Fontsize',16);

set(gcf,'Position',[100 -100 860 760]);