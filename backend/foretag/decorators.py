from django.http import HttpResponse
from django.shortcuts import redirect


def login_page(redirect_to: str):
    """
    Redirects to *page_redirect* if user is logged in
    """

    def inner_decorator(view_func):
        def wrapper_func(request, *args, **kwargs):
            if request.user.is_authenticated:
                return redirect(redirect_to)
            else:
                return view_func(request, *args, **kwargs)

        return wrapper_func

    return inner_decorator
