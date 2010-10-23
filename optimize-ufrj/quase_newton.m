function [x,f,g,lambda0,mu0,counter] = quase_newton(fun,gfun,x0,vlb,vub,nvar,ncstr,neq,neqlin,lvlb,lvub,nprob,data,idata,iutil,rutil)

k = 0; 
x = x0; % x0 e a condicao inicial
indf = 1; % df e computado
indgradf = 1; % df e computado
indg = zeros(ncstr,1); % sem restricoes
indgradg = zeros(ncstr,1); % sem restricoes
counter(1) = 0;
counter(2) = 0;
lambda0 = 0;
mu0 = 0;
diferenca = ones(nvar,1);
cond_parada = 1;
cont_it = 0; %Contador de iteraçoes
H = eye(nvar);

while ~(cond_parada == 0) %& (k <= idata(7))    
    
    x = x(:);
    cont_it = cont_it + 1;
    
    %------------------------------  Calcula a funcao ----------------------
    [f,g]=feval(fun,x,indf,indg,nprob,iutil,rutil);
    counter(1) = counter(1) + 1;
    
    %----------------------Calcula a Direcao de Descida ---------------------
    
    % -------------------- Quase-Newton (DFP)   
    if idata(14) == 0
        
        [df,dg] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
        counter(2) = counter(2) + 1;
        d_descida = -H*df;  % Calculo da nova direçao de descida
        %tabela:
        vet_df(cont_it) = norm(df);
        vet_d_descida(cont_it) = norm(d_descida);
    end

    %----------------------------- Busca Linear ---------------------------

    [passo,cont_it_lin] = buscas(fun,gfun,counter,idata,d_descida,f,df,x,indf,indg,nprob,iutil,rutil,nvar,data);
 
    % ------------------------- Fim ----------------------------------------


    vet_passo(cont_it) = passo;
    vet_cont_it_lin(cont_it) = cont_it_lin;
    diferenca = abs(- passo*d_descida);
    for i=1:nvar
        if (diferenca(i) < 0.00001)  %data(1)
            parada(i) = 0;
        else
            parada(i) = 1;
        end
    end
    cond_parada = 0;
    for i=1:nvar
        cond_parada = cond_parada + parada(i);
    end


    x = x + passo*d_descida


    %atualizaçao de H
    [dfprox,dgprox] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
    counter(2) = counter(2) + 1;

    gama = dfprox - df;  % Define gama
    %delta = diferenca; % Define delta
    delta = passo*d_descida;

    H = H + ((delta*delta')/(delta'*gama)) - ((H*gama*gama'*H)/(gama'*H*gama)); % Atualizaçao de Posto 2 de H (DFP)
    %H = H + (((delta-(H*gama))*(delta-(H*gama))') / ((gama'*(delta-(H*gama))))); % Atualizaçao de Posto 1 de H (DFP)

    k = k + 1;% incrementa o contador

       
end



% ------------------- Gerando a tabela de saida no arquivo resultado.rtf

[ok] = tabela(vet_d_descida,vet_df,vet_passo,vet_cont_it_lin, cont_it);
    


