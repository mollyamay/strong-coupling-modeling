
close all

lorFitParams = [];  %initialize matrix to hold fit parameters

% a = params(1);  %gamma_qd
% b = params(2);  %gamma_sp
% c = params(3);  %w_qd
% d = params(4);  %w_sp
% e = params(5);  %intensity qd
% f = params(6);  %intensity sp
% g = params(7);  %offset

for i=1:24
    
startParams = [0.07 0.07 1.92 1.877 20 20 600];  %this sets stargint parameters for the variables
lb = [0.03 0.04 1.740 1.735 1 1 0];  %set a lower bound
ub = [0.2 0.5 2.1 1.8 9000 9000 2000];  %set an upper bound

x_ev = crossingAxis(11:586);  %select points 11-586 to fit for x axis
Intensity_test = allData(11:586,i);  %combine data from "unnamed" spectra into one matrix, select points 11-586 to fit for y axis


fitParams = lsqcurvefit(@lorFit, startParams, x_ev, Intensity_test,lb,ub); %this line does the fitting

lorFitParams = [lorFitParams; fitParams]; % create a variable to store fit params for each spectrum

yFit = lorFit(fitParams, x_ev);
figure;
plot(x_ev, Intensity_test, 'b*');  %plot fit and data
hold on;
plot(x_ev, yFit, 'r');
legend('data','fit');
xlabel('Energy (eV)');
ylabel('Intensity (cts)');

end