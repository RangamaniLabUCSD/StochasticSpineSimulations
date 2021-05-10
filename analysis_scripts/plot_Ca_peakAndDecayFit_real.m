%This finds the peak ion number for each run and returns the mean and
%standard error for realistic spines
clear
close all
clc

pathname = fileparts('resultsAutoPrint/');
AllcaReal = load('ResultsFor400-100-10-10/AllcaReal.mat');
AllcaReal = AllcaReal.AllcaReal;
% % Allreal = load('ResultsFor400-100-10-10/AllPeakAndDecaysReal.mat');
% % peakReal = load('ResultsFor400-100-10-10/AllPeaksRealAll50And6.mat');
% % decayReal = load('ResultsFor400-100-10-10/AllDecayRealAll50And6.mat');
% % tableReal = Allreal.table;
% % allresultsMaxReal = peakReal.allresultsMax;
% % AllDecayCoReal = decayReal.AllDecayCo;
% % 
% % All = load('ResultsFor400-100-10-10/AllPeakAndDecays.mat');
% % peak = load('ResultsFor400-100-10-10/AllPeaksAll50And19.mat');
% % decay = load('ResultsFor400-100-10-10/AllDecayAll50And19.mat');
% % table = All.table;
% % allresultsMax = peak.allresultsMax;
% % AllDecayCo = decay.AllDecayCo;

names = ["Filopodia Spine 17 ", "Filopodia Spine 37 ","Thin Spine 39 ", ...\
    "Thin Spine 41 ", "Mushroom Spine 13 ","Mushroom Spine 18 "];

nameSave = ["filoSpine17", "filoSpine37","thinSpine39", ...\
    "thinSpine41", "mushSpine13","mushSpine18"];


%geometries to plot
%j = [1 2 3 4 5 6 11 12 13 14 15 16 17 18 19];
% nameSave = ["1 mushSmallSA", "2 mushMedSA","3 mushLargeSA", ...\
%     "4 thinLargeSA", "5 thinMedSA","6 thinSmallSA", "7 thinThinNeck", ...\
%     "8 thinThickNeck", "9 mushThickNeck","10 mushThinNeck", ...\
%     "11 mushX133","12 mushX066","13 mushControl","14 thinX150",...\
%     "15 thinControl","16 thinX200","17 filopodiaX075","18 filopodiaX050", "19 filopodiaControl"];

