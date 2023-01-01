# TODO
from cs50 import get_float

while True:
    cash = get_float("Change owed: ")
    if (cash > 0):
        break

cents = int(round(cash * 100))
coins = 0

while cents > 0:
    if (cents >= 25):
        cents -= 25
        coins += 1
    elif (cents >= 10):
        cents -= 10
        coins += 1
    elif (cents >= 5):
        cents -= 5
        coins += 1
    else:
        coins += cents
        cents = 0

print(coins)
