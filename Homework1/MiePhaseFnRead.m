function [theta, phasefn] = MiePhaseFnRead(fname)

fid = fopen(fname);

for n = 1:22
    txt{n} = fgetl(fid);
end

[A, C] = fscanf(fid,'%f');
Data = reshape(A,4,[])';

theta = Data(:,1);
phasefn = Data(:,4);

fclose(fid);
