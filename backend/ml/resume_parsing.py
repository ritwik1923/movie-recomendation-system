# from ml impor
from ml.extra_fn import random_with_N_digits
def rp_fn(file_name):
    data = {
        "name":f"name{random_with_N_digits(5)}",
        "phone_no": [random_with_N_digits(13),random_with_N_digits(13)],
        "file_name":file_name
    }
    return data

# print(random_with_N_digits(15))