function time = counttime(login, logout)
    time1 = hour(login)*60+minute(login);
    time2 = hour(logout)*60+minute(logout);
    fprintf("duration%f\n",time2-time1)
    time = zeros(24*60,1);
    for i=time1:time2
        time(i)=time(i)+1;
    end
end