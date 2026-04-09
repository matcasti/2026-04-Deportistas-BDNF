---
title: "index"
format: html
---

```{r}
#| include: false

## Load libraries
library(data.table)
library(brms)
library(datawizard)
library(gt)

## Load data
load("../data/athletes.RData")

## Load models
fit_time <- readRDS("../models/fit_hrv_time_cc_adj.rds")
fit_freq <- readRDS("../models/fit_hrv_freq_cc_adj.rds")

## Load model results
fit_results <- fread(file = "../output/model_estimates.csv")
fit_results[, label := paste0(
  paste0("$\beta$ = ", `Std. Effect`),
  paste0(", CI~95%~", `95% CI`),
  paste0(", pd = ", pd*100, "%"),
  paste0(", ps = ", ps*100, "%")
)]

## Load tables
load("../output/tbl_1.RData")
load("../output/tbl_2.RData")
```

# Results

## Sample characterization

The cross-sectional analysis included a total of 34 athletes, comprising 19 males and 15 females. The cohort presented a mean age of 26.5 ± 10.0 years (Age (years old), Overall N = 34). Participants reported a consistent training background, with an average sport practice frequency of 4.2 ± 1.4 times per week (Sport practice frequency (times per week)) and an accumulated sport practice experience of 48.0 ± 41.0 months.

Hemodynamic assessment revealed baseline parameters typical of an athletic population. The mean resting heart rate was 67.4 ± 13.5 beats per minute (Resting heart rate (bpm)), with males presenting a lower resting rate of 64.1 ± 12.7 bpm compared to 71.9 ± 13.5 bpm in females. Mean arterial pressure averaged 87.4 ± 8.4 mmHg across the sample.

Anthropometric and body composition measures demonstrated expected sexual dimorphism. Males exhibited higher total body weight (Body weight (kg), Male N = 19: 77.6 ± 17.9; Female N = 15: 68.0 ± 10.5) and lower total body fat relative to females (Body fat (%), Male N = 19: 17.1 ± 7.1; Female N = 15: 27.9 ± 5.1). Absolute muscle mass was superior in male participants (Muscle mass (kg), Male N = 19: 60.7 ± 9.7; Female N = 15: 46.6 ± 5.0). The overall body mass index stood at 26.0 ± 5.2 kg/m².

Resting autonomic modulation, quantified through heart rate variability, showed substantial inter-individual variance. The root mean square of successive differences averaged 85.8 ± 124.2 ms (RMSSD (ms)), and the standard deviation of NN intervals was 75.6 ± 84.5 ms (SDNN (ms)). Frequency-domain metrics similarly displayed large standard deviations, with high-frequency power averaging 5,460.3 ± 17,748.8 ms² (HF (ms²)) and low-frequency power at 16,093.6 ± 72,752.2 ms² (LF (ms²)).

All sample characteristics can be observed in @tbl-descriptivies.

```{r}
#| echo: false
#| label: tbl-descriptivies
#| column: page
tbl_1 |> 
  gt::tab_style(
    style = gt::cell_text(size = 12, whitespace = "nowrap"), 
    locations = list(
      gt::cells_body(), 
      gt::cells_column_labels(), 
      gt::cells_column_spanners()
      )
    )
```

**Table 1**. Overall, and aggregated by sex, sample characteristics in basic sociodemographic, anthropometric and physiological variables from standardized assessments. Data is presented as mean ± standard deviation. Differences between males and females is presented as standardized mean difference and 95% confidence interval.

## Cardiac autonomic modulation

Sport practice frequency demonstrates a positive relationship with all heart rate variability parameters. The model is certain of an effect of sport practice frequency on high-frequency power ($\beta$ = 0.8, CI~95%~[0.24, 1.37], pd = 99.6%, ps = 99%). High-frequency power captures respiratory sinus arrhythmia and maps directly to parasympathetic nervous system activity. The model is certain of an effect on low-frequency power ($\beta$ = 0.82, CI~95%~[0.22, 1.36], pd = 99.6%, ps = 99.2%) and very-low-frequency power ($\beta$ = 0.8, CI~95%~[0.22, 1.37], pd = 99.6%, ps = 99%). Similar certain positive effects appear in the time-domain metrics. The frequency of practice increases the standard deviation of NN intervals ($\beta$ = 0.89, CI~95%~[0.19, 1.52], pd = 99.4%, ps = 98.8%) and the root mean square of successive differences ($\beta$ = 0.86, CI~95%~[0.22, 1.49], pd = 99.3%, ps = 98.8%). The mean RR interval also lengthens with higher practice frequency ($\beta$ = 0.69, CI~95%~[0.16, 1.2], pd = 99.3%, ps = 98.3%). Repeated weekly physical training drives functional adaptations in the autonomic nervous system. The regular physiological stimulus enhances vagal tone at rest, leading to higher RMSSD and HF values. The increases in LF and VLF power suggest broad changes in baroreflex sensitivity and endothelial function associated with frequent exercise.

