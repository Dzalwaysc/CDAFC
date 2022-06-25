function [] = draw_arrow(Pos, Yaw, len, color)
    startPos = Pos;
    endPos = [Pos(1)+len*cos(Yaw), Pos(2)+len*sin(Yaw)];
    line([startPos(1),endPos(1)], [startPos(2),endPos(2)], 'Color', color);
end