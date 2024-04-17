from django.db import models

# Create your models here.


class Store(models.Model):
    name = models.CharField(max_length=50, unique=True)
    slug_name = models.SlugField(max_length=50)
    credentials = models.CharField(
        max_length=50, default="Not connected"
    )  # TODO - Implement refrence to login

    address = models.CharField(max_length=100)
    postal_code = models.CharField(max_length=10)
    postal_city = models.CharField(max_length=30)


class Ad(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=250)
    store = models.ForeignKey(Store, on_delete=models.CASCADE)
    available = models.PositiveSmallIntegerField(default=1)

    published = models.DateTimeField(auto_now_add=True)
    until = models.DateTimeField(auto_now_add=True)  # TODO - Change to some real value

    old_price = models.PositiveIntegerField(default=0)
    new_price = models.PositiveIntegerField(default=0)


class Reservation(models.Model):
    ad = models.ForeignKey(Ad, on_delete=models.CASCADE)
    claimer = models.CharField(
        max_length=100, default="not claimed yet!"
    )  # TODO - Foreign key till Users
    claim_time = models.DateTimeField(auto_now_add=True)
    paid_for = models.BooleanField(default=False)  # Dictates whether in cart or not
