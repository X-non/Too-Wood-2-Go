from django.db import models

from foretag.models import Store
from django.contrib.auth.models import User


class MobileUser(models.Model):
    favorite_stores = models.ManyToManyField(Store)
    credentials = models.OneToOneField(User, on_delete=models.CASCADE)

    class Meta:
        verbose_name = "MobileUser"
        verbose_name_plural = "MobileUsers"
