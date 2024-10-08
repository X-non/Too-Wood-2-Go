from django.urls import path
from . import views

urlpatterns = [
    # path("login_store/", views.login_store, name="login_store"),
    # path("logout_store/", views.logout_store, name="logout_store"),
    # path("register_store/", views.register_store, name="register_store"),
    # path("home/", views.home, name="home"),
    path("ads/", views.ads, name="ads"),
    path(
        "product/<int:product_id>/delete/", views.delete_product, name="delete_product"
    ),
    path("product/<int:id>/update/", views.update_product, name="update_product"),
    path("main/", views.main, name="main"),
    path("orders/", views.orders, name="orders"),
    path("login/", views.store_login, name="login"),
    path("logout/", views.store_logout, name="logout"),
]
