daq.reset
clear, close all

s=daq.createSession('ni');
s.addAnalogInputChannel('Dev1',0,'Voltage');

s1 = daq.createSession('ni');
s1.addAnalogOutputChannel('Dev1',0,'Voltage');

s.NumberOfScans=1000;

Vrev=linspace(0.3,-2,150);

Vdet = [];
Vdeterr= [];
 
for Vrev=linspace(0.3,-2,150)
    
    outputSingleScan(s1,Vrev);
    [data,timestamps]=startForeground(s);
    
    Vdeterr=[Vdeterr, (std(data)./sqrt(1000))];
    
    Vdet = [Vdet, mean(data)];
    
    disp(Vrev);
end
 
Vrev=linspace(0.3,-2,150);
Vdr=sqrt(Vdet);

figure(1);
errorbar(Vrev,Vdr,Vdeterr);
xlabel('Reverse voltage');
ylabel('Root Detector voltage');

figure(2);
errorbar(Vrev,Vdet,Vdeterr)
xlabel('Reverse voltage');
ylabel('Detector voltage');

outputSingleScan(s1,0);