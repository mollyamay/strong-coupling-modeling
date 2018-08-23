close all

detuningData = (allFitParams(:,4) - allFitParams(:,3)).*1000; % create detunings from fits, energy2-energy1

a = allFitParams(:,1).*1000;  %gamma_1 in mev
b = allFitParams(:,2).*1000;  %gamma_2 in mev
c = allFitParams(:,3).*1000;  %w_sp in mev 
g = allFitParams(:,5).*1000;  %Rabi frequency in mev

detuning = linspace(-150,150,200); %set the range of plotted detuning values and how many points to calculate here



for i=1:24

     figure
     
     pks1 = real((detuning + 2*c(i))./2 - 1i.*(a(i)+b(i))/4 + sqrt((g(i)/2).^2 + 0.25.*(detuning-1i.*(b(i)-a(i))/2).^2))./1000;  % paper defined g as coupling rate, our fitting finds Rabi freq which is 2*g
     pks2 = real((detuning + 2*c(i))./2 - 1i.*(a(i)+b(i))/4 - sqrt((g(i)/2).^2 + 0.25.*(detuning-1i.*(b(i)-a(i))/2).^2))./1000;

     w_qd = c(i)./1000 + detuning./1000;
     w_sp = c(i)./1000 + detuning.*0;
     
     hold on

     plot(detuning,w_qd,':r');
     plot(detuning,w_sp,'--b');
     plot(detuning,pks1,'Color',[0,0,0]);
     plot(detuning,pks2,'Color',[0,0,0]);
     plot(detuningData(i),lorFitParams(i,4),'*', 'MarkerEdgeColor','g');
     plot(detuningData(i),lorFitParams(i,3),'*', 'MarkerEdgeColor','g');
     legend('QD','Plasmon','Normal modes');
     set(findall(gca,'Type','Line'),'Linewidth',5)
     set(gca,'FontSize',20)
     ylabel('Energy (eV)','FontSize',24)
     xlabel('Detuning (meV)','FontSize', 24)

end

figure

for i=1:24

     
     
     pks1 = real((detuning + 2*c(i))./2 - 1i.*(a(i)+b(i))/4 + sqrt((g(i)/2).^2 + 0.25.*(detuning-1i.*(b(i)-a(i))/2).^2))./1000;  % paper defined g as coupling rate, our fitting finds Rabi freq which is 2*g
     pks2 = real((detuning + 2*c(i))./2 - 1i.*(a(i)+b(i))/4 - sqrt((g(i)/2).^2 + 0.25.*(detuning-1i.*(b(i)-a(i))/2).^2))./1000;

     w_qd = c(i)./1000 + detuning./1000;
     w_sp = c(i)./1000 + detuning.*0;
     
     hold on

     p3 = plot(detuning,pks1,'k','Linewidth',5,'Color',[0.8*i/24,1*i/24,0.8*i/24]);
     plot(detuning,pks2,'k','Linewidth',5, 'Color',[0.8*i/24,1*i/24,0.8*i/24]);
     


end

for i=1:24

     plot(detuningData(i),lorFitParams(i,4),'*', 'MarkerEdgeColor',[0.8*i/24,1*i/24,0.8*i/24], 'Linewidth',6);
     plot(detuningData(i),lorFitParams(i,3),'*', 'MarkerEdgeColor',[0.8*i/24,1*i/24,0.8*i/24], 'Linewidth',6);
     
end
c = mean(allFitParams(:,3)).*1000;

w_qd = c./1000 + detuning./1000;
w_sp = c./1000 + detuning.*0;

p1 = plot(detuning,w_qd,':r', 'Linewidth',6);
p2 = plot(detuning,w_sp,'--b', 'Linewidth',6);

     
legend([p1 p2 p3],{'QD','Plasmon','Normal Modes'});
set(gca,'FontSize',20)
ylabel('Energy (eV)','FontSize',24)
xlabel('Detuning (meV)','FontSize', 24)