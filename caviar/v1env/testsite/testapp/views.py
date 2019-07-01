from django.shortcuts import render, redirect
from django.urls import reverse
from django.http import HttpResponseRedirect, HttpResponse, Http404

from django.db.models import Q
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

from django.core import serializers
import json

from django.contrib import messages
from django.conf import settings

from django.views.decorators.csrf import csrf_exempt

from .models import Profile, Message
from .forms import LoginForm, SignupForm, ProfileForm


def home(request):
    if request.user.is_authenticated:
        return HttpResponse("Hello " + request.user.username)
    return redirect(reverse('login'))


def login_action(request):
    context = {}

    if request.method == 'GET':
        context['form'] = LoginForm()
        return render(request, 'testapp/login.html', context)

    form = LoginForm(request.POST)
    context['form'] = form

    if not form.is_valid():
        messages.error(request, "Username or password is not correct")
        return render(request, 'testapp/login.html', context)

    new_user = authenticate(username=form.cleaned_data['username'],
                            password=form.cleaned_data['password'])

    login(request, new_user)

    # redirect to a view function or pattern name
    return redirect(reverse('home'))


def logout_action(request):
    logout(request)
    return redirect(reverse('login'))


def signup_action(request):
    context = {}

    if request.method == 'GET':
        context['form'] = SignupForm()
        return render(request, 'testapp/signup.html', context)

    form = SignupForm(request.POST)
    context['form'] = form

    if not form.is_valid():
        return render(request, 'testapp/signup.html', context)

    new_user = User.objects.create_user(username=form.cleaned_data['username'],
                                        password=form.cleaned_data['password'],
                                        email=form.cleaned_data['email'],
                                        first_name=form.cleaned_data['first_name'],
                                        last_name=form.cleaned_data['last_name'])
    new_user.save()
    # also create a new profile for the newly registered user
    Profile.objects.create(user=new_user)

    new_user = authenticate(username=form.cleaned_data['username'],
                            password=form.cleaned_data['password'])
    login(request, new_user)

    return redirect(reverse('home'))


# single/multiple message(s) save?
# [How to disable Django's CSRF validation?](https://stackoverflow.com/questions/16458166/how-to-disable-djangos-csrf-validation)
@csrf_exempt
def message_save(request):
    if request.method == 'POST':
        msg_content = request.POST['msg_content']
        sender_id = request.POST['sender_id']
        receiver_id = request.POST['receiver_id']
        # created_at = request.POST['created_at']

        # can we store user id's instead of user references?
        sender = User.objects.get(id=sender_id)
        receiver = User.objects.get(id=receiver_id)
        # new_msg = Message.objects.create(msg_content=msg_content, sender=sender, receiver=receiver, created_at=created_at)
        new_msg = Message.objects.create(
            msg_content=msg_content, sender=sender, receiver=receiver)
        new_msg.save()

        # [HTTP Status Codes](https://www.restapitutorial.com/httpstatuscodes.html)
        return HttpResponse(status=201)


def message_load(request):
    # [Django - limiting query results](https://stackoverflow.com/questions/6574003/django-limiting-query-results)
    MESSAGE_LIMIT = 50
    if request.method == 'GET':
        sender_id = request.GET['sender_id']
        receiver_id = request.GET['receiver_id']

        sender = User.objects.get(id=sender_id)
        receiver = User.objects.get(id=receiver_id)

        sent_messages = Message.objects.filter(sender=sender)\
            & Message.objects.filter(receiver=receiver)
        received_messages = Message.objects.filter(sender=receiver)\
            & Message.objects.filter(receiver=sender)
        messages = (sent_messages | received_messages).order_by(
            'created_at')[:MESSAGE_LIMIT]

        json_res = serializers.serialize('json', messages)

        return HttpResponse(json_res, content_type='application/json')


def error(request):
    return HttpResponse("Sorry, but this page isn't available...")
