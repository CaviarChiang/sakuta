from django.urls import path
from django.conf.urls import url

from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('login', views.login_action, name="login"),
    path('logout', views.logout_action, name="logout"),
    path('signup', views.signup_action, name="signup"),
    path('message-save', views.message_save, name='message-save'),
    path('message-load', views.message_load, name='message-load'),
]
