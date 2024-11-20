function [sse, prob_costheta] = henyey(parameters, theta, ydata)
    g = parameters(1)

    numerator = 1-(g^2)
    denominator = (1 + (g^2) - 2*g.*cos(deg2rad(theta))).^(3/2)
    prob_costheta = 0.5 .* (numerator ./ denominator)

    sse = sum((ydata - prob_costheta).^2);
end
