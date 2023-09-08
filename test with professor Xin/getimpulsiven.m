function [ X ] = getimpulsiven( Obj, N )
%
% Author: Jefferson Osowsky.
%
% Impulsively distributed random number generator.
% Obj: Impulsivw noise object.
%
% X is the 1-by-N vector of random numbers.
%
% PDF: f( x ) = c / ( b - a ) + ( 1 - c ) * d( x ),
%      where d( x ) is the delta Dirac function.
%
% CDF: F( x ) = c * ( x - a ) / ( b - a ) + ( 1 - c ) * u( x ),
%      where u( x ) is the step function.
%
% e.g.: Generate a vector x of 10 seconds with impulsive noise.
%       Play that sound in the default sound card.
%
% fs = 48000; % sample rate.
% N = 10;
% x = [];
%
% IN = createimpulsiven( -1, 1, 0.0005 );
%
% for i = 1 : N
%   y = getimpulsiven( IN, fs );
%   x = [ x y ];
% end
%
% b = fir1( 480, 10000 / ( fs / 2 ) );
% sound( filter( b, 1, x ), fs );
%
% T. Trump & I. Muursepp, ROBUST SPECTRUM SENSING FOR COGNITIVE RADIO,
% In: 19th European Signal Processing Conference (EUSIPCO 2011),
% Barcelona, Spain, pp. 1224-1228, 2011.
%
%Zero all output variables.
X = [];
% Test input arguments.
if ( ( isempty( Obj ) ) || ( ~isstruct( Obj ) ) || ( N <= 0 ) )
    return;
end
% Generate a sequence of random numbers impulsively distributed.
U = rand( 1, N );
X = zeros( 1, N );
for i = 1 : N
    if ( U( i ) < Obj.k2 )
        X( i ) = ( U( i ) / Obj.k1 ) + Obj.a;
    elseif ( U( i ) > Obj.k2 + 1 - Obj.c )
        X( i ) = ( ( Obj.c - 1 + U( i ) ) / Obj.k1 ) + Obj.a;
    else
        X( i ) = 0;
    end
end
end
