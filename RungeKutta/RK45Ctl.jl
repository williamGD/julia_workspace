#################################################
#  This module is for Runge Kutta by step size contral
#  Main Fuction : RK45Ctl
#  Input :f::Function
#         x0    : Init x0
#         T     : Time
#         hinit : Init step size
#         TOL   : Tolerate
#         ATOL  : Absolute Tolerate
#  Output:y:x(T)
#  Author: wangjiechao
#  Date: 2016.1.13
#  Version: 1.0
#################################################

function RK45Ctl(f,x0,T,hinit,TOL,ATOL)
  t=0;
  ################init
  n=length(x0);
  h=hinit;#Init step size
  ti=0;#Init time

  ynew=x0;#Init point
  yi=ynew;
  #################Coefficence
  A    =[0             0             0             0             0             0            0;
         1/5           0             0             0             0             0            0;
         3/40          9/40          0             0             0             0            0;
         44/45         -56/15        32/9          0             0             0            0;
         19372/6561    -25360/2187   64448/6561    -212/729      0             0            0;
         9017/3168     -355/33       46732/5247    49/176        -5103/18656   0            0;
         35/384        0             500/1113      125/192       -2187/6784    11/84        0];
  b_hat=[5179/57600    0             7571/16695    393/640       -92097/339200 187/2100     1/40];

  while(ti<T)
            ti=ti+h;

  ##########board#############
            if(ti>=T)
              h=T-ti+h;
            end####ti>=T
  ############################

  ############while################
        while 1==1
            hA=A*h;
            hb_hat=h*b_hat;#
            ki=zeros(Float64,7,n);

            for i in 1:1:6
                ki[i,:]=f(yi+(hA[i,:]*ki)');
            end#cal k1，k2，k3，k4，k5，k6

           ynew=yi+(hA[7,:]*ki)';#cal 5 order

           ki[7,:]=f(ynew);
           znew=yi+(hb_hat*ki)';#cal 4 order

  #################error contral#########################
           e=zeros(Float64,n,1);
           for j in 1:1:n
              e[j]=abs(ynew[j]-znew[j])/(TOL*abs(yi[j])+ATOL);
           end#####cal e[j]
           enorm=norm(e);
              if(enorm<=1)
                 break;#####accept h
              end#enorm
  ######################################################
           h=0.9*h/(enorm^(1/5));#reject h and dertemine a new h
        end##end while
   ###################################
           yi=ynew;
    end####ti<T
return yi;

end