Sport practice experience shows a negative main effect across multiple variables. The model is certain of a negative effect on high-frequency power ($\beta$ = -0.56, CI~95%~[-1.05, -0.1], pd = 98.8%, ps = 97.3%) and very-low-frequency power ($\beta$ = -0.5, CI~95%~[-0.98, -0.01], pd = 97.9%, ps = 95.5%). The data are indicative of a negative effect on low-frequency power ($\beta$ = -0.5, CI~95%~[-0.97, 0], pd = 97.8%, ps = 95.1%). In the time domain, the model is certain of a negative effect on RMSSD ($\beta$ = -0.54, CI~95%~[-1.1, -0.02], pd = 97.6%, ps = 95.3%) and SDNN ($\beta$ = -0.49, CI~95%~[-1.05, 0.07], pd = 96%, ps = 92%). Accumulated months of sport practice, absent adequate recovery, manifests as a depressed autonomic profile. Chronic physical stress increases allostatic load, leading to parasympathetic withdrawal even at rest. Prolonged exposure to high training volumes without concurrent increases in fitness blunts the normal cardiac autonomic tone.

The interaction between body fat percentage and sport practice frequency exhibits a certain negative effect across the frequency and time domains. The combination of high body fat and high weekly training frequency reduces high-frequency power ($\beta$ = -1.12, CI~95%~[-1.8, -0.44], pd = 99.8%, ps = 99.7%), low-frequency power ($\beta$ = -1.1, CI~95%~[-1.8, -0.42], pd = 99.8%, ps = 99.7%), and very-low-frequency power ($\beta$ = -1.1, CI~95%~[-1.79, -0.41], pd = 99.8%, ps = 99.6%). The model is certain of a negative effect of this interaction on time-domain measures, including SDNN ($\beta$ = -0.88, CI~95%~[-1.66, -0.05], pd = 98.1%, ps = 96.9%) and RMSSD ($\beta$ = -0.93, CI~95%~[-1.69, -0.13], pd = 98.8%, ps = 97.9%). Adipose tissue is an active endocrine organ that secretes pro-inflammatory cytokines such as interleukin-6. Systemic low-grade inflammation alters afferent vagal signaling and central autonomic integration. The presence of excess body fat impairs the capacity of frequent exercise to increase parasympathetic tone. The autonomic benefits of repeated weekly sessions fail to materialize in individuals with higher adiposity.

The model reveals interactions between body fat percentage and sport practice experience. The data are certain of a positive effect of this interaction on high-frequency power ($\beta$ = 1.01, CI~95%~[-0.05, 2.18], pd = 96.5%, ps = 95.1%). The model is indicative of a positive effect on low-frequency power ($\beta$ = 0.85, CI~95%~[-0.28, 1.97], pd = 93.8%, ps = 91.4%) and very-low-frequency power ($\beta$ = 0.83, CI~95%~[-0.3, 1.96], pd = 93.3%, ps = 91.1%). In the time domain, the effect is indicative on RMSSD ($\beta$ = 1.00, CI~95%~[-0.21, 2.27], pd = 94.6%, ps = 92.6%) and SDNN ($\beta$ = 0.99, CI~95%~[-0.3, 2.31], pd = 93.8%, ps = 91.8%). This indicates a possible selection effect in the cohort, where individuals who maintain training over long periods despite higher body fat have developed specific compensatory physiological profiles, or it relates to specific types of sports where body mass and prolonged experience coincide with distinct cardiovascular adaptations.

