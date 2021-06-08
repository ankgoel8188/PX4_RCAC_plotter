PID_factor = Data_PV(:,4);
        RCAC_ON = Data_PV(:,5);

        RCAC_ON(RCAC_ON<0)=0;
        time_switch = (1:length(PID_factor))/10;
%         plot(time_switch,PID_factor, 'b*');

        

%         plot(time_switch,alpha_PID_pos+.05,'^','linewidth',1,'markersize',2)
%         plot(time_switch,alpha_PID_vel+.1,'v','linewidth',1,'markersize',2)
%         plot(time_switch,alpha_PID_att+.15,'<','linewidth',1,'markersize',2)
%         plot(time_switch,alpha_PID_rate+.2,'>','linewidth',1,'markersize',2)
        nl = 5;
        plot(time_switch(1:nl:end),alpha_PID_pos(1:nl:end),'^','linewidth',1)
        hold on; grid on; axis tight
        plot(time_switch(3:nl:end),alpha_PID_vel(3:nl:end),'v','linewidth',1)
        plot(time_AR_switch(1:nl:end),alpha_PID_att(1:nl:end),'<','linewidth',1)
        plot(time_AR_switch(3:nl:end),alpha_PID_rate(3:nl:end),'>','linewidth',1)
        
        aa = legend('Pos','Vel','Att','Rate');
        set(aa, 'box', 'off', 'interpreter', 'latex', 'orientation', 'vertical','NumColumns',1,'location','best')
        ylim([-1 1.6])
        ylim([0 1])