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
            r"https://tinyurl.com/3v3z5cvd",
            r"https://tinyurl.com/44ses44u",
            r"https://tinyurl.com/dt6t5apz",
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

    def __str__(self):
        return self.name


class Ad(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=250)
    store = models.ForeignKey(Store, on_delete=models.CASCADE)
    available = models.PositiveSmallIntegerField(default=1)
    category = models.CharField(max_length=40, default="Övrigt")
    thumbnail = models.CharField(max_length=100, default=random_product_thumbnail)

    published = models.DateTimeField(auto_now_add=True)
    until = models.DateTimeField(auto_now_add=True)  # TODO - Change to some real value

    old_price = models.PositiveIntegerField(default=0)
    new_price = models.PositiveIntegerField(default=0)

    def __str__(self):
        return self.title
