clc
clear
dataload = '/home/roshan/Documents/Research/Climate_Science/ERA_DATA/Sept_1981.nc';

ncid = netcdf.open(dataload,'NC_NOWRITE');
datainfo = ncinfo(dataload);
%disp(datainfo)
dimNames = {datainfo.Dimensions.Name};
vinfo = ncinfo(dataload,'d');
vsize = vinfo.Size;
%lvl=1;
diver = ncread(dataload,'d',[1 1 1],[inf inf inf]);
x=1;
for i=1:15
    for j=1:41
        
        for t=1:30
            diver4eof(t,x)=diver(i,j,t);
        end
        x=x+1;
    end
end

DemeanedDiver = detrend(diver4eof,0);
CovDiver = DemeanedDiver'*DemeanedDiver;
[C,L] = eig(CovDiver);

VarianceAmount = diag(L)/trace(L);


%j=1;

% for i=1:615
%     if (L(i,i)>mean(VarianceAmount))
%         PCi(j) = DemeanedDiver * C(:,i);
%         index(j) = i;
%         j=j+1;
%     end
% end


%PCi = DemeanedDiver*C(:,i);


PC615 = DemeanedDiver*C(:,615);






