from django.shortcuts import render, redirect
from django.http import HttpRequest, Http404
from .models import Store


# Create your views here.
def company_login(request: HttpRequest):
    if request.method == "POST":
        name = request.POST["name"]
        try:
            store = Store.objects.get(name=name)
            return redirect("company_home_page", name=store.slug_name)
        except Store.DoesNotExist:
            pass

    return render(request, "foretag/login_page.html")


def company_home_page(request: HttpRequest, name: str):
    # TODO check if name exists and check if logged in

    return render(request, "foretag/home_page.html", {"name": name})