Mean arterial pressure exhibits a negative relationship with several autonomic parameters. The model is certain of a negative effect on the mean RR interval ($\beta$ = -0.78, CI~95%~[-1.54, -0.03], pd = 97.8%, ps = 96.5%). The data are indicative of a negative effect on high-frequency power ($\beta$ = -0.65, CI~95%~[-1.51, 0.12], pd = 94.9%, ps = 91.7%), SDNN ($\beta$ = -0.77, CI~95%~[-1.72, 0.15], pd = 95%, ps = 92.7%), and RMSSD ($\beta$ = -0.73, CI~95%~[-1.64, 0.19], pd = 94.4%, ps = 92.1%). Elevated mean arterial pressure demands continuous adjustment of the baroreflex mechanism. Chronic pressure elevation leads to baroreceptor resetting, which downregulates efferent vagal traffic to the heart. This autonomic adjustment reduces overall variability and elevates the baseline heart rate, generating shorter RR intervals.

Age presents specific main and interaction effects. The model is certain of a positive main effect of age on the mean RR interval ($\beta$ = 0.95, CI~95%~[0.31, 1.53], pd = 99.6%, ps = 99.4%). The data are indicative of a positive main effect on high-frequency power ($\beta$ = 0.48, CI~95%~[-0.17, 1.13], pd = 93.4%, ps = 88.4%) and low-frequency power ($\beta$ = 0.45, CI~95%~[-0.21, 1.11], pd = 92%, ps = 86.7%). While biological aging generally reduces heart rate variability, this specific athletic cohort exhibits longer baseline RR intervals at older ages. This indicates a possible selection effect where older participants in the sample possess superior baseline fitness. Age interacts with muscle mass to produce negative effects. The model is indicative of a negative effect of this interaction on high-frequency power ($\beta$ = -0.65, CI~95%~[-1.61, 0.17], pd = 93.5%, ps = 90.2%) and SDNN ($\beta$ = -0.77, CI~95%~[-1.75, 0.26], pd = 93.5%, ps = 90.8%). As individuals age, the protective autonomic effects associated with higher skeletal muscle mass diminish. Athrophic changes involves changes in muscle quality and the decline of specific fast-twitch fibers, which alters the myokine profile and changes how muscle tissue communicates with the central nervous system.

Total muscle mass as a main effect is somewhat suggesting of a positive relationship with high-frequency power ($\beta$ = 0.49, CI~95%~[-0.53, 1.47], pd = 84%, ps = 78.7%) and SDNN ($\beta$ = 0.55, CI~95%~[-0.59, 1.74], pd = 84.3%, ps = 80.1%). The interaction between muscle mass and sport practice experience is indicative of a positive effect on high-frequency power ($\beta$ = 1.13, CI~95%~[-0.43, 2.71], pd = 93.2%, ps = 91.5%) and RMSSD ($\beta$ = 1.13, CI~95%~[-0.6, 2.9], pd = 90.4%, ps = 88.3%). High skeletal muscle volume provides a metabolic sink for glucose and reduces peripheral insulin resistance. Long-term training adaptations in individuals with higher muscle mass improve endothelial function and augment parasympathetic regulation. The interaction proves that the autonomic benefits of muscle mass require prolonged training experience to manifest completely in the resting neurocardiac profile.

Main effects of body fat percentage are indicative of a negative relationship with high-frequency power ($\beta$ = -0.74, CI~95%~[-1.85, 0.39], pd = 91.1%, ps = 87.9%) and low-frequency power ($\beta$ = -0.79, CI~95%~[-1.92, 0.33], pd = 91.9%, ps = 89.1%). There is a certain interaction effect between body fat and age on the mean RR interval ($\beta$ = 0.6, CI~95%~[-0.05, 1.19], pd = 97.1%, ps = 94.9%). Increases in total body fat independently lower the amplitude of respiratory sinus arrhythmia. The structural accumulation of visceral and subcutaneous fat increases resting sympathetic tone to support the expanded vascular bed. This directly reduces the variation observed in consecutive heartbeats. The specific physiological interaction with age confirms that older athletes tolerate adiposity differently regarding their baseline heart rate, possibly due to concurrent changes in maximum heart rate and intrinsic sinus node function.

The model evaluates very-low-frequency power, a metric deeply tied to thermoregulation and peripheral vasomotor activity controlled by the renin-angiotensin-aldosterone system. The main effect of sport practice frequency indicates a certain positive relationship with VLF power ($\beta$ = 0.8, CI~95%~[0.22, 1.37], pd = 99.6%, ps = 99%). Regular training induces chronic volume expansion and alters the sensitivity of the renin-angiotensin-aldosterone system to orthostatic challenge and thermal stress. The augmentation of VLF power points to improved vasomotor reserves. However, the data show an indicative negative interaction between body fat percentage and sport practice frequency on VLF ($\beta$ = -1.1, CI~95%~[-1.79, -0.41], pd = 99.8%, ps = 99.6%). Adipose tissue dysfunction alters circulating aldosterone levels and produces local vascular resistance. The systemic effects of excessive adiposity constrain the adaptive changes in the microvasculature usually induced by frequent exercise.

