%% Figure 1 (Empirical minimal sample complexity v.s. M, Delta_K, n)

% find # of samples that achieves >95% success rate v.s. M
find_sample_complexity_vs_M;
plot_curve_fitting_M;

% find # of samples that achieves >95% success rate v.s. Delta_K
find_sample_complexity_vs_delta_K;
plot_curve_fitting_delta_K;

% find # of samples that achieves >95% success rate v.s. n
find_sample_complexity_vs_n;
plot_curve_fitting_n;

%% Figure 2 (Empirical success rate and overlap of five algorithms)

% Define parameters for algorithm evalutaion
parameters_fig2;

% Define metrics for algorithm evaluation
metrics_fig2;

% Run algorithms and evaluate them
run_algorithms_and_evaluation_fig2;

% plot figures 
plot_success_rate_and_overlap_fig2;

%% Figure 3 (linf error and success rate of Rank Centrality and Spectral MLE)
% Define parameters for algorithm evalutaion
parameters_fig3;

% Define metrics for algorithm evaluation
metrics_fig3;

% Run algorithms and evaluate them
run_algorithms_and_evaluation_fig3;

% plot figures 
plot_compare_RC_and_SMLE_fig3;


