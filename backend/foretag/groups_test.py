from django.contrib.auth.models import Group, Permission, User
from django.contrib.contenttypes.models import ContentType
from foretag.models import Ad
import os

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')
company_test, created = Group.objects.get_or_create(name="company")
ct = ContentType.objects.get_for_model(model=Ad)
perms = Permission.objects.filter(content_type=ct)
company_test.permissions.add(*perms)
company_test