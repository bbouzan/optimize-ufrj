function [ok] = grafico(x0,vet_x,vet_f)

graph = -1;
nvar = evalin('base','nvar');

if nvar == 2
    graph = figure;
    plot3(vet_x(1,:),vet_x(2,:),vet_f,'--ks','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','w',...
                'MarkerSize',10);
    hold on;
    scale = [1.2*-x0(1),1.2*x0(1),1.2*-x0(2),1.2*x0(2)];
    ezsurf(evalin('base','fun'),scale);
end

assignin('base','graph',graph);

ok = 0;

