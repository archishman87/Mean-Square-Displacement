function [MSD_final,Tau_final] = MSD(sortedfile,timefile)
tf = xlsread(timefile);
r = xlsread(sortedfile);
format long
x = r(:,1);
y = r(:,2);
time = tf(:,1);
TraceID = r(:,8);
UTraceID = unique(TraceID);
MSD_final = [];
MSDs = [];
Xs = [];
Ys = [];
finalXs = [];
finalYs = [];
Tau = [];
Tau_final = [];
j = 1;
for i = 1:length(UTraceID)
    while ((j < (length(TraceID)+1)) && (TraceID(j)==UTraceID(i)))
        Xs = [Xs;x(j)];
        Ys = [Ys;y(j)];
        j = j+1;
    end
    delta_Xs = [];
    delta_Ys = [];
    for t = 1:length(Xs)-1
        delta_X = Xs(1:end-t)-Xs(1+t:end);
        delta_Y = Ys(1:end-t)-Ys(1+t:end);
        delta_Xs = [delta_Xs;delta_X];
        delta_Ys = [delta_Ys;delta_Y];
        Tau = [Tau;t];
        msdx = mean(delta_X.^2);
        msdy = mean(delta_Y.^2);
        MSDs = [MSDs;msdx+msdy]; 
    end
    finalXs = [finalXs;delta_Xs];
    finalYs = [finalYs;delta_Ys];
    MSD_final = [MSD_final;MSDs];
    Tau_final = [Tau_final;Tau];
    Xs = [];
    Ys = [];
end
finalYs;
finalXs;
figure
plot(finalXs,finalYs,'r.')
figure
plot(x,y,'.');
figure
plot(Tau_final,MSD_final,'k.')
end
