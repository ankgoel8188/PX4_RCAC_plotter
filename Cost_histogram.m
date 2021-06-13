clc
clear all
close all
cd 'J:\Google Drive\000 Work\70 2019 May 10 MIT_Autopilot\PX4_Log_Files\'
addpath 'J:\Google Drive\000 Work\36 2015 Oct 23 2D scramjet\RCAC_onestep\RCAC_functions'
addpath 'J:\Google Drive\000 Work\36 2015 Oct 23 2D scramjet\RCAC_onestep'

LoadFigurePrintingProperties

set(0, 'DefaultFigureColor', 'default'); 
set(0, 'DefaultTextFontSize', 16); 
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultAxesFontSize', 16);

co = [0 0 1;
    1 0 0;
    0 1 0;
    0    0.4470    0.7410
    0.8500    0.3250    0.0980
    0.9290    0.6940    0.1250
    0.4940    0.1840    0.5560
    0.4660    0.6740    0.1880
    0.3010    0.7450    0.9330
    0.6350    0.0780    0.1840];

set(0,'defaultAxesColorOrder',co)

addpath '.'

% cd .\2020-09-22  % Folder containing the csv files
% cd .\2021-04-26  % Folder containing the csv files
% cd .\2021-04-28  % Folder containing the csv files
% cd ..\2021-04-29  % Folder containing the csv files
% cd ..\2021-04-30_Vel  
% cd ..\2021-04-30_Att  
% cd ..\2021-04-30_Mair
cd .\2021-05-03_AllRCAC_ONR

%%
close all
pp_array = [1   % a=1
            2   % a=1, RCAC
            3   % a=0.5 
            4   % a=0.5 RCAC
            13   % a=0.25
            12  % a=0.25 RCAC
            14  % a=0 RCAC
            ];
All_ulg_files = dir('*.ulg');
% figure(1)
% set(gcf,'units','centimeters','outerposition',[0 0 50 28])

cost_tab = [];

pp = 1;  col = 'b';  plot_pp;
pp = 2;  col = 'r';  plot_pp;
aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
% text(15,0,'$\alpha=1$')
print(['traj_' num2str(pp)],'-dpng')

figure
pp = 3;  col = 'b';  plot_pp;
pp = 4;  col = 'r';  plot_pp;
aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
print(['traj_' num2str(pp)],'-dpng')

figure
pp = 13;  col = 'b';  plot_pp;
pp = 12;  col = 'r';  plot_pp;
aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
print(['traj_' num2str(pp)],'-dpng')
figure
pp = 14;  col = 'r';  plot_pp;
    print(['traj_' num2str(pp)],'-dpng')
    
    

title('QC Trajectory');


%% onr report
cost_tab = [];
close all
subplot(2,2,1)
pp = 1;  col = 'b';  plot_pp;
pp = 2;  col = 'r';  plot_pp;
aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
xlabel({'$x$'; '(a) $\alpha=1$'})
% title('$\alpha = 1$')
% text(15,0,'$\alpha=1$')
% print(['traj_' num2str(pp)],'-dpng')

subplot(2,2,2)
pp = 3;  col = 'b';  plot_pp;
pp = 4;  col = 'r';  plot_pp;
% title('$\alpha = 0.5$')
xlabel({'$x$'; '(b) $\alpha=0.5$'})
% aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
% print(['traj_' num2str(pp)],'-dpng')

