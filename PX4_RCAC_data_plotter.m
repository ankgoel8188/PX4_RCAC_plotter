clc
clear all
close all
% cd 'J:\Google Drive\000 Work\70 2019 May 10 MIT_Autopilot\PX4_Log_Files\'
% addpath 'J:\Google Drive\000 Work\36 2015 Oct 23 2D scramjet\RCAC_onestep\RCAC_functions'
% addpath 'J:\Google Drive\000 Work\36 2015 Oct 23 2D scramjet\RCAC_onestep'
addpath '.\functions'
LoadFigurePrintingProperties

% cd .\2021-05-19_SITL_Rate_P0
%%


All_ulg_files = dir('*.ulg');
figure(1)
set(gcf,'units','centimeters','outerposition',[0 0 50 28])

for pp = 1:size(All_ulg_files,1)
    close all
    fname = All_ulg_files(pp).name;
    fname = fname(1:8)
    
    filelist{pp,1} = fname;
    filename = fname;
    
    Read_ulog_data_alphas;
    
    subplot(4,4,1)
    if file_sp
        QC_pos = plot(Xset(:,2), Xset(:,1),'r--');
        hold on; grid on; axis tight; axis equal
    end
    QC_pos = plot(Xpos(:,2), Xpos(:,1),'b');
    title('QC Trajectory');
    %print(['traj_' fname],'-dpng')
    
    subplot(4,4,2)
    for ii = 1:3
        if file_sp
            plot(time_setpoint, Xset(:,ii),'--','color',co(ii,:));
        end
        hold on; grid on; axis tight;
        plot(time_position, Xpos(:,ii),'color',co(ii,:));
    end
    
    subplot(4,4,3)
    plot_PID_alphas
    
    subplot(4,4,4)
    plot_RCAC_switches
    
    
    
    if sum(Data_PV(:,31)) || 1
        
       
        subplot(4,4,4)
     
        
        subplot(4,4,5); Pos_z = plot(time_pv, z_pos);
        aa = legend('$z_1$', '$z_2$', '$z_3$');
        set(aa, 'box', 'off', 'interpreter', 'latex', 'orientation', 'vertical','location','best')
        subplot(4,4,9); Pos_u = plot(time_pv, u_pos);
        aa = legend('$u_1$', '$u_2$', '$u_3$');
        set(aa, 'box', 'off', 'interpreter', 'latex', 'orientation', 'vertical','location','best')
        subplot(4,4,13); Pos_theta = plot(time_pv, theta_pos);
        aa = legend('$p_1$', '$p_2$', '$p_3$');
        set(aa, 'box', 'off', 'interpreter', 'latex', 'orientation', 'vertical','location','best')
        hold on; plot(time_pv, PX4_theta_pos,'--','handlevisibility','off');
        title(Data_PV(1,41))
        
        subplot(4,4,6); Vel_z = plot(time_pv, z_vel);
        subplot(4,4,10); Vel_u = plot(time_pv, u_vel);
        subplot(4,4,14); Vel_theta = plot(time_pv, theta_vel(:,[1 2 4 5 7 8]));
        aa = legend('$p_1$', '$i_1$', '$p_2$', '$i_2$', '$p_3$', '$i_3$');
        set(aa, 'box', 'off', 'interpreter', 'latex', 'orientation', 'vertical','NumColumns',2,'location','best')
        hold on; plot(time_pv, PX4_theta_vel,'k--','handlevisibility','off');
        title(Data_PV(1,42))
        % figure
        % plot(time_pv, RCAC_switch )
        
        subplot(4,4,7); Att_z = plot(time_ar, z_att);
        subplot(4,4,11); Att_u = plot(time_ar, u_att);
        subplot(4,4,15); Att_theta = plot(time_ar, theta_att);
        hold on; plot(time_ar_px4, PX4_theta_att,'--','handlevisibility','off');
        kk_ind = find(Data_AR(:,46)>0,1)
        title(Data_AR(kk_ind ,46))
        filelist{pp,2} = Data_AR(kk_ind ,48);
        title(Data_AR(1,48))
        
        subplot(4,4,8); Rate_z = plot(time_ar, z_rate);
        subplot(4,4,12); Rate_u = plot(time_ar, u_rate);
        subplot(4,4,16); Rate_theta = plot(time_ar, theta_rate);
        hold on; plot(time_ar_px4, PX4_theta_rate,'--','handlevisibility','off');
        title(Data_AR(kk_ind ,47))
        filelist{pp,3} = Data_AR(kk_ind ,49);
        title(Data_AR(1,49))
        
        subplot(4,4,5); title('Position Controller')
        subplot(4,4,6); title('Velocity Controller')
        subplot(4,4,7); title('Attitude Controller')
        subplot(4,4,8); title('Rate Controller')
        
        subplot(4,4,2); title('Position')
        subplot(4,4,3); title('Yaw')
        
        
        
        
        
        for pp = 5:16
            subplot(4,4,pp)
            axis tight; grid on;
            if pp<13
                set(gca,'XTickLabel', [])
            end
        end
        subplot(4,4,5); ylabel('$z$')
        subplot(4,4,9); ylabel('$u$')
        subplot(4,4,13); ylabel('$\theta$')
        for qq = 1:4
            subplot(4,4,qq+4)
            xlabel(cost_z(qq))            
        end

        
        
    else
        
        time_pv     = (Data_PV(:,1)-Data_PV(1,1))/1e6;
        time_ar     = (Data_AR(:,1)-Data_PV(1,1))/1e6;
        
        z_pos       = Data_PV(:,6:8);
        z_vel       = Data_PV(:,15:17);
        z_att       = Data_AR(:,4:6);
        z_rate      = Data_AR(:,13:15);
        subplot(4,4,5); Pos_z = plot(time_pv, z_pos);
        subplot(4,4,6); Vel_z = plot(time_pv, z_vel);
        subplot(4,4,7); Att_z = plot(time_ar, z_att);
        subplot(4,4,8); Rate_z = plot(time_ar, z_rate);
        for pp = 5:8
            subplot(4,4,pp)
            axis tight; grid on;
        end
        subplot(4,4,5); ylabel('$z$')
        
        
        
    end
    
    
        set(gcf,'units','centimeters','outerposition',[0 0 50 28])
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    print([fname '_RCAC_data'],'-dpng')
    
    
    
   
    
    figure
    subplot(2,1,1)
        plot_PID_alphas
    subplot(2,1,2)    
        plot_RCAC_switches
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    print(['PID_fcator_RCAC_switch_' fname],'-dpng')
end
%%







