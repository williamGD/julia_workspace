#################################################
#  This module is for Newton Polynomials
#  Author: wangjiechao
#  Main Fuction : Newtoninter
#  Input :range
#         f::Function
#  Output:getPloynomial
#  Date: 2016.1.13
#  Version: 1.0
#################################################


using Winston
# type_name:DividedDifferenceTable
# get a divide difference table
type DividedDifferenceTable
  x::Vector{Any} #data point(x-coordinate)
  d::Vector{Any} #coefficients in the table
  DividedDifferenceTable() = new(Array(Any,0),Array(Any,0));
end

#function_name:getNumPoints
#function_describe:get the Number of date points
#input:T::DividedDifferenceTable
#output:the length of table x-coordinate
function getNumPoints(T::DividedDifferenceTable)
  return length(T.x);
end

#function_name:addPoint!
#function_describe:add new points into table
#input:T::DividedDifferenceTable,new data point
#output:table which had added a new data point
function addPoint!(T::DividedDifferenceTable,x,y)
  n=getNumPoints(T);             #number of data points
  T.x=[T.x,x];                   #append the x-coordinate
  T.d=[T.d,y];                   #append the y-coordinate
  for i=1:n
    nom = T.d[end]-T.d[end-n];   #nominator of d-d recursion
    den = T.x[end]-T.x[end-i];   #de-nominator of d-d recursion
    T.d=[T.d,nom/den];           #append the computed quotient
  end
end

#function_name:getNewtonCoefficients
#function_describe:get Newton Coefficients
#input:T::DividedDifferenceTable
#output:Array c
function getNewtonCoefficients(T::DividedDifferenceTable)
  n=length(T.x);         #number of data points
  c=Array(Any,0);        #empty array
  k=0;                   #initiate run index
  for i=1:n
    k+=i;                #pick the coefficients
    c=[c,T.d[k]];        #the first row of the table
  end
  return c;
end

#function_name:getPloynomial
#function_describe:get Ploy nomial
#input:T::DividedDifferenceTable
#output:return function p(x) and return b
function getPloynomial(T::DividedDifferenceTable)
  n=length(T.x);                  #n
  c=getNewtonCoefficients(T);     #Newton coeff
  return function p(x)
    b=c[end];
    for i=1:n-1
      b=c[n-i]+b*(x-T.x[n-i]);    #Horner's recursion
    end
    return b;                     #result of the evaluation
  end
end

#function_name:interpolate
#function_describe:inter polate
#input:range and f
#output:return getPloynomial()
function Newtoninter(range,f::Function)
    table = DividedDifferenceTable();
    for i=1:length(range)
        addPoint!(table,range[i],f(range[i]));
    end
  return getPloynomial(table);
end
