plot(time_switch,RCAC_ON, 'ro');
        hold on; grid on; axis tight
        plot(time_PV_switch,RCAC_switch_pos+.05,'^','linewidth',1)        
        plot(time_PV_switch,RCAC_switch_vel+.1,'v','linewidth',1)
        plot(time_AR_switch(index_switch),RCAC_switch_att(index_switch)+.15,'<','linewidth',1)
        plot(time_AR_switch(index_switch),RCAC_switch_rate(index_switch)+.2,'>','linewidth',1)
        
        aa = legend('RCAC switch','Pos','Vel','Att','Rate');
        set(aa, 'box', 'off', 'interpreter', 'latex', 'orientation', 'vertical','NumColumns',1,'location','best')
        ylim([-1 1.2])