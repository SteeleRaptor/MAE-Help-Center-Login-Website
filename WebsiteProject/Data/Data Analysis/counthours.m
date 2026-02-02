function hours = counthours(login, logout)
    hour1 = hour(login);
    hour2 = hour(logout);
    fprintf("duration%f",hour2-hour1)
    hours= zeros(24,1);
    for i=hour1:hour2
        hours(i)=hours(i)+1;
    end
end