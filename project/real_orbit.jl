###########################################
#  This module is for Real orbit
#  Author: wangjiechao and hanpeiqin
#  Main Fuction : Newtoninter
#  Input :range
#         f::Function
#  Output:getPloynomial
#  Date: 2015.12.21
#  Version: 1.0
###########################################

function heaviside(t)
   0.5 * (sign(t) + 1);
end
function interval(t, a, b)
   heaviside(t-a) - heaviside(t-b);
end
###########################################
#  This function is about real velocity
#  Date: 2015.12.21
#  Version: 1.0
###########################################
function real_vel(t)
    if t==10
    return 80;
    else
    return (-10*t)* interval(t,0,10) + (80-10*(t-10))* interval(t,10,18);
    end
end
###########################################
#  This function is about real height' orbit
#  Date: 2015.12.21
#  Version: 1.0
###########################################
function real_heiorbit(t)
    if t==0
        return 500;
    end
    if t==10
    return  0;
    else
    return (500-5*t^2)* interval(t,0,10) + (80*(t-10)-5*(t-10)^2)* interval(t,10,18);
    end
end
