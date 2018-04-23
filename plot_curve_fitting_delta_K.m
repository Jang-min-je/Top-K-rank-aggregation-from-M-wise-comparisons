%% Curve fitting
sample_delta_K = (0.1:0.01:0.3);
smooth_x_label = (0.1:0.01:0.3);

min = inf;
star = 0;
tmp = 0;

% Find constant (star) that minimizes distance between smooth curve and empirical sample complexity
for c = (1:1:10^6)
    smooth_curve = c*1./(sample_delta_K.^2);
    tmp = norm(smooth_curve - empirical_sample_complexity');
    if tmp < min
        min = tmp;
        star = c;
    end     
end


%% Plot

fig_inf = figure(2);
h(2) = plot(sample_delta_K, empirical_sample_complexity, 'b-o', 'LineWidth', 4, 'markers', 15);
hold on
h(1) = plot(smooth_x_label, star ./ smooth_x_label.^2, '--r', 'LineWidth', 4);
grid on
axis([0.1 0.30001 0 300000])
set(gca,'XTick',0.1:0.05:0.4)
set(gca,'FontSize',50)
set(gca,'YTick',0:100000:300000)
set(gca,'FontSize',50)
xlabel('$\Delta_K$', 'interpreter', 'latex', 'fontsize', 80)
ylabel('Minimal sample complexity', 'interpreter', 'latex', 'fontsize', 50)
lngd3 = legend('Empirical','Curve fitting: $1/\Delta_K^2$', 'Interpreter',  'latex','Location','NorthEast');
set( lngd3, 'Interpreter', 'latex', 'fontsize', 40, 'position', [0.47,0.6,0.4,0.28]  )
set(fig_inf,'Position', [100, 0, 1200,1000])