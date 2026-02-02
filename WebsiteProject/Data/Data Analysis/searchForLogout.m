function hours = searchForLogout(selected_dates,data2,logout_dates)
hours = zeros(24,1)
for i = 1:height(selected_dates)
    found = false
    for j = 1:height(data2)
        if string(data2{j,1}) == string(selected_dates{i,1})
            if day(logout_dates(j))==day(selected_dates{i,2}) && logout_dates(j)>selected_dates{i,2}
                hours = hours + counthours(selected_dates{i,2},logout_dates(j))
                found = true
                break;
            end
        end
    end
    if ~found
        hours = hours + counthours(selected_dates{i,2},day(selected_dates{i,2})+hours(18))
    end
end

end