Low-frequency power captures a mix of sympathetic and parasympathetic activity, heavily influenced by baroreceptor reflexes. The indicative negative main effect of body fat on LF power ($\beta$ = -0.79, CI~95%~[-1.92, 0.33], pd = 91.9%, ps = 89.1%) demonstrates the suppressive action of adiposity on baroreflex sensitivity. Obese states involve chronic sympathetic hyperactivity. When baseline sympathetic outflow is saturated, the regulatory oscillations detected in the low-frequency band diminish. Sport practice frequency acts against this suppression, exhibiting a certain positive effect ($\beta$ = 0.82, CI~95%~[0.22, 1.36], pd = 99.6%, ps = 99.2%). Frequent exercise training resets the baroreceptor operating point and widens its functional range, thereby amplifying the oscillations in blood pressure and heart rate captured by the low-frequency band.

The physiological interpretation of the negative interaction between muscle mass and sport practice frequency is somewhat suggesting of an effect on high-frequency power ($\beta$ = -0.37, CI~95%~[-1.14, 0.4], pd = 83.6%, ps = 76.5%). While muscle mass alone benefits the metabolic profile, extremely high muscle mass coupled with high training frequency represents resistance training protocols that induce chronic sympathetic arousal rather than the parasympathetic dominance associated with endurance training. Hypertrophy protocols impose massive mechanical tension and localized metabolic acidosis, requiring extended recovery periods. Without proper recovery, high frequency in heavily muscled individuals maintains an elevated sympathetic baseline, slightly compressing high-frequency variability.

Mean RR interval variations further clarify the interaction between physical structure and autonomic function. The indicative negative effect of mean arterial pressure on Mean RR ($\beta$ = -0.78, CI~95%~[-1.54, -0.03], pd = 97.8%, ps = 96.5%) confirms the inverse relationship between blood pressure and RR interval duration at rest. Higher vascular resistance requires a faster resting heart rate to maintain adequate cardiac output. The somewhat suggesting positive effect of muscle mass on Mean RR ($\beta$ = 0.56, CI~95%~[-0.42, 1.43], pd = 89.5%, ps = 85.3%) links skeletal muscle metabolic efficiency to lower resting heart rates. Muscle tissue acts as a primary site for glucose disposal and lipid oxidation. High metabolic efficiency in muscle reduces the resting cardiac demand, allowing for vagally mediated bradycardia.

RMSSD quantifies the beat-to-beat variance in heart rate and serves as the primary time-domain measure of parasympathetic activity. The vagus nerve innervates the sinoatrial node and modulates the heart rate on a timescale of milliseconds. This rapid signaling creates the high-frequency variability captured by RMSSD. The certain negative main effect of sport practice experience on RMSSD ($\beta$ = -0.54, CI~95%~[-1.1, -0.02], pd = 97.6%, ps = 95.3%) establishes a state of depressed vagal tone. Athletes with high months of accumulated experience encounter periods of non-functional overreaching. This state suppresses the fast vagal modulations at the sinoatrial node, and the variance between successive beats drops.

SDNN calculates the standard deviation of all normal RR intervals during the recording period. It captures both sympathetic and parasympathetic influences and estimates overall heart rate variability. The certain positive main effect of sport practice frequency on SDNN ($\beta$ = 0.89, CI~95%~[0.19, 1.52], pd = 99.4%, ps = 98.8%) proves that frequent training expands the total regulatory capacity of the autonomic nervous system. The heart commands a wider dynamic range of intervals to match metabolic demands. Conversely, the indicative negative interaction of muscle mass and age on SDNN ($\beta$ = -0.77, CI~95%~[-1.75, 0.26], pd = 93.5%, ps = 90.8%) defines a systemic constraint. The combined condition of advanced age and high muscle mass restricts the total variance of the cardiac cycle. Older individuals with high muscle mass exhibit stiffer arterial walls or altered mechanoreceptor feedback, compressing the total variability of the RR intervals.

