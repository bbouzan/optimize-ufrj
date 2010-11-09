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
    
    plot(vet_x(1,:),vet_x(2,:),'--ks','LineWidth',0.5,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','w',...
                'MarkerSize',4);
                        
    %vet_x = [x0 vet_x];
    
    %xmin = min(vet_x(1,:));
    %xmin = xmin - 2*sign(xmin);
    
    %xmax = max(vet_x(1,:));
    %xmax = xmax + 2*sign(xmax);
    
    %ymin = min(vet_x(2,:));
    %ymin = ymin - 2*sign(ymin);
    
    %ymax = max(vet_x(2,:));
    %ymax = ymax + 2*sign(ymax);
           
    % scale = [1.2*min(vet_x(1,:)),1.2*max(vet_x(1,:)),1.2*min(vet_x(2,:)),1.2*max(vet_x(2,:))];
    %scale = [xmin, xmax, ymin, ymax];
    
    scale = axis;    
    ezsurfc(evalin('base','fun'),scale(1:4));
end

assignin('base','graph',graph);

ok = 0;

