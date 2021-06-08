
Data_PV         = readmatrix([filename '_rcac_pos_vel_variables_0.csv'], 'NumHeaderLines',1);
Data_AR         = readmatrix([filename '_rcac_att_rate_variables_0.csv'], 'NumHeaderLines',1);
Data_position   = readmatrix([filename '_vehicle_local_position_0.csv'], 'NumHeaderLines',1);

file_sp = 0;
if isfile([filename '_vehicle_local_position_setpoint_0.csv'])
    Data_setpoint   = readmatrix([filename '_vehicle_local_position_setpoint_0.csv'], 'NumHeaderLines',1);
    time_setpoint   = (Data_setpoint(:,1)-Data_setpoint(1,1))/1e6;
    Xset            = Data_setpoint(:,2:4);
    Yawset          = Data_setpoint(:,5);
    file_sp         = 1;
    Xset            = Xset-Xset(1,:);
end
time_position   = (Data_position(:,1)-Data_position(1,1))/1e6;
Xpos            = Data_position(:,5:7);
Yaw             = Data_position(:,21);

Xpos            = Xpos-Xpos(1,:);


ii_pos = Data_PV(:,2);
ii_vel = Data_PV(:,3);
ii_att = Data_AR(:,2);
ii_rate = Data_AR(:,3);
ss_pv = find(ii_pos>0,1);
ss_ar = find(ii_att>0,1);
index_pv    = ss_pv:1:length(ii_pos);
index_pv    = 1:1:length(ii_pos);
%time_pv     = (Data_PV(index_pv,1)-Data_PV(ss_pv,1))/1e6;
time_pv     = (Data_PV(index_pv,1)-Data_PV(1,1))/1e6;
index_ar    = ss_ar:1:length(ii_att);
index_ar    = 1:1:length(ii_att);
time_ar     = (Data_AR(index_ar,1)-Data_PV(1,1))/1e6;
time_ar_px4     = (Data_AR(:,1)-Data_PV(1,1))/1e6;


z_pos       = Data_PV(index_pv,7:9);
u_pos       = Data_PV(index_pv,10:12);
theta_pos   = Data_PV(index_pv,13:15);

z_vel       = Data_PV(index_pv,17:19);
u_vel       = Data_PV(index_pv,20:22);
theta_vel   = Data_PV(index_pv,23:31);

RCAC_switch = Data_PV(:,5);

PX4_theta_pos = Data_PV(index_pv,32:34);
PX4_theta_vel = Data_PV(index_pv,35:40);

P11_Pos     = Data_PV(:,41);
P11_Velx    = Data_PV(:,42);

RCAC_switch_pos = Data_PV(:,43);
RCAC_switch_vel = Data_PV(:,44);

alpha_PID_pos = Data_PV(:,6);
alpha_PID_vel = Data_PV(:,16);



alpha_PID_att = Data_AR(:,4);
alpha_PID_rate = Data_AR(:,14);

z_att       = Data_AR(index_ar,5:7);
u_att       = Data_AR(index_ar,8:10);
theta_att   = Data_AR(index_ar,11:13);

z_rate      = Data_AR(index_ar,15:17);
u_rate      = Data_AR(index_ar,18:20);
theta_rate  = Data_AR(index_ar,21:32);


PX4_theta_att = Data_AR(:,33:35);
PX4_theta_rate = Data_AR(:,36:47);


time_PV_switch = (Data_PV(:,1)-Data_PV(1,1))/1e6;
time_AR_switch = (Data_AR(:,1)-Data_AR(1,1))/1e6;


RCAC_switch_att = Data_AR(:,50);
RCAC_switch_rate = Data_AR(:,51);
index_switch = 1:3:length(RCAC_switch_att);


P11_Att     = Data_AR(:,48);
P11_Rate    = Data_AR(:,49);


cost_z_pos = normVec_in_Mat(z_pos)/time_PV_switch(end);
cost_z_vel = normVec_in_Mat(z_vel)/time_PV_switch(end);
cost_z_att = normVec_in_Mat(z_att)/time_AR_switch(end);
cost_z_rat = normVec_in_Mat(z_rate)/time_AR_switch(end);


cost_z_pos = normVec_in_Mat(z_pos);
cost_z_vel = normVec_in_Mat(z_vel);
cost_z_att = normVec_in_Mat(z_att(:,3));
cost_z_rat = normVec_in_Mat(z_rate);

cost_z = [cost_z_pos cost_z_vel cost_z_att cost_z_rat ];

% normVec_in_Mat(z_pos)/time_PV_switch(end)
% (norm(z_pos(:,1)) + norm(z_pos(:,2)) + norm(z_pos(:,3)) )        /time_PV_switch(end)


Act_controls    = readmatrix([filename '_actuator_controls_0_0.csv'], 'NumHeaderLines',1);

% _actuators.control[0] = (PX4_ISFINITE(_att_control(0))) ? _att_control(0) : 0.0f;
% 	_actuators.control[1] = (PX4_ISFINITE(_att_control(1))) ? _att_control(1) : 0.0f;
% 	_actuators.control[2] = (PX4_ISFINITE(_att_control(2))) ? _att_control(2) : 0.0f;
% 	_actuators.control[3] = (PX4_ISFINITE(_thrust_sp)) ? _thrust_sp : 0.0f;

time_act    = (Act_controls(:,1)-Act_controls(1,1))/1e6;
Moments     = Act_controls(:,3:5);
thrust_sp   = Act_controls(:,6);

% PX4_theta_pos(end,:)
% PX4_theta_vel(end,:)
% PX4_theta_att(end,:)
% PX4_theta_rate(end,:)
