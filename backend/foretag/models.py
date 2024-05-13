from random import choice
from django.db import models
from django.template.defaultfilters import slugify
from django.contrib.auth.models import User

# Create your models here.


def random_store_banner():
    return choice(
        [
            r"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1d/c4/33/ca/middag.jpg?w=600&h=-1&s=1",
            r"https://static.thatsup.co/content/img/article/20/jan/guiden-till-helglunch-i-stockholm.jpg?1672673685",
            r"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/9f/ae/5d/trattoria-seurahuone.jpg?w=600&h=-1&s=1",
            r"https://www.icagruppen.se/globalassets/2.-om-ica-gruppen/2.-var-verksamhet/1.-vara-bolag/1.-ica-sverige/ica-sverige-sm.jpg",
            r"https://assets.icanet.se/image/upload/f_auto,dpr_auto,q_auto,fl_progressive/w_8510,h_4455,c_crop,g_auto/w_1200,h_628,c_scale/M7447",
        ]
    )


def random_store_thumbnail():
    return choice(
        [
            r"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpUqGgU6-NBSn4P3Ov8KMj2hnW0N-R3FFjuk8SgMQZWQ&s",
            r"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoFWLS1Nq3gwC-3IgB3LkJBK-pG9X_NnIb6tmJOrtxRQ&s",
            r"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOsChsRUfL6OHbN_OgrJ3lM3eBy9KI_wsSYQnrEx9pf_ZFYKiTb3xpSW_sYuNzPSDxGQU&usqp=CAU",
            r"https://lindhagenhuset.se/wp-content/uploads/2022/04/espressohouse-logo-lindhagenhuset.png",
        ]
    )


def random_product_thumbnail():
    return choice(
        [
            r"https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/415123805_847106780758079_7732937193029023278_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_ohc=EkFiAMxHXyQQ7kNvgG2Xpp_&_nc_ht=scontent-cph2-1.xx&oh=00_AfAmF8kcbcIQYZvMKNkk7JMxkmU-VqvsGwvr0ZaUaP-wlw&oe=664037C4",
            r"https://images.squarespace-cdn.com/content/v1/5eb1211225719420f0c80392/e1341689-c72e-49ab-a324-8375d4d4b0db/lillebrors-bageri-kardemummabulle",
            r"https://outofhome.se/media/catalog/product/cache/30/image/17f82f742ffe127f42dca9de82fb58b1/2/5/25003_ramlosa_citrus_burk.jpg",
            r"https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/336771456_888326685793721_5125519100193300153_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_ohc=xdLP2gfCIu0Q7kNvgGchy_C&_nc_ht=scontent-cph2-1.xx&oh=00_AfDHw7oRoOg6d9hUwPA9UrBMYFewTdE_EYchmNPOL2tlwg&oe=6640DC03",
            r"https://cdn.shopify.com/s/files/1/2713/9702/collections/2048x550_GateauFI_banner_konditoria.jpg?v=1682082466",
            r"https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/438087111_7446376142095492_3509539830803482736_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_ohc=iUUHeURPmyIQ7kNvgEpeJmY&_nc_ht=scontent-cph2-1.xx&oh=00_AfDvU4U8UlIijYkq96n5yWQIH4maEpRIfK1BkHDSCaHe1A&oe=6640F688",
        ]
    )


class Store(models.Model):
    name = models.CharField(max_length=50, unique=True)
    slug_name = models.SlugField(max_length=50)
    credentials = models.OneToOneField(User, on_delete=models.SET_NULL, null=True)
    address = models.CharField(max_length=100)
    postal_code = models.CharField(max_length=10)
    postal_city = models.CharField(max_length=30)
    banner = models.CharField(max_length=100, default=random_store_banner)
    thumbnail = models.CharField(max_length=100, default=random_store_thumbnail)

    # Overriding the save method to create slug name on save
    def save(self, *args, **kwargs):
        if not self.id:  # type:ignore
            # First time we save the object, so create slug
            self.slug_name = slugify(self.name)
        super(Store, self).save(*args, **kwargs)


class Ad(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=250)
    store = models.ForeignKey(Store, on_delete=models.CASCADE)
    available = models.PositiveSmallIntegerField(default=1)
    category = models.CharField(max_length=40, default="Annat")
    thumbnail = models.CharField(max_length=100, default=random_product_thumbnail)

    published = models.DateTimeField(auto_now_add=True)
    until = models.DateTimeField(auto_now_add=True)  # TODO - Change to some real value

    old_price = models.PositiveIntegerField(default=0)
    new_price = models.PositiveIntegerField(default=0)
