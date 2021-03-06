###########################################
#  This main is for project
#  Author: wangjiechao and hanpeiqin
#  Date: 2015.12.21
#  Version: 1.0
###########################################

using Winston

include("real_orbit.jl")
include("OURRK45.jl")
include("PlotCom.jl")

g=-10;
T=1;
TOL=0.000001;
ATOL=0.0000001;
hinit=0.1;

range=[8 12];

f(x)=[real_vel(x[2]);1];
xinit=[500;0];

pl_trace(t)=real_heiorbit(t);


pl_OURRK45(t)=OURRK45(f,xinit,t,hinit,TOL,ATOL);
point2=pl_OURRK45(13);
y2=point2[1];
t2=point2[2];
PlotCom(range,pl_trace,y2,t2);


