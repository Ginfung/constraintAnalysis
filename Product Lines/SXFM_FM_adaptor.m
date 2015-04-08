function [ f ] = SXFM_FM_adaptor( x,n )
global ori_problem;
global ObjectiveDimension;
f = ori_problem(x,ObjectiveDimension);
end

