function [ Obj ] = createimpulsiven( a, b, c )
%
% Author: Jefferson Osowsky.
%
% Create an impulsively distributed random number generator.
% a, b = lower and upper limits, respectively, on the values that
%        the noise can take.
% c = 0 < c < 1. coeficient that defines the probability that an
%     impulsive noise happens. Higher c means more noise.
%
% Obj = Impulsive noise object used to generate vector with
%       impulsive noise by calling getimpulsiven function.
%
% PDF: f( x ) = c / ( b - a ) + ( 1 - c ) * d( x ),
%      where d( x ) is the delta Dirac function.
%
% CDF: F( x ) = c * ( x - a ) / ( b - a ) + ( 1 - c ) * u( x ),
%      where u( x ) is the step function.
%
% e.g. X = IN = createimpulsiven( -1, 1, 0.0005 );
%
% T. Trump & I. Muursepp, ROBUST SPECTRUM SENSING FOR COGNITIVE RADIO,
% In: 19th European Signal Processing Conference (EUSIPCO 2011),
% Barcelona, Spain, pp. 1224-1228, 2011.
%
%Zero all output variables.
Obj = [];
% Test input arguments.
if ( ( a >= b ) || ( a > 0 ) || ( b < 0 ) || ( c <= 0 ) || ( c >= 1 ) )
    return;
end
% Create object.
Obj.a = a;
Obj.b = b;
Obj.c = c;
Obj.k1 = c / ( b - a );
Obj.k2 = -( a * c ) / ( b - a );
end
