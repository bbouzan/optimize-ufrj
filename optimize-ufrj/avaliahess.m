function hess = avaliahess(xeval)

assignin('base','xeval',xeval);
hess = evalin('base','subs(hess_fun,xsym,xeval);');


