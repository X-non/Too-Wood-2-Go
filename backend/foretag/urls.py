from . import views
from django.urls import path

urlpatterns = [
    path("", views.company_login),
    path("<slug:name>/", views.company_home_page, name="company_home_page"),
]
