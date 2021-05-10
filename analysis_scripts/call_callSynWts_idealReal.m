%This calls syn wt update for real and idealized
clear
close all
clc

pathname = fileparts('resultsAutoPrint/');
Allca = load('ResultsFor400-100-10-10/Allca.mat');
Allca = Allca.Allca;


% table = load('synWtsMeanSTD.mat');
% table = table.table;

% Allca(:,:,1) = load('mushroom_sa_small_free-Ca2.csv');
% Allca(:,:,2) = load('mushroom_sa_medium_free-Ca2.csv');
% Allca(:,:,3) = load('mushroom_sa_big_free-Ca2.csv');
% Allca(:,:,4) = load('thin_sa_big_free-Ca2.csv');
% Allca(:,:,5) = load('thin_sa_medium_free-Ca2.csv');
% Allca(:,:,6) = load('thin_sa_small_free-Ca2.csv');
% Allca(:,:,7) = load('thin_neck_thin_free-Ca2.csv');
% Allca(:,:,8) = load('thin_neck_thick_free-Ca2.csv');
% Allca(:,:,9) = load('mushroom_neck_thick_free-Ca2.csv');
% Allca(:,:,10) = load('mushroom_neck_thin_free-Ca2.csv');
% Allca(:,:,11) = load('mushroom_size_x1-33_free-Ca2.csv');
% Allca(:,:,12) = load('mushroom_size_x-66_free-Ca2.csv');
% Allca(:,:,13) = load('mushroom_control_free-Ca2.csv');
% Allca(:,:,14) = load('thin_size_x1.5_free-Ca2.csv');
% Allca(:,:,15) = load('thin_control_free-Ca2.csv');
% Allca(:,:,16) = load('thin_size_x2_free-Ca2.csv');
% Allca(:,:,17) = load('filopodial_size_x-75_free-Ca2.csv');
% Allca(:,:,18) = load('filopodial_size_x-5_free-Ca2.csv');
% Allca(:,:,19) = load('filopodial_control_free-Ca2.csv');

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

table = zeros(19+6,2);

tableSynWt = zeros(50,19+6);
Avo = 6.022e23;
molum3touM = 1e15*1e6;

for i = 1:19

    allresults = zeros(length(Allca(1,:,1)),length(Allca(:,1,1)));

    for n = 1:1:50
        [t,y] = callsynapticWts(Allca(n,:,i));
        allresults(:,n) = y(:);
        tableSynWt(n,i) = y(end);
    end
    

%     plot(t,allresults)
%     set(gcf,'pos',[0 0 1000 600])
%     set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
%     set(0,'defaultAxesFontSize', 28)
%     set(findall(gca, 'Type', 'Line'),'LineWidth',2);
%     title(sprintf('%s - Synaptic Weight', names(i))) 
%     %ylim([-1e-3 5e-3])
%     ylabel('W (1)');
%     xlabel('Time (s)');
% 
%     hold on

    meanAll = zeros(length(y),1);
    stdAll = zeros(length(y),1);
    for j = 1:length(y)
        meanAll(j) = mean(allresults(j,:));
        stdAll(j) = std(allresults(j,:));
    end

    table(i,:) = [meanAll(end); stdAll(end)];
%     meanPlus = meanAll + stdAll;
%     meanMinus = meanAll - stdAll;
    tspan = 0:1e-6:0.035;
    
%     hold on;
%     plot(tspan, meanAll, 'k', 'LineWidth', 2);
% 
%     stdshade(transpose(allresults),0.25,'b',transpose(tspan))
%     set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
%     set(0,'defaultAxesFontSize', 28)
%     set(findall(gca, 'Type', 'Line'),'LineWidth',2);
%     pngfile = fullfile(pathname, sprintf('%s-con.png',nameSave(i)));
%     saveas(gcf, pngfile);
%     hold off
    
    %%%%%plot

end



AllcaReal = zeros(50,35001,6);
AllcaReal(:,:,1) = load('filopodial_realistic_spine17_free-Ca2.csv');
AllcaReal(:,:,2) = load('filopodial_realistic_spine37_free-Ca2.csv');
AllcaReal(:,:,3) = load('thin_realistic_spine39_free-Ca2.csv');
AllcaReal(:,:,4) = load('thin_realistic_spine41_free-Ca2.csv');
AllcaReal(:,:,5) = load('mushroom_realistic_spine13_free-Ca2.csv');
AllcaReal(:,:,6) = load('mushroom_realistic_spine18_free-Ca2.csv');


namesReal = ["Filopodia Spine 17 ", "Filopodia Spine 37 ","Thin Spine 39 ", ...\
    "Thin Spine 41 ", "Mushroom Spine 13 ","Mushroom Spine 18 "];

nameSaveReal = ["filoSpine17", "filoSpine37","thinSpine39", ...\
    "thinSpine41", "mushSpine13","mushSpine18"];




for i = 1:6

    allresults = zeros(length(AllcaReal(1,:,1)),length(AllcaReal(:,1,1)));

    for n = 1:1:50
        [t,y] = callsynapticWts(AllcaReal(n,:,i));
        allresults(:,n) = y(:);
        tableSynWt(n,(i+19)) = y(end);
    end
    
%     set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
%     set(0,'defaultAxesFontSize', 28)
%     set(findall(gca, 'Type', 'Line'),'LineWidth',2);
%     plot(t,allresults)
%     set(gcf,'pos',[0 0 1000 600])
%     set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
%     set(0,'defaultAxesFontSize', 28)
%     set(findall(gca, 'Type', 'Line'),'LineWidth',2);
%     title(sprintf('%s - Synaptic Weight', namesReal(i))) 
%     ylim([-1e-3 5e-3])
%     ylabel('W (1)');
%     xlabel('Time (s)');
% 
%     hold on

    meanAll = zeros(length(y),1);
    stdAll = zeros(length(y),1);
    for j = 1:length(y)
        meanAll(j) = mean(allresults(j,:));
        stdAll(j) = std(allresults(j,:));
    end

    table((i+19),:) = [meanAll(end); stdAll(end)];
    meanPlus = meanAll + stdAll;
    meanMinus = meanAll - stdAll;
    tspan = 0:1e-6:0.035;
    
%     hold on;
%     plot(tspan, meanAll, 'k', 'LineWidth', 2);
% 
%     stdshade(transpose(allresults),0.25,'b',transpose(tspan))
%     set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
%     set(0,'defaultAxesFontSize', 28)
%     set(findall(gca, 'Type', 'Line'),'LineWidth',2);
%     pngfile = fullfile(pathname, sprintf('%s-Con.png',nameSaveReal(i)));
%     saveas(gcf, pngfile);
%     hold off
    
    %%%%plot

end

x = 1:(6+19);
bar(x,table(:,1))
hold on
err = errorbar(x,table(:,1),table(:,2),table(:,2));
err.Color = [0 0 0];                            
err.LineStyle = 'none';  
ylabel('W (1)');
xticks(1:1:(6+19))
xticklabels([names namesReal])
xtickangle(90)
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);


