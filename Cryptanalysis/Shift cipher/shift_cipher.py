#!/usr/bin/env python3

# Standard library imports
from os.path import exists

# Third-party library imports
from requests import get    # pip install requests

base_url = "https://static.root-me.org"
path = "cryptanalyse/ch7"
filename = "ch7.bin"


def download_file() -> None:
    """
    Downloads a file from the task page to the current directory.
    """

    url = f"{base_url}/{path}/{filename}"

    response = get(url=url)

    try:
        with open(f"Shift cipher/{filename}", "wb") as f:
            f.write(response.content)
    except FileNotFoundError:
        with open(f"{filename}", "wb") as f:
            f.write(response.content)


def get_flag() -> str:
    """
    Returns the challenge flag https://www.root-me.org/en/Challenges/Cryptanalysis/Shift-cipher

    Subtract 10 from each byte represented in integer format. The resulting value is the integer
    value of the ASCII character. Then convert the number to a character.

    References:
        1. https://www.dcode.fr/ascii-shift-cipher, use a shift of 10.

    :return: Flag
    """

    if not exists(f"{filename}"):
        download_file()

    flag = ''

    with open("ch7.bin", "rb") as ch7:
        raw_data = ch7.read()
        for byte in raw_data:
            flag += chr(byte - 10)

    return flag


if __name__ == "__main__":
    print(get_flag())
