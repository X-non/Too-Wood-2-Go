from django.urls import path
from . import views

urlpatterns = [
    path('login_store/', views.login_store, name="login_store"),
    path('logout_store/', views.logout_store, name="logout_store"),
    path('register_store/', views.register_store, name="register_store"),
]