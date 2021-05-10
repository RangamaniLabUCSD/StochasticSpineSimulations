%This finds the peak ion number and decay for each run and returns the mean and
%standard error for only the idealized simulations
clear
close all
clc

pathname = fileparts('resultsAutoPrint/');
All = load('ResultsFor400-100-10-10/Allca.mat');
Allca = All.Allca;

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

table = zeros(19,4); %table of mean and std of Max, and mean and std of decay fit
allresultsMax = zeros(50,19);
AllDecayCo = zeros(50,19);
tspan = 0:1e-6:0.035; 
for i = 1:19

    
    for n = 1:1:50
        [maxVal, indexOfMax] = max(Allca(n,:,i));
        allresultsMax(n,i) = maxVal;
        x = length(tspan(indexOfMax:end));
        %f = fit(tspan(indexOfMax:end)',Allca(n,indexOfMax:end,i)','exp1');
        %unshifted
        %shifted
        f = fit(tspan(1:x)',Allca(n,indexOfMax:end,i)','exp1');
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

% nameSave = ["mushSmallSA", "mushMedSA","mushLargeSA", ...\
%     "thinLargeSA", "thinMedSA","thinSmallSA", "thinThinNeck", ...\
%     "thinThickNeck", "mushThickNeck","mushThinNeck", ...\
%     "mushX133","mushX066","mushControl","thinX150",...\
%     "thinControl","thinX200","filopodiaX075","filopodiaX050", "filopodiaControl"];
%testing Max stat sig for whichever cases
case1 = 18;
case2 = 17;
case3 = 19;
[h12,p12] = ttest2(allresultsMax(:,case1), allresultsMax(:,case2));
[h23,p23] = ttest2(allresultsMax(:,case2), allresultsMax(:,case3));
[h31,p31] = ttest2(allresultsMax(:,case3), allresultsMax(:,case1));


[h12d,p12d] = ttest2(AllDecayCo(:,case1), AllDecayCo(:,case2));
[h23d,p23d] = ttest2(AllDecayCo(:,case2), AllDecayCo(:,case3));
[h31d,p31d] = ttest2(AllDecayCo(:,case3), AllDecayCo(:,case1));
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% x = 1:19;
% bar(x,table(:,1))
% hold on
% err = errorbar(x,table(:,1),table(:,2)/sqrt(50),table(:,2)/sqrt(50));
% err.Color = [0 0 0];                            
% err.LineStyle = 'none';  
% ylabel('Max calcium peak (ions)');
% xticks(1:1:19)
% xticklabels(names)
% xtickangle(90)
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% x = 1:19;
% bar(x,table(:,3))
% hold on
% err = errorbar(x,table(:,3),table(:,4)/sqrt(50),table(:,4)/sqrt(50));
% err.Color = [0 0 0];                            
% err.LineStyle = 'none';  
% ylabel('Decay coefficient (1/s)');
% xticks(1:1:19)
% xticklabels(names)
% xtickangle(90)
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% 


