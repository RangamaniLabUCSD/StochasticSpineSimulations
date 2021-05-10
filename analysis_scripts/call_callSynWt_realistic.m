%This calls syn wt for the realistic geometry results
%Then save the table and tableSynWt for the real geometry results
clear
close all
clc

pathname = fileparts('resultsAutoPrint/');
AllcaReal = zeros(50,35001,6);
AllcaReal(:,:,1) = load('filopodial_realistic_spine17_free-Ca2.csv');
AllcaReal(:,:,2) = load('filopodial_realistic_spine37_free-Ca2.csv');
AllcaReal(:,:,3) = load('thin_realistic_spine39_free-Ca2.csv');
AllcaReal(:,:,4) = load('thin_realistic_spine41_free-Ca2.csv');
AllcaReal(:,:,5) = load('mushroom_realistic_spine13_free-Ca2.csv');
AllcaReal(:,:,6) = load('mushroom_realistic_spine18_free-Ca2.csv');


names = ["Filopodia Spine 17 ", "Filopodia Spine 37 ","Thin Spine 39 ", ...\
    "Thin Spine 41 ", "Mushroom Spine 13 ","Mushroom Spine 18 "];

nameSave = ["filoSpine17", "filoSpine37","thinSpine39", ...\
    "thinSpine41", "mushSpine13","mushSpine18"];

table = zeros(6,2);

tableSynWt = zeros(50,6);


for i = 1:6

    allresults = zeros(length(AllcaReal(1,:,1)),length(AllcaReal(:,1,1)));

    for n = 1:1:50
        [t,y] = callsynapticWts(AllcaReal(n,:,i));
        allresults(:,n) = y(:);
        tableSynWt(n,i) = y(end);
    end
    
    set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
    set(0,'defaultAxesFontSize', 28)
    set(findall(gca, 'Type', 'Line'),'LineWidth',2);
    plot(t,allresults)
    set(gcf,'pos',[0 0 1000 600])
    set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
    set(0,'defaultAxesFontSize', 28)
    set(findall(gca, 'Type', 'Line'),'LineWidth',2);
    title(sprintf('%s - Synaptic Weight', names(i))) 
    ylim([-1e-3 5e-3])
    ylabel('W (1)');
    xlabel('Time (s)');

    hold on

    meanAll = zeros(length(y),1);
    stdAll = zeros(length(y),1);
    for j = 1:length(y)
        meanAll(j) = mean(allresults(j,:));
        stdAll(j) = std(allresults(j,:));
    end

    table(i,:) = [meanAll(end); stdAll(end)];
    meanPlus = meanAll + stdAll;
    meanMinus = meanAll - stdAll;
    tspan = 0:1e-6:0.035;
    
    hold on;
    plot(tspan, meanAll, 'k', 'LineWidth', 2);

    stdshade(transpose(allresults),0.25,'b',transpose(tspan))
    set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
    set(0,'defaultAxesFontSize', 28)
    set(findall(gca, 'Type', 'Line'),'LineWidth',2);
%     pngfile = fullfile(pathname, sprintf('%s.png',nameSave(i)));
%     saveas(gcf, pngfile);
    hold off
    
    %%%%plot

end

x = 1:6;
bar(x,table(:,1))
hold on
err = errorbar(x,table(:,1),table(:,2),table(:,2));
err.Color = [0 0 0];                            
err.LineStyle = 'none';  
ylabel('W (1)');
xticks(1:1:6)
xticklabels(names)
xtickangle(90)
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);



