clc;clear;close all;
data1 = readtable("emails.csv");
data2 = readtable("Logout Times.csv");
sYear = input("Enter Year: ");

%Calculate date and time from epoch time
login_epochs = data1{:,2};
login_dates = datetime(login_epochs, 'ConvertFrom', 'epochtime');
login_dates = login_dates - hours(6); %timezone adjustment

logout_epochs = data2{:,2};
logout_dates = datetime(logout_epochs, 'ConvertFrom', 'epochtime');
logout_dates = logout_dates - hours(6); %timezone adjustment
selected_dates = [];
%Choice
choice = input("Select\n1:sort by month\n2:sort by dates\n");
switch choice
    case 1
        sMonth1 = input("Enter month (ex. 3 for March):");
        index2 = 1
        for i=1:length(login_dates)
            if month(login_dates(i)) == sMonth1
                if year(login_dates(i)) == sYear
                    selected_dates{index2,1} = data1{i,1};
                    selected_dates{index2,2} = login_dates(i);
                    index2 = index2 + 1;
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

time = searchForLogoutv2(selected_dates,data2,logout_dates);
sndCol = [selected_dates{:,2}];
first_date = string(month(min(sndCol),"name"))+"-"+string(day(min(sndCol)));
last_date = string(month(max(sndCol),"name"))+"-"+string(day(max(sndCol)));


times = [12,1:11];
for i=[1:12]
    time_string(i) = num2str(times(i))+":00AM";
    time_string(12+i) = num2str(times(i))+":00PM";
end
time_string_new = categorical(time_string);
area(0:24*60-1,time);
time_string_new = reordercats(time_string_new, time_string);

bar_title = sprintf("# in center from %s to %s", first_date, last_date);
title(bar_title);
ylabel("Logins")
xlabel("time")
xticks(0:60:24*60)
xticklabels(time_string_new)
disp("Year:"+sYear)
axis padded
grid on
%disp("Total logins:"+sum(t))