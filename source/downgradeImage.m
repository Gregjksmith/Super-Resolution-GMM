function [ out ] = downgradeImage( in , level )

x=-30:1:30; y=x;
[X,Y]=meshgrid(x,y);
h2 = exp( -(X.^2 + Y.^2)/(2*level^2));
%divide by the DC gain to normalize the filter
dcGain = (sum(sum((h2))));
h2 = h2/dcGain;

out = conv2(double(in),h2,'same');

end

