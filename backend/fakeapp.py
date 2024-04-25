import requests
import argparse

parser = argparse.ArgumentParser("fakeapp")
parser.add_argument("url")
url = parser.parse_args().url
# from requests.utils import default_headers

username = "user"
password = "password"


def login(url, username, password):
    return requests.post(
        url=f"{url}/api/login/", json={"username": username, "password": password}
    ).json()["token"]


token = login(url, username, password)
print("logged in")

a = requests.get(url=f"{url}/api/stores", headers={"Authorization": f"Token {token}"})
print(a.json())
