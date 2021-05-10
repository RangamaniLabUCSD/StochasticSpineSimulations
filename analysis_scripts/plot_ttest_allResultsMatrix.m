%Do ttest2 between all peak calcium results, decay results, syn wt results as matrix
clear
close all
clc

% nameSave = ["1 mushSmallSA", "2 mushMedSA","3 mushLargeSA", ...\
%     "4 thinLargeSA", "5 thinMedSA","6 thinSmallSA", "7 thinThinNeck", ...\
%     "8 thinThickNeck", "9 mushThickNeck","10 mushThinNeck", ...\
%     "11 mushX133","12 mushX066","13 mushControl","14 thinX150",...\
%     "15 thinControl","16 thinX200","17 filopodiaX075","18 filopodiaX050", "19 filopodiaControl"];

names = ["Mushroom small SA ", "Mushroom medium SA ","Mushroom large SA ", ...\
    "Thin large SA ", "Thin medium SA ","Thin small SA ", "Thin thin neck ", ...\
    "Thin thick neck ", "Mushroom thick neck ","Mushroom thin neck ", ...\
    "Mushroom x1.33 ","Mushroom x0.66 ","Mushroom control ","Thin x1.5 ",...\
    "Thin control ","Thin x2 ","Filopodia x0.75 ","Filopodia x0.5 ", "Filopodia control ", ...\
    "Filopodia Spine 17 ", "Filopodia Spine 37 ","Thin Spine 39 ", ...\
    "Thin Spine 41 ", "Mushroom Spine 13 ","Mushroom Spine 18 "];


pathname = fileparts('resultsAutoPrint/');
peakReal = load('ResultsFor400-100-10-10/AllPeaksRealAll50And6.mat');
decayReal = load('ResultsFor400-100-10-10/AllDecayRealAll50And6.mat');
allresultsMaxReal = peakReal.allresultsMax;
AllDecayCoReal = decayReal.AllDecayCo;

peak = load('ResultsFor400-100-10-10/AllPeaksAll50And19.mat');
decay = load('ResultsFor400-100-10-10/AllDecayAll50And19.mat');
allresultsMax = peak.allresultsMax;
AllDecayCo = decay.AllDecayCo;

synWt = load('ResultsFor400-100-10-10/synWtAll50and25-IdealReal.mat');
synWt = synWt.tableSynWt;

% synWt = load('ResultsFor400-100-10-10/synWtAll50and19.mat');
% synWt = synWt.tableSynWt;
% 
% synWtReal = load('ResultsFor400-100-10-10/synWtRealAll50and6.mat');
% synWtReal = synWtReal.tableSynWt;


allMax = [allresultsMax allresultsMaxReal];
allDecay = [AllDecayCo AllDecayCoReal];
allSynWt = synWt;

%19 idealized; 6 real; 25 total
ttestMax = zeros(25,25,2); %will be h and p
ttestDecay = zeros(25,25,2); %will be h and p
ttestSynWt = zeros(25,25,2); %will be h and p

%floored max p
maxP = zeros(25,25);
maxD = zeros(25,25);
maxS = zeros(25,25);

%h tells if significant or not; p gives p value where 0.05 is cut off; so
%>0.05 is not significant 

for i = 1:25
    for j = 1:25
        [hM,pM] = ttest2(allMax(:,i), allMax(:,j));
        [hD,pD] = ttest2(allDecay(:,i), allDecay(:,j));
        [hS,pS] = ttest2(allSynWt(:,i), allSynWt(:,j));
        ttestMax(i,j,:) = [hM, pM]; %will be h and p
        maxP(i,j) = round(pM*100)/100;%sprintf('%.4f',pM);
        ttestDecay(i,j,:) = [hD,pD]; %will be h and p
        maxD(i,j) = round(pD*100)/100;%sprintf('%.4f',pM);
        ttestSynWt(i,j,:) = [hS,pS]; %will be h and p
        maxS(i,j) = round(pS*100)/100;%sprintf('%.4f',pM);
        
    end
end

set(findall(gca,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
h = heatmap(names, names, ttestMax(:,:,1));
set(gcf,'pos',[0 0 1000 1000])
colorbar('hide')
axp = struct(h);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
h.Title = 'H value for Max Peaks';
h.FontSize = 16;
set(findall(h,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'maxH-heapmap.png');
saveas(gcf, pngfile);


%test = sprintf('%.4f',ttestMax(:,:,2));
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
h = heatmap(names, names,maxP(:,:));
set(gcf,'pos',[0 0 1000 1000])
%h = heatmap(names, names,ttestMax(:,:,2));
axp = struct(h);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
h.Title = 'P value for Max Peaks';
h.FontSize = 16;
set(findall(h,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'maxP-heapmap.png');
saveas(gcf, pngfile);

%%%%%Decay
set(findall(gca,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
h = heatmap(names, names, ttestDecay(:,:,1));
set(gcf,'pos',[0 0 1000 1000])
colorbar('hide')
axp = struct(h);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
h.Title = 'H value for Decay Time Constants';
h.FontSize = 16;
set(findall(h,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'decayH-heapmap.png');
saveas(gcf, pngfile);


%test = sprintf('%.4f',ttestMax(:,:,2));
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
h = heatmap(names, names,maxD(:,:));
set(gcf,'pos',[0 0 1000 1000])
%h = heatmap(names, names,ttestMax(:,:,2));
axp = struct(h);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
h.Title = 'P value for Decay Time Constants';
h.FontSize = 16;
set(findall(h,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'decayP-heapmap.png');
saveas(gcf, pngfile);


%%%%%Syn Wt
set(findall(gca,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
h = heatmap(names, names, ttestSynWt(:,:,1));
set(gcf,'pos',[0 0 1000 1000])
colorbar('hide')
axp = struct(h);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
h.Title = 'H value for Synaptic Weight';
h.FontSize = 16;
set(findall(h,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'synWtH-heapmap.png');
saveas(gcf, pngfile);


%test = sprintf('%.4f',ttestMax(:,:,2));
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
h = heatmap(names, names,maxS(:,:));
set(gcf,'pos',[0 0 1000 1000])
%h = heatmap(names, names,ttestMax(:,:,2));
axp = struct(h);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
h.Title = 'P value for Synaptic Weight';
h.FontSize = 16;
set(findall(h,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
pngfile = fullfile(pathname, 'synWtP-heapmap.png');
saveas(gcf, pngfile);