Pulse pressure measures the difference between systolic and diastolic blood pressure and acts as an indirect proxy for arterial stiffness. The parameter estimates for pulse pressure did not cross the threshold of 0.8 for the probability of direction across the time and frequency domains. Mean arterial pressure exerts a stronger regulatory influence on resting heart rate variability than arterial stiffness in this specific athletic population. Mean arterial pressure drives the continuous steady-state perfusion of organs. The baroreceptors located in the carotid sinus and aortic arch respond directly to changes in mean pressure. The indicative negative effects of mean arterial pressure on high-frequency power ($\beta$ = -0.65, CI~95%~[-1.51, 0.12], pd = 94.9%, ps = 91.7%) and very-low-frequency power ($\beta$ = -0.55, CI~95%~[-1.37, 0.27], pd = 91.4%, ps = 87.3%) prove that higher perfusion pressures require systemic autonomic recalibration. The central nervous system downregulates efferent vagal traffic to accommodate the higher baseline pressure, reducing the high-frequency and very-low-frequency oscillations.

All the model estimates can be observed in @tbl-model-estimates.


```{r}
#| echo: false
#| label: tbl-model-estimates
#| column: page
tbl_2 |> 
  gt::tab_style(
    style = gt::cell_text(size = 12, whitespace = "nowrap"), 
    locations = list(
      gt::cells_body(), 
      gt::cells_column_labels(), 
      gt::cells_column_spanners(),
      gt::cells_row_groups()
      )
    )
```

**Table 2**. Estimates from a Bayesian multivariate multiple regression framework to model the heart rate variability parameters as a function of the linear contribution of body composition variables and confounding factors. Data is presented as standardized effects, 95% credible intervals, probability of direction (pd), probability of significance (ps) and bayes factor against the null hypothesis (BF).

# Statistical analysis

We utilized a Bayesian multivariate multiple regression framework to model the heart rate variability parameters. Modeling multiple response variables simultaneously accounts for the inherent covariance structure among the dependent variables. Heart rate variability metrics derive from the same underlying physiological signals and possess strong mathematical and biological correlations. Fitting separate univariate models ignores this covariance and increases the probability of Type I errors.

We constructed two distinct multivariate models. The time-domain model combined the root mean square of successive differences between normal heartbeats, the standard deviation of NN intervals, and the mean RR interval into a single response matrix.

$$
Y_{time} = \begin{bmatrix} \rm RMSSD \\ \rm SDNN \\ \rm Mean~RR \end{bmatrix}
$$

The frequency-domain model combined high-frequency power, low-frequency power, and very-low-frequency power into a separate response matrix.

$$
Y_{freq} = \begin{bmatrix} \rm HF \\ \rm LF \\ \rm VLF \end{bmatrix}
$$

We assumed that each multivariate response vector follows a multivariate normal distribution. The distribution is parameterized by a mean vector and a covariance matrix.

$$
Y \sim \mathcal{N}(\mu, \Sigma)
$$

The mean vector $\mu$ is defined by a linear predictor. The model formula incorporates continuous measures of total body fat and total muscle mass. It includes categorical and continuous demographic variables representing sex and age. Training variables include sport practice frequency and sport practice experience in months. Hemodynamic control variables include mean arterial pressure and pulse pressure. The syntax specifies two-way interactions between the body composition metrics and the demographic and training variables. This allows the model to test whether the effects of training and age depend on the physical structure of the athlete. The equation for the linear predictor expands to include the main effects and the interaction terms.

$$
\mu = \beta_0 + \beta_1 X_{\rm fat} + \beta_2 X_{\rm muscle} + \beta_3 X_{\rm sex} + \beta_4 X_{\rm age} + \beta_5 X_{\rm freq} + \beta_6 X_{\rm exp} + \beta_7 X_{\rm pam} + \beta_8 X_{\rm pp} + \gamma_{\rm interactions}
$$

The $\gamma_{interactions}$ term represents the cross-products of the variables specified in the model formula. Specifically, total body fat interacts with sex, age, practice frequency, and practice experience. Total muscle mass interacts with the same four demographic and training variables.

The covariance matrix $\Sigma$ captures the residual variance for each response variable and the residual covariance between all pairs of response variables. For a three-dimensional response vector, the covariance matrix is a three-by-three symmetric matrix.

$$
\Sigma = \begin{bmatrix} \sigma_1^2 & \rho_{12}\sigma_1\sigma_2 & \rho_{13}\sigma_1\sigma_3 \\ \rho_{21}\sigma_2\sigma_1 & \sigma_2^2 & \rho_{23}\sigma_2\sigma_3 \\ \rho_{31}\sigma_3\sigma_1 & \rho_{32}\sigma_3\sigma_2 & \sigma_3^2 \end{bmatrix}
$$

