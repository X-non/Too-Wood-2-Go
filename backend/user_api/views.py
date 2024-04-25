from xml.dom import NotFoundErr
from django.http import JsonResponse
from rest_framework.authentication import TokenAuthentication
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.request import Request
from rest_framework.status import HTTP_400_BAD_REQUEST
from django.http.response import HttpResponseBadRequest
from user_api import serializer
from foretag.models import Ad, Store
from user_api.models import MobileUser
from user_api.serializer import AdSerializer, StoreSerialiser
from django.db.models import F


# TODO: actually hook up
class Register(APIView):
    authentication_classes = []

    queryset = Store.objects.all()
    pass

    def post(self, request: Request):
        pass


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
