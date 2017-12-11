function d = getCosineDistance(a,b)

den = size(a,2)^2;

d = -(a*b')/den; 
% the minus is added just to be consistent with 
% the rest of the code --> see how cosine sim. is evaluated

end