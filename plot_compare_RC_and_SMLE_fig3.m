xsize = [10, 50, 100, 150, 200, 250];
xsize2 = [1, 5, 10, 15, 20, 25];


fig_densuc = figure(1);
plot(sample_L(1,:), RC_success(:,1)', 'r', 'LineWidth', 4)
hold on
plot(sample_L(1,:), SMLE_success(:,1)', '--b', 'LineWidth', 4)
grid on
axis([10 250 0 1])
set(gca,'XTick',xsize)
set(gca,'FontSize',50)
set(gca,'YTick',0:0.2:1)
set(gca,'FontSize',50)
xlabel('$L$', 'interpreter', 'latex', 'fontsize', 60)
ylabel('Empirical success rate', 'interpreter', 'latex', 'fontsize', 60)
lngd1 = legend('Rank Centrality: $p=0.025$', 'Spectral MLE: $p=0.025$', 'Borda Count: $p=0.025$');
set(lngd1, 'fontsize', 40, 'Interpreter', 'latex');
set(lngd1, 'Position', [0.34,0.23,0.52,0.28] );
set(fig_densuc,'Position', [100, 0, 1800, 1000])





fig_denl = figure(2);
plot(sample_L(1,:), RC_Linf(:,1)', 'r', 'LineWidth', 4)
hold on
plot(sample_L(1,:), SMLE_Linf(:,1)', '--b', 'LineWidth', 4)
grid on
axis([10 250 0 0.5])
set(gca,'XTick',xsize)
set(gca,'FontSize',50)
set(gca,'YTick',0:0.1:0.5)
set(gca,'FontSize',50)
xlabel('$L$', 'interpreter', 'latex', 'fontsize', 60);
ylabel('$\ell_\infty$ error', 'interpreter', 'latex', 'fontsize', 60);
lngd2 = legend('Rank Centrality: $p=0.025$', 'Spectral MLE: $p=0.025$');
set(lngd2, 'fontsize', 40, 'Interpreter', 'latex', 'Position', [0.34,0.62,0.52,0.28] )
set(fig_denl,'Position', [100, 0, 1800, 1000])


fig_spasuc = figure(3);
plot(sample_L(2,:), RC_success(:,2)', 'r', 'LineWidth', 4)
hold on
plot(sample_L(2,:), SMLE_success(:,2)', '--b', 'LineWidth', 4)
grid on
axis([1 25 0 1])
set(gca,'XTick',xsize2)
set(gca,'FontSize',50)
set(gca,'YTick',0:0.2:1)
set(gca,'FontSize',50)
xlabel('$L$', 'interpreter', 'latex', 'fontsize', 60);
ylabel('Empirical success rate', 'interpreter', 'latex', 'fontsize', 60);
lngd3 = legend('Rank Centrality: $p=0.25$', 'Spectral MLE: $p=0.25$', 'Borda Count: $p=0.25$');
set(lngd3, 'fontsize', 40, 'Interpreter', 'latex', 'Position', [0.34,0.23,0.52,0.28]  )
set(fig_spasuc,'Position', [100, 0, 1800, 1000])


fig_spal = figure(4);
plot(sample_L(2,:), RC_Linf(:,2)', 'r', 'LineWidth', 4)
hold on
plot(sample_L(2,:), SMLE_Linf(:,2)', '--b', 'LineWidth', 4)
grid on
axis([1 25 0 0.5])
set(gca,'XTick',xsize2)
set(gca,'FontSize',50)
set(gca,'YTick',0:0.1:0.5)
set(gca,'FontSize',50)
xlabel('$L$', 'interpreter', 'latex', 'fontsize', 60);
ylabel('$\ell_\infty$ error', 'interpreter', 'latex', 'fontsize', 60);
lngd4 = legend('Rank Centrality: $p=0.25$', 'Spectral MLE: $p=0.25$');
set(lngd4, 'fontsize', 40, 'Interpreter', 'latex', 'Position', [0.34,0.62,0.52,0.28] )
set(fig_spal,'Position', [100, 0, 1800, 1000])