subplot(2,2,3)
pp = 13;  col = 'b';  plot_pp;
pp = 12;  col = 'r';  plot_pp;
% title('$\alpha = 0.25$')
xlabel({'$x$'; '(c) $\alpha=0.25$'})
% aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
print(['traj_' num2str(pp)],'-dpng')
subplot(2,2,4)
pp = 14;  col = 'r';  plot_pp;
xlabel({'$x$'; '(d) $\alpha=0$'})
% title('$\alpha = 0$')
%     print(['traj_' num2str(pp)],'-dpng')
%%
figure
subplot(2,2,1); bar(cost_tab(1:2,:)')
xlabel('$\alpha=1$')
xlabel({'$x$'; '(a) $\alpha=1$'})
subplot(2,2,2); bar(cost_tab(3:4,:)')
xlabel('$\alpha=0.5$')
xlabel({'$x$'; '(b) $\alpha=0.5$'})
subplot(2,2,3); bar(cost_tab(5:6,:)')
xlabel('$\alpha=0.25$')
xlabel({'$x$'; '(c) $\alpha=0.25$'})
subplot(2,2,4); bar(cost_tab([1 7],:)')
xlabel('$\alpha=0$')
xlabel({'$x$'; '(d) $\alpha=0$'})
names = {'Pos'; 'Vel'; 'Att'; 'Rate'};
for ii = 1:4
    subplot(2,2,ii)
    grid on
    ylabel('Cost')
    
set(gca,'xtick',[1:4],'xticklabel',names)
end


print('cost_barplot','-dpng')


%%
cd ..\2021-04-09  
close all
pp_array = [1   % a=1
            3   % a=1, RCAC
            10   % a=0.5 
            4   % a=0.5 RCAC
            ];
All_ulg_files = dir('*.ulg');
% figure(1)
% set(gcf,'units','centimeters','outerposition',[0 0 50 28])

cost_tab = [];

pp = 1;  col = 'b';  plot_pp;
pp = 3;  col = 'r';  plot_pp;
aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
% text(15,0,'$\alpha=1$')
print(['traj_' num2str(pp)],'-dpng')

figure
pp = 10;  col = 'b';  plot_pp;
pp = 4;  col = 'r';  plot_pp;
aa = legend('RCAC off', 'RCAC on'); set(aa, 'box','off');
print(['traj_' num2str(pp)],'-dpng')
%%
figure
subplot(2,2,1); bar(cost_tab(1:2,:)')
xlabel('$\alpha=1$')
subplot(2,2,2); bar(cost_tab(3:4,:)')
xlabel('$\alpha=0.5$')
subplot(2,2,3); bar(cost_tab(5:6,:)')
xlabel('$\alpha=0.25$')
subplot(2,2,4); bar(cost_tab([1 7],:)')
xlabel('$\alpha=0$')
names = {'Pos'; 'Vel'; 'Att'; 'Rate'};
for ii = 1:4
    subplot(2,2,ii)
    grid on
    ylabel('Cost')
    
set(gca,'xtick',[1:4],'xticklabel',names)
end


print('cost_barplot','-dpng')


%%
cd '..\2021-04-26 added mass HITL'
close all

figure
subplot(1,2,1); bar(cost_tab([4 3],:)')
xlabel('$m_{add}=0$ gm')
subplot(1,2,2); bar(cost_tab([1 2],:)')
xlabel('$m_{add}=200$ gm')
names = {'Pos'; 'Vel'; 'Att'; 'Rate'};
for ii = 1:2
    subplot(1,2,ii)
    grid on
    ylabel('Cost')
    ylim([0 28])
set(gca,'xtick',[1:4],'xticklabel',names)
end


print('cost_barplot','-dpng')


%%
cd '..\2021-04-30_Mair'
close all
pp_array = [2   % a=1
            3   % a=1, RCAC
            4   % m=200
            5   % m=200 RCAC
            8
            9
            ];
All_ulg_files = dir('*.ulg');        
cost_tab = []
for pp = pp_array'        
    col = 'b';
    plot_pp;
end
cost_tab
% text(15,0,'$\alpha=1$')
        
figure
subplot(1,3,1); bar(cost_tab([1 2],:)')
xlabel('$m_{add}=0$ gm')
subplot(1,3,2); bar(cost_tab([3 4],:)')
xlabel('$m_{add}=200$ gm')

subplot(1,3,3); bar(cost_tab([5 6],:)')
xlabel('$m_{add}=200$ gm')
names = {'Pos'; 'Vel'; 'Att'; 'Rate'};
for ii = 1:3
    subplot(1,3,ii)
    grid on
    ylabel('Cost')
    ylim([0 51])
set(gca,'xtick',[1:4],'xticklabel',names)
end


print('cost_barplot','-dpng')