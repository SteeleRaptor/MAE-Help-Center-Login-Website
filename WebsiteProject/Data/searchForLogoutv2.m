function time = searchForLogoutv2(selected_dates,data2,logout_dates)
time = zeros(24*60,1);
for i = 1:height(selected_dates)
    found = false;
    for j = 1:height(data2)
        if string(data2{j,1}) == string(selected_dates{i,1})
            if day(logout_dates(j))==day(selected_dates{i,2}) && logout_dates(j)>selected_dates{i,2}
                time = time + counttime(selected_dates{i,2},logout_dates(j));
                found = true;
                break;
            end
        end
    end
    if ~found
        time = time + counttime(selected_dates{i,2},day(selected_dates{i,2})+time(18));
    end
end

end