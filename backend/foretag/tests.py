from django.test import TestCase


# Create your tests here.
class DummyTests(TestCase):
    def test_trivial(self):
        self.assertEqual(1, 1)
