function [err, matchV] = evalCL_Error( o, y )
% [err, matchV] = ECL_Error( o, y )
%
% Compute the clustering error
% with the bipartite maximal weighted matching algorithm
%
% Mingrui Wu, 2006

% build edge matrix
nData = length( y );
nC = max( y );
E = zeros( nC, nC );
for m = 1 : nData
    i1 = o( m );
    i2 = y( m );
    E( i1, i2 ) = E( i1, i2 ) + 1;
end
E = int32( E' );
[ nMatch, matchV ] = BMWM_Mex( E );

matchV = matchV + 1;
err = 1 - nMatch/nData;