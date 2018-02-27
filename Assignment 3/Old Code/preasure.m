function preasure
% this function calculates the preasure produced from the pump
V_max = 5;
V_input = ();
T = 0;
DeltaT = 0.5;
p_intial = 0;
while true
    p = ((V_input/V_max)-0.04)/0.008;
    p_total = p_intial + p;
    if T == 1
       p_per_second = p_total + p_per_second;
       Total_Time = Total_Time + T;
       T = 0;
    end
    T = T + DeltaT;
end
preasure = p_per_second/Total_Time;
end
        

