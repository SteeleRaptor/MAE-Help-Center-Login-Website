#MAE website v1.2
#Justin Fauson helped with this :)
import time, os, csv, flask
from flask import Flask, render_template, request, redirect
from Forms import SignInForm, FeedBackForm
from flask_wtf.csrf import CSRFProtect
from datetime import datetime

app = Flask(__name__) #general convention for initializing flask app
csrf = CSRFProtect(app)
app.config['SECRET_KEY'] = '21352161'
app.config['WTF_CSRF_SECRET_KEY'] = '21352161'
csrf.init_app(app)
end_time = 0.0
loginCounter = 0
logoutCounter = 0
lastDate = 0

#Sign in page
@app.route('/', methods = ["get" ,"post"])
def signin():
    global end_time, lastDate, loginCounter, logoutCounter
    form = SignInForm()
    message = ""
    todaysDate = round(time.time()/86400-.25,0)
    if todaysDate > lastDate:
        message = "Daily Reset"
        dailyReset(todaysDate)
    print(todaysDate)
    if form.is_submitted():
        result = request.form
        recordTime = time.time()

        if "signIn" in result:
            print(result)
            inputEmail = result.get("email")+"@uccs.edu"
            pathR = os.path.abspath(os.path.dirname(__file__)) + '/Data/Combined Email List.csv'
            valid = False
            with open(pathR, 'r', newline="") as csvfile:
                reader = csv.reader(csvfile)
                for row in reader:
                    if row[0] == inputEmail:
                        valid = True
                        print(valid)
            pathW = os.path.abspath(os.path.dirname(__file__)) + '/Data/emails.csv'
            if valid:
                #write to csv file
                with open(pathW, 'a', newline="") as csvfile:
                    writer = csv.writer(csvfile)
                    writer.writerow([inputEmail, recordTime])
                print([result.get('email'), recordTime]) #display to console for testing
                loginCounter += 1
                # start timer for thank you page
                start_time = time.time()
                end_time = start_time + 1.0
                print(lastDate)
                return redirect('/thankyou')
            else:
                message = "Invalid Email"
        elif "Sign Out" in result:
            path = os.path.abspath(os.path.dirname(__file__)) + '/Data/Logout Times.csv'
            # write to csv file
            with open(path, 'a', newline="") as csvfile:
                writer = csv.writer(csvfile)
                writer.writerow([recordTime])
                print("logged out at",recordTime)  # display to console for testing
            print(result,"signed out")
            logoutCounter +=1
            # start timer for thank you page
            start_time = time.time()
            end_time = start_time + 1.0
            return redirect('/thankyou')

    #renders the webpage and sends the form variable to html
    return render_template('signin.html', form=form, message=message)

#Thank you page
@app.route('/thankyou')
def thankYou():
    #if time is not up then render template
    if time.time()<=end_time:
        return render_template('thankyou.html')
    #javascript reloads the page every second so that the redirect can happen
    return redirect('/')

@app.route('/feedback', methods = ["get" ,"post"])
def feedBack():
    global end_time
    form = FeedBackForm()
    if form.is_submitted():
        result = request.form
        path = os.path.abspath(os.path.dirname(__file__)) + '/Data/feedback.csv'
        # write to csv file
        with open(path, 'a', newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow([result.get('feedback')])
        start_time = time.time()
        end_time = start_time + 1.0
        return redirect('/thankyou')
    return render_template('feedback.html', form=form)

if __name__ == '__main__':
    app.run()



