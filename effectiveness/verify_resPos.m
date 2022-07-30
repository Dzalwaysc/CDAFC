function [] = verify_resPos(Eta, edge, tr, begin, interval)
    figure(1);
    plot(Eta{1}(:,1), Eta{1}(:,2), ... 
         Eta{2}(:,1), Eta{2}(:,2), ... 
         Eta{3}(:,1), Eta{3}(:,2), ...
         Eta{4}(:,1), Eta{4}(:,2), ... 
         Eta{5}(:,1), Eta{5}(:,2), ...
         Eta{6}(:,1), Eta{6}(:,2), ...
         Eta{7}(:,1), Eta{7}(:,2));
    hold on;
    axis([-25 5 -5 25]);
    for i=begin:interval:length(tr)
        for j=1:size(edge,2)
            index1 = edge(1,j); index2 = edge(2,j);
            plot([Eta{index1}(i,1), Eta{index2}(i,1)], [Eta{index1}(i,2), Eta{index2}(i,2)], 'k', 'LineWidth', 2); hold on;
        end
        for k=1:size(Eta,2)
            plot(Eta{k}(i,1), Eta{k}(i,2), '.', 'MarkerSize', 15);
        end
    end
end
