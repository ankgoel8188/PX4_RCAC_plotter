clc
clear all
close all

LoadFigurePrintingProperties

cd ..\2021-05-03


All_ulg_files = dir('*.ulg');
figure(1)
set(gcf,'units','centimeters','outerposition',[0 0 50 28])
%%
for pp = 1:size(All_ulg_files,1)
    close all
    fname = All_ulg_files(pp).name;
    %     fname = fname(1:8)
    fname = fname(1:24)
    filename = fname;
    
    Data_position   = readmatrix([filename '_vehicle_local_position_0.csv'], 'NumHeaderLines',1);
    %     Data_setpoint   = readmatrix([filename '_vehicle_local_position_setpoint_0.csv'], 'NumHeaderLines',1);
    
    % Data_PV = readmatrix('RCAC_run_2_rcac_pos_vel_variables_0.csv', 'NumHeaderLines',1);
    % Data_AR = readmatrix('RCAC_run_2_rcac_att_rate_variables_0.csv', 'NumHeaderLines',1);
    % Data_position = readmatrix('RCAC_run_2_vehicle_local_position_0.csv', 'NumHeaderLines',1);
    % Data_setpoint = readmatrix('RCAC_run_2_vehicle_local_position_setpoint_0.csv', 'NumHeaderLines',1);
    %%
    
    
    time_position   = (Data_position(:,1)-Data_position(1,1))/1e6;
    Xpos            = Data_position(:,5:7);
    
    
    pp = mod(pp,10)
    if pp==0; pp=1; end
    pp = 1;
    subplot(2,2,1)
    plot(Xpos(:,2), Xpos(:,1),'color',co(pp,:));
    hold on; grid on; axis tight; axis equal
    %     title('QC Trajectory');
    plot(Xpos(1,2), Xpos(1,1),'k*', 'markersize',12);
    plot(Xpos(end,2), Xpos(end,1),'color',co(pp,:),'marker','*', 'markersize',12);
    %print(['traj_' fname],'-dpng')
    
    for ii = 1:3
        subplot(2,2,ii+1)
        QC_pos = plot(time_position, (-1)^(ii>2)*Xpos(:,ii),'color',co(pp,:));
        hold on; grid on; axis tight;
    end
    
    
    
    %%
    % close all
    
    
    
    % legend('PID', 'RCAC P_0 = 1', 'RCAC P_0 = 0.1')
    
    subplot(2,2,1); xlabel('$x$'); ylabel('$y$')
    subplot(2,2,2); xlabel('$t$'); ylabel('$x$')
    subplot(2,2,3); xlabel('$t$'); ylabel('$y$')
    subplot(2,2,4); xlabel('$t$'); ylabel('$z$')
    
    
    print([fname '_FW_position'],'-dpng')
    %%
    % close all
    
    RCAC_filename = [filename '_rcac_fw_roll_0.csv'];
    if isfile(RCAC_filename )
        
        figure
        Data_RCAC   = readmatrix(RCAC_filename, 'NumHeaderLines',1);
        
        time_RCAC = Data_RCAC(:,1)-Data_RCAC(1,1);
        time_RCAC = time_RCAC/1e6;
        theta   = Data_RCAC(:,2:4);
        z   = Data_RCAC(:,5);
        u   = Data_RCAC(:,6);
        Sw   = Data_RCAC(:,7);
        
        subplot(3,1,1)
        stairs(time_RCAC, z,'linewidth',2);
        grid on; axis tight
        ylabel('$z$')
        
        subplot(3,1,2)
        stairs(time_RCAC, u,'linewidth',2);
        grid on; axis tight
        ylabel('$u$')
        subplot(3,1,3)
        stairs(time_RCAC, theta(:,1),'linewidth',2);
        hold on; grid on; axis tight
        stairs(time_RCAC, theta(:,1)*0+1/.7,'linewidth',2);
        
        stairs(time_RCAC, Sw,'linewidth',2);
        aa = legend('$\theta$', 'PX4 gain', 'RCAC Switch');
        set(aa, 'box', 'off', 'interpreter', 'latex')
    end
    
    %%
    set(gcf,'units','centimeters','outerposition',[0 0 50 28])
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    print([fname '_RCAC_data'],'-dpng')
end
