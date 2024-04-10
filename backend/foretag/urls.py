from . import views
from django.urls import path

urlpatterns = [
    path("", views.company_login, name="company_login"),
    path("home/<slug:name>/", views.company_home_page, name="company_home_page"),
    path("createad/<slug:name>/", views.create_ad, name="create_ad"),
    path("register/", views.company_register, name="company_register")
]
