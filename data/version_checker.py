import requests
import json


def versiontuple(v):
    return tuple(map(int, (v.split("."))))


if __name__ == '__main__':
    # Load the .json file containing the remote version
    url = 'https://raw.githubusercontent.com/matteocali/DEILabs/main/data/version.json'
    f = requests.get(url)
    # The .json() method automatically parses the response into JSON.
    git_version = f.json()["version"]

    # Load the .json file containing the local version
    with open('data/version.json') as f:
        version = json.load(f)["version"]

    # Compare the two versions
    if versiontuple(git_version) > versiontuple(version):
        print(f"Update available ({version} -> {git_version}) at https://github.com/caligola25/DEILabs")
    else:
        print("")
