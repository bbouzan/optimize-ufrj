function f = avaliafun(xeval)

assignin('base','xeval',xeval);
f = evalin('base','subs(fun,xsym,xeval);');