% % vols = [0.255 0.235 0.203 0.026 0.03 0.033 0.643 0.08 0.271 0.119 0.035 0.283 0.058 0.017 0.138];
% % volsToSA = [0.255/2.567 0.235/2.567 0.203/2.567 0.026/0.611 0.03/0.611 0.033/0.611 0.643/4.568 0.08/1.14 0.271/2.567 0.119/1.378 0.035/0.611 0.283/2.453 0.058/1.609 0.017/0.717 0.138/2.86];
% % 
% % volsReal = [0.0908 0.0750 0.0450 0.0911 0.1566 0.2430];
% % volsToSAReal = [0.0908/1.9164 0.0750/1.7564 0.0450/1.0782 0.0911/1.7097 0.1566/2.4568 0.2430/3.3832];
% % 
% % 
% % figure
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % hold on
% % j = [1 2 3 4 5 6 11 12 13 14 15 16 17 18 19];
% % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]}; %pink, blue, cyan
% % markers = ['+', 'o','^'];
% % for i = 1:length(j)
% %     %thin - pink
% %     %filo - blue
% %     %mush - cyan
% %     %non SA - o
% %     %SA - x
% %     if i == 1 || i == 2 || i ==3  % mush SA
% %         marker = markers(1);
% %         colori = 3;
% %     end
% %     if i == 4|| i ==5||i == 6 % thin SA
% %         marker = markers(1);
% %         colori = 1;
% %     end
% %     if i == 7|| i ==8|| i ==9 % mush sizes
% %         marker = markers(2);
% %         colori = 3;
% %     end
% %     if i == 10|| i ==11|| i ==12 % thin sizes
% %         marker = markers(2);
% %         colori = 1;
% %     end
% %     if i == 13||i == 14|| i ==15 % filo sizes
% %         marker = markers(2);
% %         colori = 2;
% %     end
% %     err = errorbar(vols(i),table(j(i),1),table(j(i),2),table(j(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % r = [1 2 3 4 5 6];
% % for i = 1:length(r)
% %     if i == 1||i == 2 % filo sizes real
% %         marker = markers(3);
% %         colori = 2;
% %     end
% %     if i == 3|| i ==4 % thin sizes real
% %         marker = markers(3);
% %         colori = 1;
% %     end
% %     if i == 5|| i ==6 % mush sizes real
% %         marker = markers(3);
% %         colori = 3;
% %     end
% %     err = errorbar(volsReal(i),tableReal(r(i),1),tableReal(r(i),2),tableReal(r(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % err.LineStyle = 'none';  
% % set(gcf,'pos',[0 0 1000 600])
% % % f1 = plot(fpeak,'--');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % ylabel('Max Ca^{2+} peak (ions)');
% % xlabel('\mum^3')
% % 
% % hold off
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % pngfile = fullfile(pathname, 'PeakCa-allVols-wReal.png');
% % saveas(gcf, pngfile);
% % 
% % 
% % 
% % %%%%peaks vs vol to sa
% % figure
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % hold on
% % j = [1 2 3 4 5 6 11 12 13 14 15 16 17 18 19];
% % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]}; %pink, blue, cyan
% % markers = ['+', 'o','^'];
% % for i = 1:length(j)
% %     %thin - pink
% %     %filo - blue
% %     %mush - cyan
% %     %non SA - o
% %     %SA - x
% %     if i == 1 || i == 2 || i ==3  % mush SA
% %         marker = markers(1);
% %         colori = 3;
% %     end
% %     if i == 4|| i ==5||i == 6 % thin SA
% %         marker = markers(1);
% %         colori = 1;
% %     end
% %     if i == 7|| i ==8|| i ==9 % mush sizes
% %         marker = markers(2);
% %         colori = 3;
% %     end
% %     if i == 10|| i ==11|| i ==12 % thin sizes
% %         marker = markers(2);
% %         colori = 1;
% %     end
% %     if i == 13||i == 14|| i ==15 % filo sizes
% %         marker = markers(2);
% %         colori = 2;
% %     end
% %     err = errorbar(volsToSA(i),table(j(i),1),table(j(i),2),table(j(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % r = [1 2 3 4 5 6];
% % for i = 1:length(r)
% %     if i == 1||i == 2 % filo sizes real
% %         marker = markers(3);
% %         colori = 2;
% %     end
% %     if i == 3|| i ==4 % thin sizes real
% %         marker = markers(3);
% %         colori = 1;
% %     end
% %     if i == 5|| i ==6 % mush sizes real
% %         marker = markers(3);
% %         colori = 3;
% %     end
% %     err = errorbar(volsToSAReal(i),tableReal(r(i),1),tableReal(r(i),2),tableReal(r(i),2), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % err.LineStyle = 'none';  
% % set(gcf,'pos',[0 0 1000 600])
% % % f1 = plot(fpeak,'--');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % ylabel('Max Ca^{2+} peak (ions)');
% % %xticks([0.035, 0.119, 0.283])
% % %xlabel('\mum^3')
% % xlabel('Volume to Surface Area (\mum)')
% % 
% % hold off
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % pngfile = fullfile(pathname, 'PeakCa-allVolsToSA-wReal.png');
% % saveas(gcf, pngfile);
% % 
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%Decay dynamics plots
% % figure
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % hold on
% % j = [1 2 3 4 5 6 11 12 13 14 15 16 17 18 19];
% % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]}; %pink, blue, cyan
% % markers = ['+', 'o','^'];
% % for i = 1:length(j)
% %     %thin - pink
% %     %filo - blue
% %     %mush - cyan
% %     %non SA - o
% %     %SA - x
% %     if i == 1 || i == 2 || i ==3  % mush SA
% %         marker = markers(1);
% %         colori = 3;
% %     end
% %     if i == 4|| i ==5||i == 6 % thin SA
% %         marker = markers(1);
% %         colori = 1;
% %     end
% %     if i == 7|| i ==8|| i ==9 % mush sizes
% %         marker = markers(2);
% %         colori = 3;
% %     end
% %     if i == 10|| i ==11|| i ==12 % thin sizes
% %         marker = markers(2);
% %         colori = 1;
% %     end
% %     if i == 13||i == 14|| i ==15 % filo sizes
% %         marker = markers(2);
% %         colori = 2;
% %     end
% %     err = errorbar(vols(i),-table(j(i),3),table(j(i),4),table(j(i),4), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % r = [1 2 3 4 5 6];
% % for i = 1:length(r)
% %     if i == 1||i == 2 % filo sizes real
% %         marker = markers(3);
% %         colori = 2;
% %     end
% %     if i == 3|| i ==4 % thin sizes real
% %         marker = markers(3);
% %         colori = 1;
% %     end
% %     if i == 5|| i ==6 % mush sizes real
% %         marker = markers(3);
% %         colori = 3;
% %     end
% %     err = errorbar(volsReal(i),-tableReal(r(i),3),tableReal(r(i),4),tableReal(r(i),4), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % err.LineStyle = 'none';  
% % set(gcf,'pos',[0 0 1000 600])
% % % f1 = plot(fpeak,'--');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % ylabel('Decay Time Constant (1/s)');
% % xlabel('\mum^3')
% % 
% % hold off
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % pngfile = fullfile(pathname, 'DecayCon-allVols-wReal.png');
% % saveas(gcf, pngfile);
% % 
% % 
% % 
% % %%%%peaks vs vol to sa
% % figure
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % %colorspec = {[1 0 0.75]; [0 0 1]; [0 1 0.85]};
% % hold on
% % j = [1 2 3 4 5 6 11 12 13 14 15 16 17 18 19];
% % colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]}; %pink, blue, cyan
% % markers = ['+', 'o','^'];
% % for i = 1:length(j)
% %     %thin - pink
% %     %filo - blue
% %     %mush - cyan
% %     %non SA - o
% %     %SA - x
% %     if i == 1 || i == 2 || i ==3  % mush SA
% %         marker = markers(1);
% %         colori = 3;
% %     end
% %     if i == 4|| i ==5||i == 6 % thin SA
% %         marker = markers(1);
% %         colori = 1;
% %     end
% %     if i == 7|| i ==8|| i ==9 % mush sizes
% %         marker = markers(2);
% %         colori = 3;
% %     end
% %     if i == 10|| i ==11|| i ==12 % thin sizes
% %         marker = markers(2);
% %         colori = 1;
% %     end
% %     if i == 13||i == 14|| i ==15 % filo sizes
% %         marker = markers(2);
% %         colori = 2;
% %     end
% %     err = errorbar(volsToSA(i),-table(j(i),3),table(j(i),4),table(j(i),4), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % r = [1 2 3 4 5 6];
% % for i = 1:length(r)
% %     if i == 1||i == 2 % filo sizes real
% %         marker = markers(3);
% %         colori = 2;
% %     end
% %     if i == 3|| i ==4 % thin sizes real
% %         marker = markers(3);
% %         colori = 1;
% %     end
% %     if i == 5|| i ==6 % mush sizes real
% %         marker = markers(3);
% %         colori = 3;
% %     end
% %     err = errorbar(volsToSAReal(i),-tableReal(r(i),3),tableReal(r(i),4),tableReal(r(i),4), marker, 'MarkerSize', 12, 'LineWidth', 4, 'MarkerFaceColor',colors{colori}, 'Color' , colors{colori});
% % end
% % err.LineStyle = 'none';  
% % set(gcf,'pos',[0 0 1000 600])
% % % f1 = plot(fpeak,'--');
% % % set(f1,'Color',[0 0.5 0]);
% % % legend('hide')
% % ylabel('Decay Time Constant (1/s)');
% % %xticks([0.035, 0.119, 0.283])
% % %xlabel('\mum^3')
% % xlabel('Volume to Surface Area (\mum)')
% % 
% % hold off
% % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 28)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % pngfile = fullfile(pathname, 'DecayCon-allVolsToSA-wReal.png');
% % saveas(gcf, pngfile);
% % 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table = zeros(6,4); %table of mean and std of Max, and mean and std of decay fit
allresultsMax = zeros(50,6);
AllDecayCo = zeros(50,6);
tspan = 0:1e-6:0.035; 

for i = 1:6

    
    for n = 1:1:50
        [maxVal, indexOfMax] = max(AllcaReal(n,:,i));
        allresultsMax(n,i) = maxVal;
        x = length(tspan(indexOfMax:end));
        %f = fit(tspan(indexOfMax:end)',Allca(n,indexOfMax:end,i)','exp1');
        %unshifted
        %shifted
        f = fit(tspan(1:x)',AllcaReal(n,indexOfMax:end,i)','exp1');
        AllDecayCo(n,i) = f.b;
    end
    
    %get mean and std of each
    meanAllMax = mean(allresultsMax(:,i));
    stdAllMax = std(allresultsMax(:,i));
    meanAllDecay = mean(AllDecayCo(:,i));
    stdAllDecay = std(AllDecayCo(:,i));
        
    %put it in a table
    table(i,:) = [meanAllMax; stdAllMax; meanAllDecay; stdAllDecay];
    
end


