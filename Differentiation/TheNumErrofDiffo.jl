#################################################
#  This test is to get the numerical error of
#  central difference routine for the function
#  f(x)=x^2+cos(x^2) at x=0 and at x=1 in dependence
#  of the step size h>0 (use logarithmic axis)
#  Author: wangjiechao
#  Date: 2016.1.13
#  Version: 1.0
#################################################

include("Basic.jl")
using Gadfly;
plot1=plot(h->f_d(1,h)-g(1),10.^(-10.),10.^(-1.)
    ,Guide.ylabel("NumErr")
     ,Guide.xlabel("h")
     ,Guide.title("NumerError(at x=1)"));
plot2=plot(h->f_d(0,h)-g(0),10.^(-10.),10.^(-1.)
     ,Guide.ylabel("NumErr")
     ,Guide.xlabel("h")
     ,Guide.title("NumerError(at x=0)"));

plot3=plot(h->Log_NumErr(1,h),10.^(-10.),10.^(-1.)
     ,Guide.ylabel("NumErr(log10)")
     ,Guide.xlabel("h")
     ,Guide.title("NumerError(at x=1)"));

plot4=plot(h->Log_NumErr(0,h),10.^(-10.),10.^(-1.)
     ,Guide.ylabel("NumErr(log10)")
     ,Guide.xlabel("h")
     ,Guide.title("NumerError(at x=0)"));

plot5=plot(
  layer(
    #First layer
    h->f_d(0,h)-g(0),10.^(-10.),10.^(-1.),
    Theme(
      default_color=color("blue"),
      line_width=3pt
      )
    ),
    layer(
    #Second layer
    h->Log_NumErr(1,h),10.^(-10.),10.^(-1.),
    Theme(
      default_color=color("red"),
      line_width=3pt,
      )
    ),
  #background
  Theme(
    panel_fill=color("#FFFF00"),
    panel_opacity=0.1,
    panel_stroke=color("Black"),
    ),
  Guide.ylabel("y"),
  Guide.xlabel("x"),
  Guide.title("at x=0 and at x=1"),
  );

