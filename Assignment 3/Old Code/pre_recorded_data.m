function pre_recorded_data
A = csvread('Pump turn on.txt');
p = preasure(A,1); % read Document A column 1 
% now we need to write to document B colum 2
f = flowrate(A,2) % read flowrate from document column 2
% now we need to write to column 3 document B
h = head(B,2) % Read colum 2 aka preasure from document B
% Write h to column 4 document B
Hyd = Hydraulic(B,3) % read column 3 aka flowrate from document B
% write Hyd to column 5 of document B
B(,1) = 0 + 1 % write each time as 1 second in column 1 of document B
end
