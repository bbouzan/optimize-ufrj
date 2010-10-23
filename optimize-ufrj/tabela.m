function [ok] = tabela(xmin,vet_d_descida,vet_df,vet_passo,vet_cont_it_lin, cont_it,vet_f,vet_lambda0)

if nargin == 6
%if cont_it < 40
    tabela = cell(cont_it,5);
    tabela(1,1) = cellstr('Núm. Iterações');
    tabela(1,2) = cellstr('|d|');
    tabela(1,3) = cellstr('grad(f)');
    tabela(1,4) = cellstr('Passo');
    tabela(1,5) = cellstr('Núm. Iterações Busca Linear');

    for k=2:cont_it
        tabela(k,1) = cellstr(num2str(k-1));
        tabela(k,2) = cellstr(num2str(vet_d_descida(k-1)));
        tabela(k,3) = cellstr(num2str(vet_df(k-1)));
        tabela(k,4) = cellstr(num2str(vet_passo(k-1)));
        tabela(k,5) = cellstr(num2str(vet_cont_it_lin(k-1)));
    end
% else
%     tabela = cell(floor((cont_it+1)/50),5);
%     tabela(1,1) = cellstr('Num. Iteracoes');
%     tabela(1,2) = cellstr('|d|');
%     tabela(1,3) = cellstr('grad(f)');
%     tabela(1,4) = cellstr('Passo');
%     tabela(1,5) = cellstr('Num. Iteracoes Busca Linear');
%     cont_aux = 1;
%     for k=2:(floor((cont_it+1)/50))
%         tabela(k,1) = cellstr(num2str(cont_aux));
%         tabela(k,2) = cellstr(num2str(vet_d_descida(cont_aux)));
%         tabela(k,3) = cellstr(num2str(vet_df(cont_aux)));
%         tabela(k,4) = cellstr(num2str(vet_passo(cont_aux)));
%         tabela(k,5) = cellstr(num2str(vet_cont_it_lin(cont_aux)));
%         cont_aux = cont_aux + 50;
%     end
% end
end

if nargin == 8
    tabela = cell(cont_it,5);
    tabela(1,1) = cellstr('Num. Iteracoes');
    tabela(1,2) = cellstr('|f|');
    tabela(1,3) = cellstr('|d|');
    tabela(1,4) = cellstr('|lambda0|');
    tabela(1,5) = cellstr('grad(f)');
    tabela(1,6) = cellstr('Passo');
    tabela(1,7) = cellstr('Num. Iteracoes Busca Linear');
    
    for k=2:cont_it
        tabela(k,1) = cellstr(num2str(k-1));
        tabela(k,2) = cellstr(num2str(vet_f(k-1)));
        tabela(k,3) = cellstr(num2str(vet_d_descida(k-1)));
        tabela(k,4) = cellstr(num2str(vet_lambda0(k-1)));
        tabela(k,5) = cellstr(num2str(vet_df(k-1)));
        tabela(k,6) = cellstr(num2str(vet_passo(k-1)));
        tabela(k,7) = cellstr(num2str(vet_cont_it_lin(k-1)));       
        
    end
end
    
assignin('base','tabela',tabela);
assignin('base','xmin',xmin);

evalin('base','report resultado.rpt;');

ok=0;