%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code written Alessandro N. Vargas
% Last update: June 20, 2024
% Motivation: experimental data collected from
% a plasma kit.
% E-mail: avargas@utfpr.edu.br
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear all, close all,

gain_probe_1 = 934.712121; % measured gain of the low-cost high-voltage 
                           % probe (see the published paper for details)

                           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% procedure to check the 'rise time' of MOSFET with 'step' command u(t)
% vontage-controlled current source (no Arduino)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

count=1;
for ps=1:32
    textoPequeno = sprintf("20240629-0001_%02d.mat",ps);
    nome{count} = sprintf('%s',textoPequeno);
    disp(nome{count})
    
    eval(sprintf("load %s",nome{count}));
    
    Ts = Tinterval;
    
    t = Ts*[1:max(size(A))];
    %
    vec_u = C;        % voltage command in u(t)  
    vec_x1 = A;       % high-voltage should be multiplied later by "gain_probe_1"
    vec_x1 = (gain_probe_1/1000)*vec_x1;  % voltage in kV
    
    vec_x2 = B; % high-voltage should be multiplied later by "gain_probe_1"
    vec_x2 = (gain_probe_1/1000)*vec_x2;  % voltage in kV
    
    vec_x3 =  D;   % voltage on the shunt resistor (R=50 Ohms)
        
    savefile = sprintf("data_uc_berkeley_plasma_%s",textoPequeno);
    save(savefile,'vec_x1','vec_x2','vec_x3','vec_u','t','Ts','-v7');
    
    count = count+1;
end


figure(1)
hold on
plot(t,vec_u,'LineWidth',2)
plot(t,vec_x3)
hold off
legend('u(t)','Voltage drop on shunt resistor')
title('data for control of current')
%axis([0 0.2002 0.4 1.5]),grid
