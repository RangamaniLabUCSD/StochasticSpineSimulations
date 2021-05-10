%This plots syn wt against various geometric parameters for real and
%idealized spines when considering calcium as CONCENTRATION
clear
close all
clc

pathname = fileparts('resultsAutoPrint/');
Allca = load('ResultsFor400-100-10-10/Allca.mat');
Allca = Allca.Allca;

table = load('ResultsFor400-100-10-10/synWtsMeanSTDVSCONCENTRATION.mat');
table = table.table;

synWt = load('ResultsFor400-100-10-10/synWt-vsCon-idealReal.mat');
synWt = synWt.tableSynWt;


names = ["Mushroom small SA ", "Mushroom medium SA ","Mushroom large SA ", ...\
    "Thin large SA ", "Thin medium SA ","Thin small SA ", "Thin thin neck ", ...\
    "Thin thick neck ", "Mushroom thick neck ","Mushroom thin neck ", ...\
    "Mushroom x1.33 ","Mushroom x0.66 ","Mushroom control ","Thin x1.5 ",...\
    "Thin control ","Thin x2 ","Filopodia x0.75 ","Filopodia x0.5 ", "Filopodia control "];

nameSave = ["mushSmallSA", "mushMedSA","mushLargeSA", ...\
    "thinLargeSA", "thinMedSA","thinSmallSA", "thinThinNeck", ...\
    "thinThickNeck", "mushThickNeck","mushThinNeck", ...\
    "mushX133","mushX066","mushControl","thinX150",...\
    "thinControl","thinX200","filopodiaX075","filopodiaX050", "filopodiaControl"];

% 
% x = 1:19;
% bar(x,table(:,1))
% hold on
% err = errorbar(x,table(:,1),table(:,2),table(:,2));
% err.Color = [0 0 0];                            
% err.LineStyle = 'none';  
% ylabel('W (1)');
% xticks(1:1:19)
% xticklabels(names)
% xtickangle(90)
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);


%%%%%%%%%%%%%%%%%%%%%%%%Plot all syn wt vs volume
%geometries to plot
%j = [1 2 3 4 5 6 11 12 13 14 15 16 17 18 19];
% nameSave = ["1 mushSmallSA", "2 mushMedSA","3 mushLargeSA", ...\
%     "4 thinLargeSA", "5 thinMedSA","6 thinSmallSA", "7 thinThinNeck", ...\
%     "8 thinThickNeck", "9 mushThickNeck","10 mushThinNeck", ...\
%     "11 mushX133","12 mushX066","13 mushControl","14 thinX150",...\
%     "15 thinControl","16 thinX200","17 filopodiaX075","18 filopodiaX050", "19 filopodiaControl"];
%Here are all of the PSD in the order of nameSave
PSD = [0.232 0.232 0.232...\
    0.045 0.045 0.045 0.045...\
    0.045 0.232 0.232...\
    0.526 0.081 0.232 0.112...\
    0.045 0.241 0.064 0.031 0.127];
%Here are all of the SA
SA = [2.567 2.567 2.567...\
    0.611 0.611 0.611 0.653...\
    0.590 2.507 2.689...\
    4.568 1.140 2.567 1.378...\
    0.611 2.453 1.609 0.717 2.860];
%Here are all of the vols
vols = [0.255 0.235 0.203 ...\
    0.026 0.030 0.033 0.034...\
    0.035 0.272 0.270...\
    0.643 0.080 0.271 0.119...\
    0.035 0.283 0.058 0.017 0.138];

%Real volumes order of shape then numbering (filo, thin, mush)
volsReal = [0.0908 0.0750 0.0450 0.0911 0.1566 0.2430];
SAReal = [1.9164 1.7564 1.0782 1.7097 2.4568 3.3832];
PSDReal = [0.06 0.03 0.04 0.07 0.26 0.14];

VSAReal = volsReal./SAReal;
VPSDReal = volsReal./PSDReal;
PSDPMReal = PSDReal./SAReal;
% volsToSAReal = [0.0908/1.9164 0.0750/1.7564 0.0450/1.0782 0.0911/1.7097 0.1566/2.4568 0.2430/3.3832];
% PSDtoSAReal = [0.06/1.9164 0.03/1.7564 0.04/1.0782 0.07/1.7097 0.26/2.4568 0.14/3.3832];


