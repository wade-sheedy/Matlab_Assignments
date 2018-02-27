function flowrate
%this function calculates the flowrate produced from the pump
pulse_input = ();
pulse = 0;
T = 0;
DeltaT = 0.5;
while true
    pulse = pulse + pulse_input;
        if T == 1 
            Liters = (pulse * 3.03)/1000; % one pulse = aprox 3.03 ml of water therefore we can convert the count of pulses into milliliters and then convert into liters
            Total_Time = Total_Time + T;
            T = 0;
        end
   T = T + DeltaT;
end
flowrate = Liters/Total_Time;
end
