import os

from django.db import models
from django.contrib.auth.models import User

from django.core.validators import MaxLengthValidator
from django.core.validators import FileExtensionValidator

"""
when we make changes to the model we need to make migrations:
`python manage.py makemigrations`
`python manage.py migrate` apply the changes to the database
`python manage.py migrate --run-syncdb`

db models:
- user
- profile
- message
- chat

References:
[ChoiceField in Django model](https://stackoverflow.com/questions/8077840/choicefield-in-django-model)
[Django: OperationalError No Such Table](https://stackoverflow.com/questions/25771755/django-operationalerror-no-such-table)
[How to create a user to user message system using Django?](https://stackoverflow.com/questions/32687461/how-to-create-a-user-to-user-message-system-using-django)
[How to Model a TimeField in Django?](https://stackoverflow.com/questions/11385607/how-to-model-a-timefield-in-django)
"""


def get_image_path(instance, filename):
    return os.path.join('profile_picture', str(instance.id), filename)


class Profile(models.Model):
    ALLOWED_PICTURE_TYPES = ['jpg', 'jpeg', 'png', 'gif']
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
    )

    # CASCADE: if we delete the user, also delete the profile; but not the other way around
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    gender = models.CharField(blank=True, max_length=1, choices=GENDER_CHOICES)
    bio = models.TextField(blank=True, validators=[MaxLengthValidator(200)])
    profile_picture = models.ImageField(upload_to=get_image_path,
                                        null=True, blank=True,
                                        validators=[FileExtensionValidator(
                                            ALLOWED_PICTURE_TYPES
                                        )])

    def __str__(self):
        return 'Profile(username=' + str(self.user.username) + ')'


class Message(models.Model):
    msg_content = models.TextField(null=False, blank=False)
    sender = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="sender")
    receiver = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="receiver")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return 'from {0} to {1}: {2}'.format(self.sender.username, self.receiver.username, self.msg_content)


# class Chat(models.Model):
