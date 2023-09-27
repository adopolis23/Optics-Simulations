function [lambda, I] = MieWavelengthRead(fname)

fid = fopen(fname);

for n = 1:15
    txt{n} = fgetl(fid);
end

[A, C] = fscanf(fid,'%f');
Data = reshape(A,7,[])';

lambda = Data(:,1);
I = Data(:,6);

fclose(fid);


%0.196285