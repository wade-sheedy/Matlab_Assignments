function openfile()
% Variables
R_Data = [];            % raw data
P_Data = [];            % performance data

 [filename,pathname]= uigetfile('*.txt');
 file = [pathname filename];
FileID = fopen(file,'rt');
get_data();
        %Reads one line & calculates
        line = fgetl(FileID);
        line_data = sscanf(line,'%f V, %f counts, %i ms');
        
        % save raw data
        R_Data(end+1,1) = line_data(1);
        R_Data(end,2) = line_data(2);
        R_Data(end,3) = line_data(3);
                       
        % calculations preasure over time
        P_Data(end+1,1) = ((R_Data(end,1)/5)-0.04)/0.008; %pressure calculation as per pump specifications
                  
        %calculations flowrate over time
        P_Data(end,2) = (R_Data(end,2) * 3.03)/1000; % one pulse = aprox 3.03 ml of water therefore we can convert the count of 
                                                     %pulses into milliliters and then convert into liters
                
        %calculating Hydraulic power over flowrate
        P_Data(end,3)= (P_Data(end,2) * P_Data(end,1))/1000; %(flowrate * preasure)/1000
                
        %calculating the head over the flowrate
        rho = 1000; %kg per cubic meter of water
        g = 9.81;
        P_Data(end,4) = P_Data(end,1)/(rho*g); %preasure/(density * Gravity)
        
         end
end