%SynWt to fit [1-3 mush SA; 11-19 mush size, thin size, filo size]
synWtAll50 = [synWt(:,1:3) synWt(:,11:end)];
synWtAll1column = reshape(synWtAll50,1,[]);

%vols to fit
volsFit = [vols(1:3) vols(11:19) volsReal];
volsFit50 =volsFit.*ones(50,1);
volsFit1column = reshape(volsFit50,1,[]);
dlmV = fitlm(volsFit1column,synWtAll1column,'y~x1');%y~x1-1 for no intercept
sqedV = dlmV.Rsquared.Ordinary;
interceptV = dlmV.Coefficients.Estimate(1);
slopeV = dlmV.Coefficients.Estimate(2);

% % % %vols to SA to fit
% % % VSAFit = [vols(1:3)./SA(1:3) vols(11:19)./SA(11:19) volsReal./SAReal];
% % % VSAFit50 =VSAFit.*ones(50,1);
% % % VSAFit1column = reshape(VSAFit50,1,[]);
% % % dlmVSA = fitlm(VSAFit1column,synWtAll1column,'y~x1');%y~x1-1 for no intercept
% % % sqedVSA = dlmVSA.Rsquared.Ordinary;
% % % interceptVSA = dlmVSA.Coefficients.Estimate(1);
% % % slopeVSA = dlmVSA.Coefficients.Estimate(2);
% % % 
% % % 
% % % %vols to PSD to fit
% % % VPSDFit = [vols(1:3)./PSD(1:3) vols(11:19)./PSD(11:19) volsReal./PSDReal];
% % % VPSDFit50 =VPSDFit.*ones(50,1);
% % % VPSDFit1column = reshape(VPSDFit50,1,[]);
% % % dlmVPSD = fitlm(VPSDFit1column,synWtAll1column,'y~x1');%y~x1-1 for no intercept
% % % sqedVPSD = dlmVPSD.Rsquared.Ordinary;
% % % interceptVPSD = dlmVPSD.Coefficients.Estimate(1);
% % % slopeVPSD = dlmVPSD.Coefficients.Estimate(2);
% % % 
% % % %vols to PSD to fit
% % % PSDPMFit = [PSD(1:3)./SA(1:3) PSD(11:19)./SA(11:19) PSDReal./SAReal];
% % % PSDPMFit50 =PSDPMFit.*ones(50,1);
% % % PSDPMFit1column = reshape(PSDPMFit50,1,[]);
% % % dlmPSDPM = fitlm(PSDPMFit1column,synWtAll1column,'y~x1');%y~x1-1 for no intercept
% % % sqedPSDPM = dlmPSDPM.Rsquared.Ordinary;
% % % interceptPSDPM = dlmPSDPM.Coefficients.Estimate(1);
% % % slopePSDPM = dlmPSDPM.Coefficients.Estimate(2);
% % % 
% % % 

