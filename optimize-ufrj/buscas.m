function [passo,cont_it_lin] = buscas(bl,d_descida,x,eps,max_it)

%----------------------------- Buscas Lineares ---------------------------
switch bl

    %------------- Fibonacci
    case 1
        %[passo,cont_it_lin] = fibonacci(d_descida,x,eps,max_it);

    %------------- Razao Áurea
    case 2
        [passo,cont_it_lin] = busca_aurea(d_descida,x,eps,max_it);

    %------------- Interpolação Quadrática
    case 3
        %[passo,cont_it_lin] = interpolacao(d_descida,x,eps,max_it);

    %------------- Interpolação (Brent)
    case 4
        %[passo,cont_it_lin] = brent(d_descida,x,eps,max_it);

end