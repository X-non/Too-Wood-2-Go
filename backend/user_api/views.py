from email.policy import default
import select
from django.http import JsonResponse
from rest_framework.authentication import TokenAuthentication
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.status import HTTP_400_BAD_REQUEST
from rest_framework.parsers import JSONParser
from rest_framework.request import Request
from django.db import transaction
from django.http.response import HttpResponseBadRequest
from user_api import serializer
from foretag.models import Ad, Store
from user_api.models import MobileUser, Reservation
from user_api.serializer import AdSerializer, StoreSerialiser
from django.db.models import Sum
from django.contrib.auth.models import User


def json_error(data) -> JsonResponse:
    return JsonResponse(data, status=HTTP_400_BAD_REQUEST)


class Register(APIView):
    authentication_classes = []
    permission_classes = []

    queryset = MobileUser.objects.all()

    def post(self, request: Request):

        parsed = request.data
        if not isinstance(request.data, dict):
            return JsonResponse(
                {"reason": "not json", "context": "request must be JSON"},
                status=HTTP_400_BAD_REQUEST,
            )
        try:
            username = parsed["username"]  # type: ignore
            password = parsed["password"]  # type: ignore
            email = parsed["email"]  # type: ignore
        except KeyError as e:
            return JsonResponse(
                {
                    "reason": "missing fields",
                    "context": "JSON must contain all 'username', 'password' and 'email'",
                },
                status=HTTP_400_BAD_REQUEST,
            )
        # TODO We should probobly filter allowed passwords and usernames
        if User.objects.filter(username=username).exists():
            return JsonResponse(
                {
                    "reason": "username already exists",
                    "context": "The username is already in use",
                },
                status=HTTP_400_BAD_REQUEST,
            )

        user = MobileUser.create(username=username, password=password, email=email)
        token, created = Token.objects.get_or_create(user=user.credentials)

        return Response({"token": token.key})


class Stores(APIView):
    serializer = StoreSerialiser
    queryset = Store.objects.all()
    authentication_classes = [TokenAuthentication]

    def get(self, request: Request):
        data = self.serializer(
            self.queryset.all(),
            many=True,
            context={
                "request": request,
            },
        ).data

        return Response(data)


class Favorites(APIView):
    serializer = StoreSerialiser
    queryset = MobileUser.objects.all()
    authentication_classes = [TokenAuthentication]

    def get(self, request: Request):
        favorites = MobileUser.objects.get(credentials=request.user).favorite_stores
        serializer = self.serializer(favorites, many=True, context={"request": request})

        return Response(serializer.data)

    def put(self, request: Request):
        if not isinstance(request.data, dict):
            return JsonResponse(
                data={"reason": "not json", "context": "request must be json"},
                status=HTTP_400_BAD_REQUEST,
            )
        data: dict = request.data

        try:
            store_id = data["store_id"]
            should_become_favorite = data["set_favorite"]
        except KeyError:
            return JsonResponse(
                data={
                    "reason": "missing field",
                    "context": "both 'store_id' and 'set_favorite' must be provided",
                },
                status=HTTP_400_BAD_REQUEST,
            )

        if not isinstance(should_become_favorite, bool):
            return JsonResponse(
                data={
                    "reason": "should be bool",
                    "context": "set_favorite must be a bool",
                },
            )
        try:
            store = Store.objects.get(slug_name=store_id)
        except:
            return JsonResponse(
                data={"reason": "unknown store", "context": "no store with name"},
                status=HTTP_400_BAD_REQUEST,
            )

        user = MobileUser.objects.get(credentials=request.user)
        if should_become_favorite:
            user.favorite_stores.add(store)
        else:
            user.favorite_stores.remove(store)

        return Response()


class Ads(APIView):
    serializer = AdSerializer
    queryset = Ad.objects.all()
    authentication_classes = [TokenAuthentication]

    def get(self, request, store_id):
        if not Store.objects.filter(slug_name=store_id):
            return JsonResponse(
                data={"reason": "unknown store", "context": "no store with name"},
                status=HTTP_400_BAD_REQUEST,
            )

        queryset = self.queryset.filter(store__slug_name=store_id)
        serializer = self.serializer(queryset, many=True)

        return Response(serializer.data)


class Cart(APIView):
    authentication_classes = [TokenAuthentication]

    @transaction.atomic
    def delete(self, request: Request):
        user = MobileUser.objects.get(credentials=request.user)

        current_cart = Reservation.objects.filter(
            claimer=user,
            paid_for=False,
        )
        current_cart.delete()
        return Response()

    @transaction.atomic
    def post(self, request: Request):
        user = MobileUser.objects.get(credentials=request.user)

        if not isinstance(request.data, dict):
            return json_error({"reason": "not json", "context": "request must be json"})

        data: dict = request.data
        try:
            ad_id = data["ad_id"]
            amount = data["amount"]
        except KeyError:
            return json_error(
                {
                    "reason": "missing fields",
                    "context": "both 'ad_id' and 'amount' is needed",
                }
            )
        if not isinstance(ad_id, int) or not isinstance(amount, int):
            return json_error(
                {
                    "reason": "should be int",
                    "context": "both 'ad_id' and 'amount' should be ints",
                }
            )
        try:
            ad = Ad.objects.get(id=ad_id)
        except Ad.DoesNotExist:
            return json_error(
                {
                    "reason": "unknown id",
                    "context": "The ad does not exist",
                }
            )

        reserved_amount = Reservation.objects.filter(ad=ad).aggregate(
            sum=Sum("amount_claimed", default=0)
        )["sum"]

        unreserved_amount = ad.available - reserved_amount

        if unreserved_amount < amount or amount < 1:
            return json_error(
                {
                    "reason": "can't reserve amount",
                    "context": "There aren't enough available",
                }
            )

        Reservation.objects.create(ad=ad, claimer=user, amount_claimed=amount)

        return Response()

    def get(self, request):
        user = MobileUser.objects.get(credentials=request.user)

        current_cart = Reservation.objects.filter(
            claimer=user,
            paid_for=False,
        )
        ads = []
        amount_in_cart = []
        for ad_id in current_cart.values_list("ad", flat=True).distinct():
            ad = Ad.objects.get(pk=ad_id)
            ads.append(AdSerializer(ad).data)

            claimed = current_cart.filter(ad=ad).aggregate(
                amount_in_cart=Sum("amount_claimed")
            )["amount_in_cart"]
            amount_in_cart.append(claimed)  # type: ignore

        return JsonResponse(data={"ads": ads, "amount_in_cart": amount_in_cart})
