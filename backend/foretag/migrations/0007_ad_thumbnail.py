# Generated by Django 5.0.4 on 2024-05-13 12:03

import foretag.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("foretag", "0006_store_banner_store_thumbnail"),
    ]

    operations = [
        migrations.AddField(
            model_name="ad",
            name="thumbnail",
            field=models.CharField(
                default=foretag.models.random_product_thumbnail, max_length=10000
            ),
        ),
    ]
