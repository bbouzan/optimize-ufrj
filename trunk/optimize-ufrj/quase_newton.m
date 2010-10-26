function [x] = quase_newton(x0,bl,crit_parada,aux,nvar)

x = x0;
cond_parada = 1;
cont_it = 1;
cont_it_lin = 0;
df = avaliagrad(x);
hessf = eye (nvar); 

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
    
    if ( cont_it > 1 ) && ( crit_parada(1) > 0 ) && ( abs(f - vet_f(cont_it-1)) < crit_parada(1) )
        cond_parada = 0;        
        break;
    end
    
    if ( cont_it > 1 ) &&  ( crit_parada(2) > 0 ) && ( (abs(f - vet_f(cont_it-1))/abs(vet_f(cont_it-1))) < crit_parada(2) )
        cond_parada = 0;        
        break;
    end

    %----------------------Calcula a Direcao de Descida ---------------------

    % -------------------- Metodo de Quase_Newton
    %df = avaliagrad(x);
    %hessf = avaliahess(x);
    
    if ( any( isnan(df) == 1 ))
        cond_parada = 0;        
        break;
    end

    if ( crit_parada(3) > 0 ) && ( norm(df) < crit_parada(3) );
        cond_parada = 0;        
        break;
    end
    
    d_descida = -(hessf)*df;

    %----------------------------- Busca Linear ---------------------------

    [passo,cont_it_lin] = buscas(bl,d_descida,x,crit_parada(5),crit_parada(4));

    % ------------------------- Fim ----------------------------------------
    vet_x(:,cont_it) = x;
    vet_f(cont_it) = f;
    vet_df(:,cont_it) = df;
    vet_d_descida(:,cont_it) = d_descida;
    vet_df_norm(cont_it) = norm(df);
    vet_d_descida_norm(cont_it) = norm(d_descida);
    vet_passo(cont_it) = passo;
    vet_cont_it_lin(cont_it) = cont_it_lin;

    x_ant = x;
    
    df_ant = df;
    
    x = x + passo*d_descida;
    
    df = avaliagrad(x);
    
    sigma = x - x_ant;
    
    gama = df - df_ant;
    
    if aux
        hessf = hessf - ((((sigma)*(gama')*(hessf))+((hessf)*(gama)*(sigma')))/((sigma')*(gama))) + (((1 + ((gama')*(hessf)*(gama)))/((sigma')*(gama)))*(((sigma)*(sigma'))/((sigma')*(gama))));
    else
        hessf = hessf - (((hessf)*(gama)*(gama')*(hessf))/((gama')*(hessf)*(gama))) + (((sigma)*(sigma'))/((sigma')*(gama)));
    end
    
    cont_it = cont_it + 1;
end


% ------------------- Gerando o gráfico

ok = grafico(x0,vet_x, vet_f);


% ------------------- Gerando a tabela de saida no arquivo resultado.rtf

ok = tabela(x,vet_d_descida_norm,vet_df_norm,vet_passo,vet_cont_it_lin, cont_it);
    


