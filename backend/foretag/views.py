
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.forms import UserCreationForm
from .forms import RegisterStoreForm
from .decorators import unauthenticated_user
from django.contrib.auth.models import Group
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpRequest, Http404
from .models import Store, Ad
from .forms import StoreForm, AdForm
from django.template.defaultfilters import slugify
from django.urls import reverse

@unauthenticated_user
def login_store(request):
    if request.method == "POST":
        store_name = request.POST["username"]
        password = request.POST["password"]
        store = authenticate(request, username=store_name, password=password)
        if store is not None:
            login(request, store)
            return redirect("/foretag/home")
        #if login is successful, log in the user and redirect them
        #to 127.0.0.1:8000/home (which doesn't exist yet)
        else:
            messages.success(request, ("There was an error logging in"))
            return redirect("login_store")
        #If login is not successful, reload the site
    else:
        return render(request, 'authenticate/login_store.html', {})
    #if a login hasn't been made, display the site


def logout_store(request):
    logout(request)
    messages.success(request, ("You were logged out"))
    return redirect('/foretag/home')
#If a logout request occurs, log out the user and redirect
#them to home (which doesn't exist yet)

def register_store_123(request):
    if request.method == "POST":
        form = RegisterStoreForm(request.POST)
        if form.is_valid():
            form.save()
            store_name = form.cleaned_data["username"]
            password = form.cleaned_data["password1"]
            store = authenticate(username=store_name, password=password)
            login(request, store)
            messages.success(request, ("Registration successful"))
            return redirect('/foretag/home')

    else:
       form = RegisterStoreForm()

    return render(request, 'authenticate/register_store.html',
                  {'form':form,})
def home(response):
    return render(response, "home.html", {"name":"test"})

def register_store(request):
    if request.method == 'POST':
        form = RegisterStoreForm(request.POST)
        if form.is_valid():
            company = form.save()
            group = Group.objects.get(name='Company')
            company.groups.add(group)
            return redirect('login_store')
    else:
        form = RegisterStoreForm()
    return render(request, 'authenticate/register_store.html', {'form': form})

def register_user(request):
    if request.method == 'POST':
        form = RegisterStoreForm(request.POST)
        if form.is_valid():
            company = form.save()
            group = Group.objects.get(name='Customer')
            company.groups.add(group)
            return redirect('login_store')
    else:
        form = RegisterStoreForm()
    return render(request, 'authenticate/register_store.html', {'form': form})

def company_login(request: HttpRequest):
    if request.method == "POST":
        name = request.POST["name"]
        try:
            store = Store.objects.get(name=name)
            return redirect("company_home_page", name=store.slug_name)
        except Store.DoesNotExist:
            return render(request, "foretag/login_page.html", {'nameExists': False})
    return render(request, "foretag/login_page.html", {'nameExists': True})


def company_home_page(request: HttpRequest, name: str):
    # TODO check if name exists and check if logged in
    store = get_object_or_404(Store, slug_name=name)
    context = applyFilters(request, store)
    return render(request, "foretag/home_page.html", context)

def applyFilters(request: HttpRequest, store):
    ads = Ad.objects.all()
    ads = ads.filter(store=store.pk)
    name_contains_queury = request.GET.get('search')
    print(name_contains_queury)
    if name_contains_queury != '' and name_contains_queury is not None:
        ads = ads.filter(title__icontains=name_contains_queury)

    context = {
        'queryset': ads,
        'store': store,
        'search': name_contains_queury
    }
    return context
    


def company_register(request: HttpRequest):
    if request.method == 'POST':
        form = StoreForm(request.POST)
        print(form)
        if form.is_valid():
            form.save()
            return redirect('company_login')
        else:
            return render(request, 'foretag/company_registration.html', {'form': form}) #TODO {'form': form, 'had_error': True}
    else:
        form = StoreForm()
    return render(request, "foretag/company_registration.html", {'form': form}) #TODO {'form': form, 'had_error': False}

def create_ad(request: HttpRequest, name: str):
    if request.method == 'POST':
        form = AdForm(request.POST)
        if form.is_valid():
            form.save()  
            url = reverse('company_home_page', kwargs={'name': name})
            return redirect(url)
        else:
            return render(request, 'foretag/create_ad.html', {'form': form})
    else:
        form = AdForm()
        return render(request, 'foretag/create_ad.html', {'form': form})

