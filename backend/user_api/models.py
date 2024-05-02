from django.db import models
from foretag.models import Store, Ad
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


class Reservation(models.Model):
    ad = models.ForeignKey(Ad, on_delete=models.CASCADE)
    claimer = models.ForeignKey(MobileUser, on_delete=models.CASCADE)
    amount_claimed = models.PositiveSmallIntegerField()
    claim_time = models.DateTimeField(auto_now_add=True)
    paid_for = models.BooleanField(default=False)  # Dictates whether in cart or not
