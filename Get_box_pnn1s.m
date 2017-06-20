function box = Get_box_pnn1s( SSE, l_Tc )
box = 1; %to jest index a w matlabie nei moze byc 0
for i=1:l_Tc
    if (SSE >= ((i-1) / l_Tc))&& (SSE < (i/l_Tc))
        box = box + (i-1);
        break;
    end
end

end
