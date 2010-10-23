function grad = avaliagrad(xeval)

assignin('base','xeval',xeval);
grad = evalin('base','subs(grad_fun,xeval);');

grad = double(grad(:,1));

