from rest_framework.authtoken.views import obtain_auth_token
from rest_framework.routers import DefaultRouter
from django.urls import path, include
from django.contrib.auth.models import User

from user_api.views import Stores

router = DefaultRouter()
urlpatterns = [
    path("stores/", Stores.as_view()),
    path("login/", obtain_auth_token),
]
