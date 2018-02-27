Data = serial('COM5', 'Baudrate', 9600);
fopen(Data);


function [R_Data,P_Data]= pump_calc(Data)

%Variables
R_Data = [] ; %Raw Data
P_Data = []; %Calculated Pump Data

line = fgetl(Data);

while ischar(line)
   
    line_data = sscanf(line,'%f V, %f counts, %i ms');
    
    R_Data(end+1,1) = line_data(1);
    R_Data(end,2) = line_data(2);
    R_Data(end,3) = line_data(3);
    
    % calculations preasure over time
        P_Data(end+1,1) = ((R_Data(end,1)/5)-0.04)/0.008; %pressure calculation as per pump specifications
                  
        %calculations flowrate over time
        P_Data(end,2) = (R_Data(end,2) * 3.03)/1000; % one pulse = aprox 3.03 ml of water therefore we can convert the count of 
                                                     %pulses into milliliters and then convert into liters
                
        %calculating Hydraulic power over flowrate
        P_Data(end,3)= (R_Data(end,2) * P_Data(end,1))/1000; %(flowrate * preasure)/1000
                
        %calculating the head over the flowrate
        rho = 1000; %kg per cubic meter of water
        g = 9.81;
        P_Data(end,4) = P_Data(end,1)/(rho*g); %preasure/(density * Gravity)
        
        disp(P_Data(end));
    
    
    
end


% PvT = plot(Sorted_Data(1),Raw_Data(3));
% FvT = plot(Sorted_Data(2),Raw_Data(3));
% HvF = plot(Sorted_Data(4),Sorted_Data(2));
% HYDvF = plot(Sorted_Data(3),Sorted_Data(2));

end
