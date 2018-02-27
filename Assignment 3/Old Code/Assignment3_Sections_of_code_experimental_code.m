%this section has unused experimental code that is being worked on 
%but has not yet been implemented into the program.

%Measuring Preasure
V_out = input('enter number: '); 
Vs = 5;
p = ((V_out/Vs) - 0.04)/0.008;

%Measuring a flowrate
seconds = 0;
DeltaT = 0.5;
pulse_input = input('enter value here: ');
liters = 0;
pulse = 0;
while DeltaT < 1
pulse = pulse + pulse_input;
if DeltaT == 1
    seconds = seconds + 1;
end
    if pulse < 330
       pulse = pulse + 1;
    elseif pulse == 330
        liters = liters + 1;
        pulse = 0;
        DeltaT = 0.1;
    end
    DeltaT = DeltaT + 0.1;
end 
flowrate = liters / seconds;

% Reading a usb input with a try catch statement
fileID1 = fopen('all');
try s = serial('com1');
    fgetl(s)
    fileID1 = fscanf(s);
    fclose(s);
end

%Attempted Catch satement for the USB connection if not in that port will
%swtch to another then another until one is found that i am connected to.
%catch s ~= serial('com1');
 %   s = serial('com2');
  %  fgetl(s);
   % fprintf(s, 'idn?');
    %idn = fscan(s);
   %fclose(s);
    %end
    
%opening a text file

fileId2 = fopen('all');
tline = fgetl(fileID2);
sscanf(tline);

%Calculating the Head 

% we have 1000kg of water per cubic meter
rho = 1000;
g = 9.81;

head = ppreasure/(rho*g);

%Hydraulic power
 Hydraulic_power = (flowrate*rho*g*head)/1000;


