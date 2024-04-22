from xml.dom import NotFoundErr
from rest_framework.authentication import TokenAuthentication
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.request import Request
from django.http.response import HttpResponseBadRequest
from user_api import serializer
from foretag.models import Store
from user_api.models import MobileUser
from user_api.serializer import StoreSerialiser
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
