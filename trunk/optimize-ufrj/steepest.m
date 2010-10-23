function [x] = steepest(x0,bl,crit_parada,aux)

x = x0;
fold = inf;
cond_parada = 1;
cont_it = 1;
cont_it_lin = 0;

while ~(cond_parada == 0)
    
    if ( crit_parada(4) > 0 ) && ( cont_it > crit_parada(4) )
        cond_parada = 0;        
        break;
    end    
    
    x = x(:);    
    
    if ( any( isnan(x) == 1 ))
        cond_parada = 0;        
        break;
    end 

    %------------------------------  Calcula a funcao ----------------------
    f = avaliafun(x);
    
    if ( any( isnan(f) == 1 ))
        cond_parada = 0;        
        break;
    end
    
    if ( crit_parada(1) > 0 ) && ( abs(f - fold) < crit_parada(1) )
        cond_parada = 0;        
        break;
    end
    
    if ( crit_parada(2) > 0 ) && ( (abs(f - fold)/abs(fold)) < crit_parada(2) )
        cond_parada = 0;        
        break;
    end

    %----------------------Calcula a Direcao de Descida ---------------------

    % -------------------- Metodo do Gradiente
    df = avaliagrad(x);
    
    if ( any( isnan(df) == 1 ))
        cond_parada = 0;        
        break;
    end

    if ( crit_parada(3) > 0 ) && ( norm(df) < crit_parada(3) );
        cond_parada = 0;        
        break;
    end
    
    d_descida = -df;    

    %----------------------------- Busca Linear ---------------------------

    [passo,cont_it_lin] = buscas(bl,d_descida,x,crit_parada(5),crit_parada(4));

    % ------------------------- Fim ----------------------------------------
    vet_df(cont_it) = norm(df);
    vet_d_descida(cont_it) = norm(d_descida);
    vet_passo(cont_it) = passo;
    vet_cont_it_lin(cont_it) = cont_it_lin;
    
    fold = f;

    x = x + passo*d_descida;
    
    cont_it = cont_it + 1;
end


% ------------------- Gerando a tabela de saida no arquivo resultado.rtf

ok = tabela(x,vet_d_descida,vet_df,vet_passo,vet_cont_it_lin, cont_it);
    


