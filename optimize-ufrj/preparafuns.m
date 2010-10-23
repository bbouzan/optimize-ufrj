function preparafuns(nvar)

evalin('base','xsym = [];');

for i = 1:nvar
    evalin('base',strcat('syms ',' x',num2str(i),';'));
    evalin('base',strcat('xsym = [ xsym ; ',' x',num2str(i),'];'));
end

evalin('base','grad_fun = jacobian(fun,xsym);');

evalin('base','hess_fun = jacobian(grad_fun,xsym);');