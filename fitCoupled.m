
close all  %close any open windows

allFitParams = [];  %initialize matrix to hold fit parameters

% a = params(1);  %gamma_1   the fit function may be switching which peak
% is which so we need to determine which is sp from the energy
% b = params(2);  %gamma_2
% c = params(3);  %w_1
% d = params(4);  %w_2
% e = params(5);  %g
% f = params(6);  %intensity
% g = params(7);  %offset

for i=1:24
startParams = [0.15 0.07 1.92 1.877 0.1 3000 600];  %this sets stargint parameters for the variables
lb = [0.13 0.04 1.83 1.75 0.02 1 0];  %set a lower bound
ub = [0.25 0.25 1.95 1.85 0.25 9000 2000];  %set an upper bound

x_ev = crossingAxis(11:586);  %select points 11-586 to fit for x axis
Intensity_test = allData(11:586,i);  %combine data from "unnamed" spectra into one matrix, select points 11-586 to fit for y axis


fitParams = lsqcurvefit(@f, startParams, x_ev, Intensity_test,lb,ub); %this line does the fitting

allFitParams = [allFitParams; fitParams]; % create a variable to store fit params for each spectrum

yFit = f(fitParams, x_ev);
figure;
plot(x_ev, Intensity_test, 'b*');  %plot fit and data
hold on;
plot(x_ev, yFit, 'r');
legend('data','fit');
xlabel('Energy (eV)');
ylabel('Intensity (cts)');

end

detuningData = (allFitParams(:,4) - allFitParams(:,3)).*1000; % create detunings from fits, energy2-energy1

a = mean(allFitParams(:,1)).*1000;  %gamma_1 in mev
b = mean(allFitParams(:,2)).*1000;  %gamma_2 in mev
c = mean(allFitParams(:,3)).*1000;  %w_sp in mev 
g = mean(allFitParams(:,5)).*1000;  %Rabi frequency in mev

detuning = linspace(-150,150,200); %set the range of plotted detuning values and how many points to calculate here


     pks1 = real((detuning + 2*c)./2 - 1i.*(a+b)/4 + sqrt((g/2)^2 + 0.25.*(detuning-1i.*(b-a)/2).^2))./1000;  % paper defined g as coupling rate, our fitting finds Rabi freq which is 2*g
     pks2 = real((detuning + 2*c)./2 - 1i.*(a+b)/4 - sqrt((g/2)^2 + 0.25.*(detuning-1i.*(b-a)/2).^2))./1000;

     w_qd = c./1000 + detuning./1000;
     w_sp = c./1000 + detuning.*0;


figure
hold on;
plot(detuning,w_qd,':r');
plot(detuning,w_sp,'--b');
plot(detuning,pks1,'k');
plot(detuning,pks2,'k');
plot(detuningData,lorFitParams(:,4),'*', 'MarkerEdgeColor','g');
plot(detuningData,lorFitParams(:,3),'*', 'MarkerEdgeColor','g');
legend('QD','Plasmon','Normal modes');
set(findall(gca,'Type','Line'),'Linewidth',6)
set(gca,'FontSize',20)
ylabel('Energy (eV)','FontSize',24)
xlabel('Detuning (meV)','FontSize', 24)

% g = fitParams(5)
% delta = fitParams(3)-fitParams(4)
% w_sp = fitParams(4)
% w_qd = fitParams(3)
% gamma = fitParams(2)-fitParams(1) %cavity-QD

%haixu model
% g_0 = sqrt((g/2)^2 - (delta/2)^2 + (gamma/4)^2)

% paper model
% g_0 = sqrt((g)^2 - (delta/2)^2 + (gamma/2)^2)