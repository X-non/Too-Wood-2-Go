from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpRequest, Http404
from .models import Store, Ad
from .forms import StoreForm, AdForm
from django.template.defaultfilters import slugify
from django.urls import reverse


def company_login(request: HttpRequest):
    if request.method == "POST":
        name = request.POST["name"]
        try:
            store = Store.objects.get(name=name)
            return redirect("company_home_page", name=store.slug_name)
        except Store.DoesNotExist:
            return render(request, "foretag/login_page.html", {"nameExists": False})
    return render(request, "foretag/login_page.html", {"nameExists": True})


def company_home_page(request: HttpRequest, name: str):
    # TODO check if name exists and check if logged in
    store = get_object_or_404(Store, slug_name=name)
    context = applyFilters(request, store)
    return render(request, "foretag/home_page.html", context)


def applyFilters(request: HttpRequest, store):
    ads = Ad.objects.all()
    ads = ads.filter(store=store.pk)
    name_contains_queury = request.GET.get("search")
    print(name_contains_queury)
    if name_contains_queury != "" and name_contains_queury is not None:
        ads = ads.filter(title__icontains=name_contains_queury)

    context = {"queryset": ads, "store": store, "search": name_contains_queury}
    return context


def company_register(request: HttpRequest):
    if request.method == "POST":
        form = StoreForm(request.POST)
        print(form)
        if form.is_valid():
            form.save()
            return redirect("company_login")
        else:
            return render(
                request, "foretag/company_registration.html", {"form": form}
            )  # TODO {'form': form, 'had_error': True}
    else:
        form = StoreForm()
    return render(
        request, "foretag/company_registration.html", {"form": form}
    )  # TODO {'form': form, 'had_error': False}


def create_ad(request: HttpRequest, name: str):
    if request.method == "POST":
        form = AdForm(request.POST)
        if form.is_valid():
            form.save()
            url = reverse("company_home_page", kwargs={"name": name})
            return redirect(url)
        else:
            return render(request, "foretag/create_ad.html", {"form": form})
    else:
        form = AdForm()
        return render(request, "foretag/create_ad.html", {"form": form})
