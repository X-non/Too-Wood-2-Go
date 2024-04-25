from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.forms import UserCreationForm
from .forms import RegisterStoreForm
from .decorators import login_page
from django.contrib.auth.models import Group


@login_page("home")
def login_store(request):
    if request.method == "POST":
        store_name = request.POST["username"]
        password = request.POST["password"]
        store = authenticate(request, username=store_name, password=password)
        if store is not None:
            login(request, store)
            return redirect("/foretag/home")
        # if login is successful, log in the user and redirect them
        # to 127.0.0.1:8000/home (which doesn't exist yet)
        else:
            messages.success(request, ("There was an error logging in"))
            return redirect("login_store")
        # If login is not successful, reload the site
    else:
        return render(request, "authenticate/login_store.html", {})
    # if a login hasn't been made, display the site


def logout_store(request):
    logout(request)
    messages.success(request, "You were logged out")
    return redirect("/foretag/home")


# If a logout request occurs, log out the user and redirect
# them to home


def home(response):
    return render(response, "home.html", {"name": "test"})


def register_store(request):
    if request.method == "POST":
        form = RegisterStoreForm(request.POST)
        if form.is_valid():
            company = form.save()
            group = Group.objects.get(name="Company")
            company.groups.add(group)
            return redirect("login_store")
    else:
        form = RegisterStoreForm()
    return render(request, "authenticate/register_store.html", {"form": form})
