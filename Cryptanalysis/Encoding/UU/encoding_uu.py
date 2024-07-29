from binascii import a2b_uu
from requests import get

base_url = "https://static.root-me.org"
path = "cryptanalyse/ch1"
filename = "ch1.txt"


def download_file() -> None:
    """
    Downloads a file from the task page to the current directory.
    """

    url = f"{base_url}/{path}/{filename}"

    response = get(url=url)

    try:
        with open(f"Encoding - UU/{filename}", "wb") as f:
            f.write(response.content)
    except FileNotFoundError:
        with open(f"{filename}", "wb") as f:
            f.write(response.content)


def get_flag() -> str:
    """
    https://www.root-me.org/en/Challenges/Cryptanalysis/Encoding-UU
    """

    download_file()

    try:
        with open(f"Encoding - UU/{filename}", "r") as f:
            ch1 = f.readlines()
    except FileNotFoundError:
        with open(f"{filename}", "r") as f:
            ch1 = f.readlines()

    flag = a2b_uu(ch1[6]).decode('utf-8')

    return flag


if __name__ == '__main__':
    print(get_flag())
