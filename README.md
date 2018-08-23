# strong-coupling-modeling
fits spectra to lorentzian peaks and strong coupling model from Cui et al. Phys. Rev. A 73 (2006) and generates anticrossing plots

fitLorCrossing : fits data in the allData variable to two lorentzian peaks by calling lorFit.m

fitCoupled : fits data in allData to strong coupling model and uses average fit parameters to generate anticrossing curve and plasmon and emitter peak energy lines. Plots fitLorCrossing peak fits on this anticrossing line.

plot_all_anticrossings : uses parameters from model fitting to plot anticrossing curves and overlays the corresponding experimental peak energies from the lorentzian fitting program.
