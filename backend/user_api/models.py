from django.db import models
from foretag.models import Store
from django.contrib.auth.models import User


class MobileUser(models.Model):
    favorite_stores = models.ManyToManyField(Store, blank=True)
    credentials = models.OneToOneField(User, on_delete=models.CASCADE)

    @classmethod
    def create(cls, username, password, email):

        credentials = User.objects.create_user(
            username=username, password=password, email=email
        )

        user = MobileUser(credentials=credentials)
        user.save()
        return user

    class Meta:
        verbose_name = "MobileUser"
        verbose_name_plural = "MobileUsers"
