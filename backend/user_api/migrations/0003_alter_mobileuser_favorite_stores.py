# Generated by Django 5.0.4 on 2024-05-02 10:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('foretag', '0002_alter_store_credentials'),
        ('user_api', '0002_mobileuser_credentials'),
    ]

    operations = [
        migrations.AlterField(
            model_name='mobileuser',
            name='favorite_stores',
            field=models.ManyToManyField(blank=True, to='foretag.store'),
        ),
    ]
