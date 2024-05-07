from django.http import JsonResponse
from rest_framework.authentication import TokenAuthentication
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.status import HTTP_400_BAD_REQUEST
from rest_framework.parsers import JSONParser
from rest_framework.request import Request
from rest_framework.decorators import api_view, authentication_classes
from django.db import transaction
from django.http.response import HttpResponseBadRequest
from user_api import serializer
from foretag.models import Ad, Store
from user_api.models import MobileUser, Order, Reservation
from user_api.serializer import AdSerializer, OrderSerializer, StoreSerialiser
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

        if not username: 
            return JsonResponse(
                {
                    "reason": "Tomt fält användare",
                    "context": "Användarnamn måste anges",
                },
                status=HTTP_400_BAD_REQUEST,
            ) 
        
        if not email: 
            return JsonResponse(
                {
                    "reason": "Tomt fält email",
                    "context": "Email måste anges",
                },
                status=HTTP_400_BAD_REQUEST,
            ) 
        # TODO We should probobly filter allowed passwords and usernames
        if User.objects.filter(username=username).exists():
            return JsonResponse(
                {
                    "reason": "Användare finns redan",
                    "context": "Användarnamnet används redan, vänligen välj ett nytt",
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


def get_cart(user: MobileUser):
    current_cart = Reservation.objects.filter(
        claimer=user,
        orderer=None,
    )

    return current_cart


def serialize_cart(current_cart):
    ads = []
    amount_in_cart = []
    for ad_id in current_cart.values_list("ad", flat=True).distinct():
        ad = Ad.objects.get(pk=ad_id)
        ads.append(AdSerializer(ad).data)

        claimed = current_cart.filter(ad=ad).aggregate(
            amount_in_cart=Sum("amount_claimed")
        )["amount_in_cart"]
        amount_in_cart.append(claimed)  # type: ignore
    data = {"ads": ads, "amount_in_cart": amount_in_cart}
    return data


class Cart(APIView):
    authentication_classes = [TokenAuthentication]

    @transaction.atomic
    def delete(self, request: Request):
        user = MobileUser.objects.get(credentials=request.user)

        current_cart = get_cart(user)
        current_cart.delete()
        return Response()

    @transaction.atomic
    def patch(self, request: Request):
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

        resevations_of_ad = get_cart(user).filter(ad=ad)

        amount_in_cart = resevations_of_ad.aggregate(sum=Sum("available", default=0))[
            "sum"
        ]

        if amount_in_cart < amount:
            return json_error(
                {
                    "reason": "can't remove amount",
                    "context": "There aren't enough available",
                }
            )

        to_remove = []

        for reservation in resevations_of_ad:
            if amount < reservation.amount_claimed:
                reservation.amount_claimed -= amount
                reservation.save(force_update=True)
                break

            else:
                to_remove.append(reservation)
                amount -= reservation.amount_claimed

        for to_remove in to_remove:
            to_remove.delete()

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

        current_cart = get_cart(user)

        data = serialize_cart(current_cart)
        return JsonResponse(data=data)


def serialize_order(order):
    items = serialize_cart(Reservation.objects.filter(orderer=order))
    serialized_order = OrderSerializer(order, context={"items": items}).data
    return serialized_order


@api_view(["POST"])
@authentication_classes([TokenAuthentication])
def checkout(request: Request):
    user = MobileUser.objects.get(credentials=request.user)
    cart = get_cart(user)
    if not cart.exists():
        return json_error(
            {"reason": "empty cart", "context": "can't checkout empty cart"}
        )

    order = Order()
    order.save()
    cart.update(orderer=order)

    return Response(serialize_order(order))


@api_view(["GET"])
@authentication_classes([TokenAuthentication])
def orders(request: Request, order_number: int | None = None):
    user = MobileUser.objects.get(credentials=request.user)
    users_orders = (
        Order.objects.filter(reservation__claimer=user).order_by("pk").distinct()
    )

    if order_number is None:
        serialized = []
        for order in users_orders:
            serialized.append(serialize_order(order))

        return Response(serialized)

    try:
        order = users_orders.get(pk=order_number)
    except Order.DoesNotExist:
        return json_error(
            {"reason": "can't get order", "context": "Order does not exist"}
        )

    return Response(serialize_order(order))
