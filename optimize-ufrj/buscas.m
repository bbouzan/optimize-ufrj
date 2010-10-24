function [passo,cont_it_lin] = buscas(bl,d_descida,x,eps,max_it)

%----------------------------- Buscas Lineares ---------------------------
switch bl

    %------------- Fibonacci
    case 1
        nit = eps; % fibonacci é o único que precisa do número de iterações.
        [passo,cont_it_lin] = busca_fibonacci(d_descida,x,nit,max_it);

    %------------- Razao Áurea
    case 2
        [passo,cont_it_lin] = busca_aurea(d_descida,x,eps,max_it);

    %------------- Interpolação Quadrática
    case 3
        [passo,cont_it_lin] = busca_interpolacao(d_descida,x,eps,max_it);

    %------------- Interpolação (Brent)
    case 4
        [passo,cont_it_lin] = busca_brent(d_descida,x,eps,max_it);

end