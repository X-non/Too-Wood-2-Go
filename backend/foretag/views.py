from calendar import c
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.forms import UserCreationForm
from django.http import HttpRequest, HttpResponse

from user_api.models import Reservation
from .forms import RegisterStoreForm
from .forms import AdForm
from .decorators import login_page
from django.contrib.auth.models import Group
from foretag.models import Ad, Store
from django.contrib.auth.decorators import login_required


# @login_page("home")
# def login_store(request):
#     if request.method == "POST":
#         store_name = request.POST["username"]
#         password = request.POST["password"]
#         store = authenticate(request, username=store_name, password=password)
#         if store is not None:
#             login(request, store)
#             return redirect("/foretag/home")
#         # if login is successful, log in the user and redirect them
#         # to 127.0.0.1:8000/home (which doesn't exist yet)
#         else:
#             messages.success(request, ("There was an error logging in"))
#             return redirect("login_store")
#         # If login is not successful, reload the site
#     else:
#         return render(request, "authenticate/login_store.html", {})
#     # if a login hasn't been made, display the site


# def logout_store(request):
#     logout(request)
#     messages.success(request, "You were logged out")
#     return redirect("/foretag/home")


# # If a logout request occurs, log out the user and redirect
# # them to home


# def home(response):
#     return render(response, "home.html", {"name": "test"})


# def register_store(request):
#     if request.method == "POST":
#         form = RegisterStoreForm(request.POST)
#         if form.is_valid():
#             company = form.save()
#             group = Group.objects.get(name="Company")
#             company.groups.add(group)
#             return redirect("login_store")
#     else:
#         form = RegisterStoreForm()
#     return render(request, "authenticate/register_store.html", {"form": form})


@login_page("main")
def store_login(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect("main")
        else:
            return render(
                request,
                "corporate/login.html",
                {"error": "Felaktigt användarnamn eller lösenord"},
            )
    else:
        return render(request, "corporate/login.html")


@login_required
def ads(request: HttpRequest):
    query = request.GET.get("q")
    current_store = Store.objects.get(credentials=request.user)
    if query:
        myData = Ad.objects.filter(title__icontains=query, store=current_store)
    else:
        myData = Ad.objects.filter(store=current_store)
    if request.method == "POST":
        form = AdForm(request.POST)
        if form.is_valid():
            form.save()
    else:
        form = AdForm()
    context = {
        "adsData": myData,
        "form": form,
    }
    return render(request, "corporate/product.html", context)


def update_product(request, id):
    product = Ad.objects.get(id=id)
    if request.method == "POST":
        form = AdForm(request.POST, instance=product)
        if form.is_valid():
            form.save()
    else:
        form = AdForm(instance=product)
    return redirect("ads")


def get_id(id):
    return Ad.objects.filter(id=id)


def delete_product(request, product_id):
    product = get_object_or_404(Ad, pk=product_id)
    if request.method == "POST":
        product.delete()
    return redirect("ads")


@login_required
def main(request: HttpRequest):
    request.method
    current_store = Store.objects.get(credentials__exact=request.user).name
    context = {
        "storeData": current_store,
    }
    return render(request, "corporate/main.html", context)


@login_required
def orders(request: HttpRequest):
    current_store = Store.objects.get(credentials__exact=request.user)
    reservations = Reservation.objects.exclude(orderer=None).filter(
        ad__store=current_store
    )
    context = {
        "reservations": reservations,
    }
    return render(request, "corporate/reservation.html", context)


def store_logout(request):
    logout(request)
    return redirect("login")
