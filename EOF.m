clc
clear
dataload = '/home/roshan/Documents/Research/Climate_Science/ERA_DATA/Sept_1981.nc';
nc_dump(dataload)
ncid = netcdf.open(dataload,'NC_NOWRITE');
[numdims,numvars] = netcdf.inq(ncid);
j=0;
 for i=1:12
      j=i-1;
      var{i}= netcdf.inqVar(ncid,j);
 end
 
 lvl = input('Please enter which pressure level(850=1/200=2): ');
 
 data = nc_varget(dataload,var{5}, [1 lvl 0 0],[306 lvl 241 480]);
 
 