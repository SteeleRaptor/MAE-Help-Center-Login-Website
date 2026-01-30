from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, PasswordField
from wtforms.fields.simple import HiddenField


class SignInForm(FlaskForm):
    email = StringField(name='email', label= "Username:", render_kw={"placeholder": "UCCS email", "autofocus": True})
    signIn = SubmitField('Sign In')
    signOut = SubmitField(name='Sign Out', id="signout")
    altSignOut = HiddenField('altSignOUT', id="altSignOut")
    seeStats = SubmitField('See Stats')

class FeedBackForm(FlaskForm):
    text = StringField(name = 'feedback')
    submit = SubmitField("Submit")

class SignUpForm(FlaskForm):
    email = StringField(name='email', label= "Email:", render_kw={"placeholder": "UCCS email", "autofocus": True})
    fName = StringField(name='fName', label= "First name:")
    lName = StringField(name='lName', label= "Last name:")
    signUp = SubmitField('Sign Up')

class AdminForm(FlaskForm):
    adminpass = PasswordField(name='adminpass')
    cont = SubmitField('Continue')

class VerifyForm(FlaskForm):
    cont = SubmitField('Continue')





