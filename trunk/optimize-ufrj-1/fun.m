function f = fun(xeval)

assignin('base','xeval',xeval);
f = evalin('base','subs(fun,xeval);');