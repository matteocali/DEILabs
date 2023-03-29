import sys
import getopt
import json
from bs4 import BeautifulSoup
from pytimedinput import timedInput
import requests


def arg_parser(argv):
    """
    Function used to parse the input argument given through the command line
        param:
            - argv: system arguments
        return: 
            - list containing the input and output path
    """

    # Argument containing the name of the lab to log in
    arg_lab_name = "lttm"
    # Help string
    arg_help = "{0} -l <lab>".format(argv[0])

    try:
        # Recover the passed options and arguments from the command line (if any)
        opts, args = getopt.getopt(
            argv[1:], "hl:", ["help", "lab="])
    except getopt.GetoptError:
        print(arg_help)  # If the user provide a wrong options print the help string
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-l", "--lab"):
            arg_lab_name = arg  # Set the name of the lab

    return [arg_lab_name]


if __name__ == '__main__':
    # Load the .json file containing the cookie
    with open("data/cookie.json") as f:
        login = json.load(f)
    url = "https://deilabs.dei.unipd.it/laboratory_in_outs"
    
    with open("data/labs.json") as f:
        lab_id = json.load(f)

    lab_name = arg_parser(sys.argv)[0]
    if lab_name not in lab_id.keys():
        print("Impossible to login, invalid lab name")
        sys.exit(2)

    with requests.Session() as s:
        # s.verify = False
        response = s.get(url, cookies=login)
        dom = BeautifulSoup(response.text, 'html.parser')
        form = dom.find("form", {"id": "edit_laboratory_in_outs_form"})
        # check if logged in already
        if form is not None:
            print("User already logged in")
        else:
            # we need to login
            form = dom.find("form", {"id": "create_laboratory_in_out_form"})
            data = {c.attrs["name"]: c.attrs["value"] for c in form.findChildren("input", recursive=False)}
            data["laboratory_id"] = lab_id[lab_name]
            io = s.post(url=form.attrs["action"], json=data)
            dom = BeautifulSoup(io.text, 'html.parser')
            res = dom.find("div", {"class": "alert"}).findChildren("span", recursive=False)
            print(f"Succesfully logged in {lab_name}:", res[0].text)
