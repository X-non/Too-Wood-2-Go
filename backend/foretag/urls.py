from django.urls import path
from . import views

urlpatterns = [
    path('login_store/', views.login_store, name="login_store"),
    path('logout_store/', views.logout_store, name="logout_store"),
    path('register_store/', views.register_store, name="register_store"),
    path('home/', views.home, name="home"),
    path("", views.company_login, name="company_login"),
    path("home/<slug:name>/", views.company_home_page, name="company_home_page"),
    path("createad/<slug:name>/", views.create_ad, name="create_ad"),
    path("register/", views.company_register, name="company_register"),
]
