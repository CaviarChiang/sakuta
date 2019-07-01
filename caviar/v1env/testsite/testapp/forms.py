from django import forms

from django.contrib.auth.models import User
from django.contrib.auth import authenticate

from .models import Profile


MAX_UPLOAD_SIZE = 25000000


class LoginForm(forms.Form):

    username = forms.CharField(max_length=20)
    password = forms.CharField(max_length=200, widget=forms.PasswordInput())

    def clean(self):
        cleaned_data = super().clean()

        username = cleaned_data.get('username')
        password = cleaned_data.get('password')
        user = authenticate(username=username, password=password)
        if not user:
            raise forms.ValidationError("Invalid username/password")

        return cleaned_data


class SignupForm(forms.Form):

    username = forms.CharField(max_length=20)
    password = forms.CharField(max_length=200,
                               label="Password",
                               widget=forms.PasswordInput())
    confirm = forms.CharField(max_length=200,
                              label="Confirm password",
                              widget=forms.PasswordInput())
    email = forms.CharField(max_length=50, widget=forms.EmailInput())
    first_name = forms.CharField(max_length=20)
    last_name = forms.CharField(max_length=20)

    def clean(self):
        cleaned_data = super(SignupForm, self).clean()

        password = cleaned_data.get('password')
        confirm = cleaned_data.get('confirm')
        if password and confirm and password != confirm:
            raise forms.ValidationError("Password did not match.")

        return cleaned_data

    def clean_username(self):
        username = self.cleaned_data.get("username")
        if User.objects.filter(username__exact=username):
            raise forms.ValidationError("Username is already taken.")

        return username


class ProfileForm(forms.ModelForm):

    class Meta:
        model = Profile
        fields = ('bio', 'gender', 'profile_picture',)

    def clean_profile_picture(self):
        profile_picture = self.cleaned_data['profile_picture']

        if profile_picture and profile_picture.size > MAX_UPLOAD_SIZE:
            raise forms.ValidationError(
                'File too big (max size is {0} bytes'.format(MAX_UPLOAD_SIZE))

        return profile_picture
