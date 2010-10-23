function otimizar

%clear all;
%close all;
clc;
format long;

fprintf(1,'\n OPTIMIZE \n\n');

%---------------------- Configuração -------------------------
mo = evalin('base','mo');
mo_aux = evalin('base','mo_aux');
bl = evalin('base','bl;');
crit_parada = evalin('base','crit_parada;');
fun = evalin('base','fun');
x0 = evalin('base','x0');
nvar = evalin('base','nvar');

preparafuns(nvar);

%---------------------- Métodos de Otimização -------------------------
switch mo
    
    %------------- Gradiente
    case 0     
        x = steepest(x0,bl,crit_parada,mo_aux);
     
    %------------- Gradiente Conjugado
    case 1     
        x = steepest_conj(x0,bl,crit_parada,mo_aux);
        
    %------------- Newton    
    case 2     
        %x = newton(x0,bl,crit_parada,mo_aux);
        
    %------------- Newton Modificado    
    case 3     
        %x = newton_mod(x0,bl,crit_parada,mo_aux);
        
    %------------- Quase-Newton   
    case 4     
        %x = quase_newton(x0,bl,crit_parada,mo_aux);
end