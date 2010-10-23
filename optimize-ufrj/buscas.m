function [passo,cont_it_lin] = buscas(bl,d_descida,x,eps,max_it)

%----------------------------- Buscas Lineares ---------------------------
switch bl

    %------------- Fibonacci
    case 1
        nit = eps; % fibonacci � o �nico que precisa do n�mero de itera��es.
        [passo,cont_it_lin] = busca_fibonacci(d_descida,x,nit,max_it);

    %------------- Razao �urea
    case 2
        [passo,cont_it_lin] = busca_aurea(d_descida,x,eps,max_it);

    %------------- Interpola��o Quadr�tica
    case 3
        %[passo,cont_it_lin] = interpolacao(d_descida,x,eps,max_it);

    %------------- Interpola��o (Brent)
    case 4
        %[passo,cont_it_lin] = brent(d_descida,x,eps,max_it);

end