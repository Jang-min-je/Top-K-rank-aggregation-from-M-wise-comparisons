%% Curve fitting
sample_M = (3:1:15);
smooth_x_label = (3:0.01:15);

min = 100000;
star = 0;
tmp = 0;

% Find constant (star) that minimizes distance between smooth curve and empirical sample complexity
for c = (28759:0.1:28761)
    smooth_curve = c./sample_M;
    tmp = norm(smooth_curve - empirical_sample_complexity');
    if tmp < min
        min = tmp;
        star = c;
    end     
end


%% Plot
fig_inf = figure(2);
h(2) = plot(sample_M, empirical_sample_complexity, 'b-o', 'LineWidth', 4, 'markers', 15);
hold on
h(1) = plot(smooth_x_label, star./smooth_x_label, '--r', 'LineWidth', 4);
grid on
axis([3 15 0 10000])
set(gca,'XTick',3:2:15)
set(gca,'FontSize',50)
ax = gca;
ax.YAxis.Exponent = 3;
set(gca,'YTick',0:3000:12000)
set(gca,'FontSize',50)
xlabel('$M$', 'interpreter', 'latex', 'fontsize', 80)
ylabel('Minimal sample complexity', 'interpreter', 'latex', 'fontsize', 50)
lngd3 = legend('Empirical','Curve fitting: $1/M$', 'Interpreter',  'latex','Location','NorthEast');
set( lngd3, 'Interpreter', 'latex', 'fontsize', 40, 'position', [0.48,0.6,0.4,0.28]  )
set(fig_inf,'Position', [100, 0, 1200,1000])