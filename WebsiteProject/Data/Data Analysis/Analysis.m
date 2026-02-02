clear;clc;close all
data = readtable("emails.csv");
sYear = input("Enter Year: ");

%Calculate date and time from epoch time
login_epochs = data{:,2};
login_dates = datetime(login_epochs, 'ConvertFrom', 'epochtime');
login_dates = login_dates - hours(6); %timezone adjustment
selected_dates = []

%Choice
choice = input("Select\n1:sort by month\n2:sort by dates\n");
switch choice
    case 1
        sMonth1 = input("Enter month (ex. 3 for March):");
        for i=1:length(login_dates)
            if month(login_dates(i)) == sMonth1
                if year(login_dates(i)) == sYear
                    selected_dates = [selected_dates, login_dates(i)];
                end
            end
        end
        sMonth2 = sMonth1;
    case 2
        sMonth1 = input("Enter 1st month:");
        sDay1 = input("Enter 1st day:");
        sMonth2 = input("Enter 2nd month:");
        sDay2 = input("Enter 2nd day:");
        date1 = datetime(sYear,sMonth1,sDay1);
        disp(date1)
        date2 = datetime(sYear,sMonth2,sDay2);
        disp(date2)
        for i=1:length(login_dates)
            if login_dates(i) >= date1 && login_dates(i) <= date2
                    selected_dates = [selected_dates, login_dates(i)];
            end
        end
end
first_date = string(month(min(selected_dates),"name"))+"-"+string(day(min(selected_dates)));
last_date = string(month(max(selected_dates),"name"))+"-"+string(day(max(selected_dates)));
login_hours = hour(selected_dates);
t = zeros(1,24);

for i=1:length(login_hours)
    t(login_hours(i)) = t(login_hours(i))+1;
end

times = [12,1:11];
for i=[1:12]
    time_string(i) = num2str(times(i))+":00AM";
    time_string(12+i) = num2str(times(i))+":00PM";
end
time_string_new = categorical(time_string);
bar(time_string,t,"stacked");
time_string_new = reordercats(time_string_new, time_string);

bar_title = sprintf("Login Times from %s to %s", first_date, last_date);
title(bar_title);
ylabel("Logins")
xlabel("time")
disp("Year:"+sYear)
disp("Total logins:"+sum(t))