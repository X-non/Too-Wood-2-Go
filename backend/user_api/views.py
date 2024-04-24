import json
from django.http import JsonResponse
from rest_framework.authentication import TokenAuthentication
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.status import HTTP_400_BAD_REQUEST
from rest_framework.request import Request
from rest_framework.parsers import JSONParser
from foretag.models import Store
from user_api.models import MobileUser
from user_api.serializer import StoreSerialiser
from django.http.response import HttpResponseBadRequest
from django.db.models import F
from django.contrib.auth.models import User


class Register(APIView):
    authentication_classes = []
    permission_classes = []

    queryset = MobileUser.objects.all()

    def post(self, request: Request):

        parsed = request.data
        if not isinstance(request.data, dict):
            return JsonResponse({"reason": "not json"}, status=HTTP_400_BAD_REQUEST)
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