In this matrix, $\sigma_k^2$ represents the residual variance for the $k$-th response variable. The term $\rho_{jk}$ represents the residual correlation between the $j$-th and $k$-th response variables.

Data preparation involved standardizing the continuous predictor and response variables to a zero mean and a standard deviation of one. Standardizing continuous variables centers the data, which reduces collinearity between main effects and their corresponding interaction terms. This procedure scales the coefficients so that each parameter estimate represents the expected change in the response variable, expressed in standard deviation units, for a one standard deviation increase in the predictor variable. Centering the data improves the efficiency of the sampling algorithm by creating a parameter space with a more isotropic geometry.

We established weakly informative priors for the model parameters to regularize the estimates and restrict the sampler to plausible regions of the parameter space. Regularizing priors prevent overfitting and reduce the influence of extreme observations. The population-level effects, which correspond to the beta coefficients in the linear predictor, received a normal prior distribution centered at zero with a standard deviation of 3.

$$
\beta \sim \mathcal{N}(0, 3)
$$

This normal prior allocates most of its probability mass between -9 and 9 standard deviations. Since the data are standardized, an effect size of 9 standard deviations is physiologically impossible. The prior exerts mild shrinkage toward zero without dominating the likelihood of the observed data.

The residual standard deviations for each response variable received a half-normal prior. Standard deviations cannot be negative, so the distribution is truncated at zero.

$$
\sigma \sim \mathcal{Half-N}(0, 3)
$$

The correlation matrix for the residuals received an LKJ prior. The Lewandowski-Kurowicka-Joe distribution defines a probability density over positive definite correlation matrices. We specified a shape parameter of 1 for the LKJ prior.

$$
\rho \sim \mathcal{LKJ}(1)
$$

An LKJ prior with a shape parameter of 1 provides a uniform prior over all valid correlation matrices. It expresses no initial preference regarding the strength or direction of the residual correlations among the heart rate variability parameters.

Model estimation was performed using the `brms` package in the R programming environment. The package translates the model syntax into Stan code, which compiles in C++ to perform Markov Chain Monte Carlo sampling. We utilized the No-U-Turn Sampler, an extension of Hamiltonian Monte Carlo. Hamiltonian Monte Carlo uses the gradient of the log-posterior to simulate the physical dynamics of a particle moving over a frictionless surface. This allows the sampler to take large steps through the parameter space and reduces the autocorrelation between successive samples.

We executed the sampling algorithm with four parallel chains to assess the stability of the posterior estimates. Each chain ran for 5000 iterations. We discarded the first 2500 iterations of each chain as warmup. During the warmup phase, the sampler adapts the step size and estimates the inverse mass matrix. Discarding these initial samples ensures that the retained samples come from the stationary distribution. The procedure generated a total of 10000 post-warmup samples for inference.

We modified the control parameters of the sampling algorithm to prevent divergent transitions. The `adapt_delta` parameter controls the target average acceptance probability during the warmup phase. We increased this value to 0.999. A higher `adapt_delta` forces the sampler to take smaller leapfrog steps during the Hamiltonian simulation. Smaller steps increase the precision of the numerical integration, allowing the sampler to navigate regions of high posterior curvature without diverging. We also increased the `max_treedepth` parameter to 50. The No-U-Turn Sampler builds a binary tree of states at each iteration. A maximum depth of 50 prevents the sampler from terminating trajectories prematurely, ensuring comprehensive exploration of complex posterior distributions.

Convergence of the Markov chains was evaluated using the potential scale reduction factor ($\hat{R}$) and the effective sample size. An $\hat{R}$ value near 1.00 indicates that the parallel chains have mixed and converge to the same distribution. The effective sample size estimates the number of independent draws equivalent to the autocorrelated samples produced by the algorithm.

Parameter credibility was assessed using the probability of direction (pd). The probability of direction calculates the proportion of the posterior distribution that has the same sign as the median estimate. It ranges from 0.5 to 1.0. A value of 0.5 indicates that the posterior is perfectly symmetric around zero. A value of 1.0 indicates that the entire posterior distribution lies on one side of zero. The results also report the probability of significance (ps) and the Bayes Factor (BF) as supplementary indices of effect reliability.
