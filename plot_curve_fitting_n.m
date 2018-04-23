%% Curve fitting
sample_n = (200:100:1500);
smooth_x_label = (200:1:1500);

min = inf;
star = 0;
tmp = 0;

% Find constant (star) that minimizes distance between smooth curve and empirical sample complexity
for c = (0:1:10^6)
    smooth_curve = c*sample_n.*log(sample_n);
    tmp = norm(smooth_curve - empirical_sample_complexity');
    if tmp < min
        min = tmp;
        star = c;
    end     
end


%% Plot

fig_inf = figure(2);
h(2) = plot(sample_n, empirical_sample_complexity, 'b-o', 'LineWidth', 4, 'markers', 15);
hold on
h(1) = plot(smooth_x_label, star*smooth_x_label.*log(smooth_x_label), '--r', 'LineWidth', 4);
grid on
axis([200 1400 0 200000])
set(gca,'XTick',200:400:1500)
set(gca,'FontSize',50)
set(gca,'YTick',00000:50000:250000)
set(gca,'FontSize',50)
xlabel('$n$', 'interpreter', 'latex', 'fontsize', 80)
ylabel('Minimal sample complexity', 'interpreter', 'latex', 'fontsize', 50)
lngd3 = legend('Empirical','Curve fitting: $n \log n$', 'Interpreter',  'latex','Location','NorthEast');
set( lngd3, 'Interpreter', 'latex', 'fontsize', 40, 'position', [0.2,0.6,0.4,0.28]  )
set(fig_inf,'Position', [100, 0, 1200,1000])