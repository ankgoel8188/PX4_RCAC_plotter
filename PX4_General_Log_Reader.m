clear;
close all;
clc;
% Uncomment the for loop if you want to plot multiple log files at the same
% time

% LoadFigurePrintingProperties
% files = dir('*.ulg');
% for file = files'
%     file.name;
%     ulog1 = ulogreader(file.name);

ulog1 = ulogreader('log_40_2023-5-25-12-28-14.ulg');

% Position / Velocity
pos1 = readTopicMsgs(ulog1,'TopicNames','vehicle_local_position').TopicMessages{1,1}; 
pos_t1 = seconds(pos1.timestamp_sample-pos1.timestamp_sample(1));
pos_vel_sp1 = readTopicMsgs(ulog1,'TopicNames','vehicle_local_position_setpoint').TopicMessages{1,1};
pos_sp_t1 = seconds(pos_vel_sp1.timestamp-pos_vel_sp1.timestamp(1));

% Attitude
att_sp1 = readTopicMsgs(ulog1,'TopicNames','vehicle_attitude_setpoint').TopicMessages{1,1};
att_sp_t1 = seconds(att_sp1.timestamp-att_sp1.timestamp(1));
att1 = readTopicMsgs(ulog1,'TopicNames','vehicle_attitude').TopicMessages{1,1};
att_eul1 = quat2eul(att1.q,'ZYX');
att_t1 = seconds(att1.timestamp-att1.timestamp(1));

% Attitude Rate
rate_sp1 = readTopicMsgs(ulog1,'TopicNames','vehicle_rates_setpoint').TopicMessages{1,1};
rate_sp_t1 = seconds(rate_sp1.timestamp-rate_sp1.timestamp(1));
rate1 = readTopicMsgs(ulog1,'TopicNames','vehicle_angular_velocity').TopicMessages{1,1};
rate_t1 = seconds(rate1.timestamp-rate1.timestamp(1));

%% 2D trajectory flight simulation
figure
hold on
plot(pos1.y,pos1.x,'k')
axis tight
grid on
xlabel('x (m)')
ylabel('y (m)')

%% 3D trajectory flight simulation
figure
hold on
plot3(pos1.x,pos1.y,-pos1.z,'linewidth',2)
grid on
xlabel('North (m)')
ylabel('East (m)')
zlabel('Altitude (m)')
axis equal
axis tight
view(-39.3,31.73)
title('3D trajectory')
% print(gcf,'-depsc', 'Figures_eps/alpha0p3/IROS23_3D_trajectory_alpha0p3')
% print(gcf,'-dpng',  'Figures_img/alpha0p3/IROS23_3D_trajectory_alpha0p3')

%% Position Tracking
figure
plot(pos_sp_t1,pos_vel_sp1.x,'k--',pos_t1,pos1.x,'b','linewidth',2)

grid
title('X position tracking')
legend('x_{ref}','x','Location','best')
xlabel('time(s)')
ylabel('x')


figure
plot(pos_sp_t1,pos_vel_sp1.y,'k--',pos_t1,pos1.y,'b','linewidth',2)
grid
title('Y position tracking')
legend('y_{ref}','y','Location','best')
xlabel('time(s)')
ylabel('y')


figure
plot(pos_sp_t1,pos_vel_sp1.z,'k--',pos_t1,pos1.z,'b','linewidth',2)
grid
title('Z position tracking')
legend('z_{ref}','z','Location','best') 
xlabel('time(s)')
ylabel('z')


%% Velocity Tracking
figure
plot(pos_t1,pos1.vx,pos_sp_t1,pos_vel_sp1.vx,'k--','linewidth',2)
grid
title('V_{x} tracking')
xlabel('time(s)')
legend('Vx_{ref}','Vx','Location','best') 


figure
plot(pos_t1,pos1.vy,pos_sp_t1,pos_vel_sp1.vy,'k--','linewidth',2)
grid
title('V_{y} Tracking')
xlabel('time(s)')
legend('Vy_{ref}','Vy','Location','best') 


figure
plot(pos_t1,pos1.vz,pos_sp_t1,pos_vel_sp1.vz,'k--','linewidth',2)
grid
title('V_{z} Tracking')
xlabel('time(s)')
legend('Vz_{ref}','Vz','Location','best') 

%% Attitude Tracking
figure
plot(att_t1,att_eul1(:,3),att_sp_t1,att_sp1.roll_body,'k--','linewidth',2)
grid
title('Roll Attitude Tracking')
xlabel('time(s)')
legend('Roll_{ref}','Roll','Location','best') 


figure
plot(att_t1,att_eul1(:,2),att_sp_t1,att_sp1.pitch_body,'k--','linewidth',2)
grid
title('Pitch Attitude Tracking')
xlabel('time(s)')
legend('Pitch_{ref}','Pitch','Location','best') 


figure
plot(att_t1,att_eul1(:,1),att_sp_t1,att_sp1.yaw_body,'k--','linewidth',2)
grid
title('Yaw Attitude Tracking')
xlabel('time(s)')
legend('Yaw_{ref}','Yaw','Location','best') 


%% Rate Tracking
figure
plot(rate_t1,rate1.xyz(:,1),rate_sp_t1,rate_sp1.roll,'k--','linewidth',2)
grid
title('Roll Rate Tracking')
xlabel('time(s)')

figure
plot(rate_t1,rate1.xyz(:,2),rate_sp_t1,rate_sp1.pitch,'k--','linewidth',2)
grid
title('Pitch Rate Tracking')
xlabel('time(s)')

figure
plot(rate_t1,rate1.xyz(:,3),rate_sp_t1,rate_sp1.yaw,'k--','linewidth',2)
grid
title('Yaw Rate Tracking')
xlabel('time(s)')

% end







