from rest_framework import serializers
from user_api.models import MobileUser
from foretag.models import Ad, Store


# {
#     "catagory": "supermarket" | "bakery" | ...,
#     "pretty name": "Ica Supermarket Väst",
#     "store_id": "ica-supermarket-vest"
#     "plats": "kordinater",
#     "address": "Exempelvägen 42, Uppsala",
#     "opening_hours": ...,
#     "thumbnail": "assets/bla.png"
#     "banner_image":"assets/big.png"
#     "favorite": bool
# }
class StoreSerialiser(serializers.Serializer):
    pretty_name = serializers.CharField(source="name")
    store_id = serializers.CharField(source="slug_name")
    favorite = serializers.SerializerMethodField(read_only=True)

    def get_favorite(self, obj):
        user = self.context["request"].user
        print("Banana: ", user, user.is_authenticated)
        if not user.is_authenticated:
            return None

        user = MobileUser.objects.get(credentials=user)
        return user.favorite_stores.contains(obj)


class AdSerializer(serializers.ModelSerializer):

    class Meta:
        model = Ad
        exclude = ["store"]
