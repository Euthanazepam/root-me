from os.path import exists
from requests import get

base_url = "https://static.root-me.org"
path = "cryptanalyse/ch8"
filename = "ch8.txt"


def download_file() -> None:
    """
    Downloads a file from the task page to the current directory.
    """

    url = f"{base_url}/{path}/{filename}"

    response = get(url=url)

    try:
        with open(f"Encoding - ASCII/{filename}", "wb") as f:
            f.write(response.content)
    except FileNotFoundError:
        with open(f"{filename}", "wb") as f:
            f.write(response.content)


def get_flag() -> str:
    """
    Returns the challenge flag https://www.root-me.org/en/Challenges/Cryptanalysis/Encoding-ASCII

    :return: Flag
    """

    if not exists(f"{filename}"):
        download_file()

    try:
        with open(f"Encoding - ASCII/{filename}", "r") as f:
            ch8 = f.read()
    except FileNotFoundError:
        with open(f"{filename}", "r") as f:
            ch8 = f.read()

    flag = bytes.fromhex(ch8).decode('utf-8')

    return flag


if __name__ == '__main__':
    print(get_flag())
