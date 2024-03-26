from django import forms
from .models import Store, Ad

class StoreForm(forms.ModelForm):
    class Meta:
        model = Store
        fields = ['name', 'address', 'postal_code', 'postal_city']

class AdForm(forms.ModelForm):
    class Meta:
        model = Ad
        fields = ['title', 'desc', 'store', 
        'available', 'old_price', 'new_price']