function [] = verify_desPos(desPos, desPosd, desPosdd, tr, dt)
    % desPos->desiredPos
    figure(1);
    h1 = animatedline;
    h2 = animatedline;
    h3 = animatedline;
    axis([0 40 -5 35]);
    
    % 验证desPos
    for i=1:length(tr)
        addpoints(h1, desPos{1}(i,1), desPos{1}(i,2));
        % drawnow
    end
    
    % 验证desPosd
    Pos = desPos{1}(1,:);
    for i=2:length(tr)
        Pos = Pos+desPosd{1}(i-1,:)*dt;
        addpoints(h2, Pos(1), Pos(2));
        % drawnow
    end
    
    % 验证desPosdd
    Pos = desPos{1}(1,:);
    Posd = desPosd{1}(1,:);
    for i=2:length(tr)
        Posd = Posd + desPosdd{1}(i-1,:)*dt;
        Pos = Pos + Posd*dt;
        addpoints(h3, Pos(1), Pos(2));
        % drawnow
    end
end