% Had a meeting with Dr Ashwin. He suggested I make a loop over every day
% and average all data points over x to get the axisymmetric version


clc
clear

file = '/home/roshan/Documents/Research/Climate_Science/1992';

ncid = netcdf.open(file,'NC_NOWRITE');
%fileinfo = ncinfo(file);
%dimNames = {fileinfo.Dimensions.Name};
%vinfo = ncinfo(file);



for i=0:10
   
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,i);
    variant{i+1}=varname;
    varid(i+1) = netcdf.inqVarID(ncid,variant{i+1});
end
clear varname


for varno=3:10
    variabl = netcdf.getVar(ncid,varno,[1 1 1], [479 240  151]);
    variablXAvg = mean(variabl,1); % averaged over all longitude values i.e. rows .
   
    for i=1:151
        FXavg(i,:) = variablXAvg(1,:,i); % Convert the matrix structure from [long lat time] to [time lat] 
    end
    FXavgDetrend = detrend(FXavg,0); % Removing means over time from the x averaged data set 
    Covar = FXavgDetrend'*FXavgDetrend; % Construction of the covariance matrix 
    [Evec,Eval] = eig(Covar); % Evec represents the eigenvectors and Eval represents the eigenvalues 
    count = varno-2;% This variable removes the longitude, latitude and time data from the first 3 columns 
    % Divide every eigenvalue by the sum of eigenvalues.
    VarianceCapture(:,count) = diag(Eval)/trace(Eval); 
    % The maximum values capture most variance 
    header(count) = variant(varno+1);
end

VarianceCapture1992 = [header;num2cell(VarianceCapture)];

save -MAT VarianceCapture1992.mat VarianceCapture1992;



            