% % %%All different color!!!
%%%%Vs Vol TO CHANGE
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
%colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
hold on
j = [1 2 3 11 12 13 14 15 16 17 18 19];% 7 8 10 9];
colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]; [1 0 0]; [56/255 61/255 150/255]; [0 128/255 128/255]}; %pink, blue, cyan
markers = ['+', 'o','^'];
for i = 1:length(j)
    %thin - pink
    %filo - blue
    %mush - cyan
    %non SA - o
    %SA - x
    % large neck >
    if i == 1 || i == 2 || i ==3  % mush SA
        marker = markers(1);
        colori = 3;
    end
    if i == 4|| i ==5||i == 6 % mush sizes
        marker = markers(2);
        colori = 3;
    end
    if i == 7|| i ==8|| i ==9 % thin sizes
        marker = markers(2);
        colori = 1;
    end
    if i == 10|| i ==11|| i ==12 % filo sizes
        marker = markers(2);
        colori = 2;
    end
    err = errorbar(vols(j(i)),table(j(i),1),table(j(i),2),table(j(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
end
r = [1 2 3 4 5 6];
for i = 1:length(r)
    if i == 1||i == 2 % filo sizes real
        marker = markers(3);
        colori = 2+3;
    end
    if i == 3|| i ==4 % thin sizes real
        marker = markers(3);
        colori = 1+3;
    end
    if i == 5|| i ==6 % mush sizes real
        marker = markers(3);
        colori = 3+3;
    end
    err = errorbar(volsReal(i),table(r(i)+19,1),table(r(i)+19,2),table(r(i)+19,2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
end
err.LineStyle = 'none';  
set(gcf,'pos',[0 0 1000 600])

y = slopeV*volsFit + interceptV;
f1 = plot(volsFit, y,'-');
set(f1,'Color',[0 0.5 0]);
legend('hide')

ylabel('Synaptic Weight');
%xticks([0.035, 0.119, 0.283])
%xlabel('\mum^3')
xlabel('Volume (\mum^3)')

hold off
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'synWtVSCONCENTRATION-vsVols-wReal-diffColordiffReal-wFit.png');
saveas(gcf, pngfile);

% % % 
% % % %%%%%%%syn wt vs vol to SA
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % % hold on
% % % j = [1 2 3 11 12 13 14 15 16 17 18 19];% 7 8 10 9];
% % % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]; [1 0 0]; [56/255 61/255 150/255]; [0 128/255 128/255]}; %pink, blue, cyan
% % % markers = ['+', 'o','^'];
% % % for i = 1:length(j)
% % %     %thin - pink
% % %     %filo - blue
% % %     %mush - cyan
% % %     %non SA - o
% % %     %SA - x
% % %     % large neck >
% % %     if i == 1 || i == 2 || i ==3  % mush SA
% % %         marker = markers(1);
% % %         colori = 3;
% % %     end
% % %     if i == 4|| i ==5||i == 6 % mush sizes
% % %         marker = markers(2);
% % %         colori = 3;
% % %     end
% % %     if i == 7|| i ==8|| i ==9 % thin sizes
% % %         marker = markers(2);
% % %         colori = 1;
% % %     end
% % %     if i == 10|| i ==11|| i ==12 % filo sizes
% % %         marker = markers(2);
% % %         colori = 2;
% % %     end
% % %     err = errorbar(VSAFit(i),table(j(i),1),table(j(i),2),table(j(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % % end
% % % r = [1 2 3 4 5 6];
% % % for i = 1:length(r)
% % %     if i == 1||i == 2 % filo sizes real
% % %         marker = markers(3);
% % %         colori = 2+3;
% % %     end
% % %     if i == 3|| i ==4 % thin sizes real
% % %         marker = markers(3);
% % %         colori = 1+3;
% % %     end
% % %     if i == 5|| i ==6 % mush sizes real
% % %         marker = markers(3);
% % %         colori = 3+3;
% % %     end
% % %     err = errorbar(VSAReal(i),tableReal(r(i),1),tableReal(r(i),2),tableReal(r(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % % end
% % % err.LineStyle = 'none';  
% % % set(gcf,'pos',[0 0 1000 600])
% % % 
% % % y = slopeVSA*VSAFit + interceptVSA;
% % % f1 = plot(VSAFit, y,'-');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % % 
% % % ylabel('Synaptic Weight');
% % % %xticks([0.035, 0.119, 0.283])
% % % %xlabel('\mum^3')
% % % xlabel('Volume to Surface Area (\mum)')
% % % 
% % % hold off
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % pngfile = fullfile(pathname, 'synWt-vsVolsToSA-wReal-diffColordiffReal-wFit.png');
% % % saveas(gcf, pngfile);
% % % 
% % % 
% % % %%%%%%%syn wt vs vol to PSD
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % % hold on
% % % j = [1 2 3 11 12 13 14 15 16 17 18 19];% 7 8 10 9];
% % % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]; [1 0 0]; [56/255 61/255 150/255]; [0 128/255 128/255]}; %pink, blue, cyan
% % % markers = ['+', 'o','^'];
% % % for i = 1:length(j)
% % %     %thin - pink
% % %     %filo - blue
% % %     %mush - cyan
% % %     %non SA - o
% % %     %SA - x
% % %     % large neck >
% % %     if i == 1 || i == 2 || i ==3  % mush SA
% % %         marker = markers(1);
% % %         colori = 3;
% % %     end
% % %     if i == 4|| i ==5||i == 6 % mush sizes
% % %         marker = markers(2);
% % %         colori = 3;
% % %     end
% % %     if i == 7|| i ==8|| i ==9 % thin sizes
% % %         marker = markers(2);
% % %         colori = 1;
% % %     end
% % %     if i == 10|| i ==11|| i ==12 % filo sizes
% % %         marker = markers(2);
% % %         colori = 2;
% % %     end
% % %     err = errorbar(VPSDFit(i),table(j(i),1),table(j(i),2),table(j(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % % end
% % % r = [1 2 3 4 5 6];
% % % for i = 1:length(r)
% % %     if i == 1||i == 2 % filo sizes real
% % %         marker = markers(3);
% % %         colori = 2+3;
% % %     end
% % %     if i == 3|| i ==4 % thin sizes real
% % %         marker = markers(3);
% % %         colori = 1+3;
% % %     end
% % %     if i == 5|| i ==6 % mush sizes real
% % %         marker = markers(3);
% % %         colori = 3+3;
% % %     end
% % %     err = errorbar(VPSDReal(i),tableReal(r(i),1),tableReal(r(i),2),tableReal(r(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % % end
% % % err.LineStyle = 'none';  
% % % set(gcf,'pos',[0 0 1000 600])
% % % 
% % % y = slopeVPSD*VPSDFit + interceptVPSD;
% % % f1 = plot(VPSDFit, y,'-');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % % 
% % % ylabel('Synaptic Weight');
% % % %xticks([0.035, 0.119, 0.283])
% % % %xlabel('\mum^3')
% % % xlabel('Volume to PSD Area (\mum)')
% % % 
% % % hold off
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % pngfile = fullfile(pathname, 'synWt-vsVolsToPSD-wReal-diffColordiffReal-wFit.png');
% % % saveas(gcf, pngfile);
% % % 
% % % %%%%%%%syn wt vs PSD to PM
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % % hold on
% % % j = [1 2 3 11 12 13 14 15 16 17 18 19];% 7 8 10 9];
% % % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]; [1 0 0]; [56/255 61/255 150/255]; [0 128/255 128/255]}; %pink, blue, cyan
% % % markers = ['+', 'o','^'];
% % % for i = 1:length(j)
% % %     %thin - pink
% % %     %filo - blue
% % %     %mush - cyan
% % %     %non SA - o
% % %     %SA - x
% % %     % large neck >
% % %     if i == 1 || i == 2 || i ==3  % mush SA
% % %         marker = markers(1);
% % %         colori = 3;
% % %     end
% % %     if i == 4|| i ==5||i == 6 % mush sizes
% % %         marker = markers(2);
% % %         colori = 3;
% % %     end
% % %     if i == 7|| i ==8|| i ==9 % thin sizes
% % %         marker = markers(2);
% % %         colori = 1;
% % %     end
% % %     if i == 10|| i ==11|| i ==12 % filo sizes
% % %         marker = markers(2);
% % %         colori = 2;
% % %     end
% % %     err = errorbar(PSDPMFit(i),table(j(i),1),table(j(i),2),table(j(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % % end
% % % r = [1 2 3 4 5 6];
% % % for i = 1:length(r)
% % %     if i == 1||i == 2 % filo sizes real
% % %         marker = markers(3);
% % %         colori = 2+3;
% % %     end
% % %     if i == 3|| i ==4 % thin sizes real
% % %         marker = markers(3);
% % %         colori = 1+3;
% % %     end
% % %     if i == 5|| i ==6 % mush sizes real
% % %         marker = markers(3);
% % %         colori = 3+3;
% % %     end
% % %     err = errorbar(PSDPMReal(i),tableReal(r(i),1),tableReal(r(i),2),tableReal(r(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % % end
% % % err.LineStyle = 'none';  
% % % set(gcf,'pos',[0 0 1000 600])
% % % 
% % % y = slopePSDPM*PSDPMFit + interceptPSDPM;
% % % f1 = plot(PSDPMFit, y,'-');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % % 
% % % ylabel('Synaptic Weight');
% % % %xticks([0.035, 0.119, 0.283])
% % % %xlabel('\mum^3')
% % % xlabel('PSD Area to PM Area')
% % % 
% % % hold off
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % pngfile = fullfile(pathname, 'synWt-vsPSDToPM-wReal-diffColordiffReal-wFit.png');
% % % saveas(gcf, pngfile);
