 
% Skeleton code for DCS fitting with fminsearch

% Fill in '??' to complete the skeleton code

 start_point = [??];
 estimates = fminsearch(@(params) DCSmodel(params, ??, ??, ??, ??, 1.4, 1.4, 785, ??, ??), start_point);
 [sse, FittedCurve] = DCSmodel(??, ??, ??, ??, ??, 1.4, 1.4, 785, ??, ??);