from django import forms
from .models import Store, Ad
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User


class StoreForm(forms.ModelForm):
    class Meta:
        model = Store
        fields = ["name", "address", "postal_code", "postal_city"]


class AdForm(forms.ModelForm):
    class Meta:
        model = Ad
        fields = [
            "title",
            "desc",
            "store",
            "category",
            "available",
            "old_price",
            "new_price",
        ]


class RegisterStoreForm(UserCreationForm):
    # We're inheriting UserCreationForm and adding
    # additional fields to it
    email = forms.EmailField()
    adress = forms.CharField(max_length=255)
    # TODO: make postage_number be limited to 5 numbers
    postage_number = forms.CharField(max_length=5)
    city = forms.CharField(max_length=255)

    class Meta:
        model = User
        fields = [
            "username",
            "email",
            "adress",
            "postage_number",
            "city",
            "password1",
            "password2",
        ]
