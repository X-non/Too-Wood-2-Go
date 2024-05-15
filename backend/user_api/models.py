from django.db.models.aggregates import Sum
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

    def __str__(self) -> str:
        return self.credentials.username


class Order(models.Model):
    time_ordered = models.DateTimeField(auto_now_add=True)


class Reservation(models.Model):
    ad = models.ForeignKey(Ad, on_delete=models.CASCADE)
    claimer = models.ForeignKey(MobileUser, on_delete=models.CASCADE)
    amount_claimed = models.PositiveSmallIntegerField()
    claim_time = models.DateTimeField(auto_now_add=True)
    orderer = models.ForeignKey(
        Order, default=None, null=True, on_delete=models.CASCADE
    )  # Dictates whether in cart (null) or bought (non null and pointing to an order)


def reserved_item_from_ad(ad: Ad):
    return Reservation.objects.filter(ad=ad).aggregate(
        sum=Sum("amount_claimed", default=0)
    )["sum"]


def unreserved_item_from_ad(ad: Ad):
    return ad.available - reserved_item_from_ad(ad)
