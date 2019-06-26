#!/usr/bin/env python
import math

def countRec(choc, wrap):
    if (choc < wrap):
        return 0;

    newChoc = choc / wrap;

    return newChoc + countRec(newChoc + choc % wrap, wrap);

def countMaxChoco(money, price, wrap):

    choc = money / price;
    return math.floor(choc + countRec(choc, wrap));


priceandwrapper = raw_input("Enter the values: ")
price_wrapper = priceandwrapper.split()

# Total money
money = int(price_wrapper[0])

# no of wrappers

wrap = int(price_wrapper[1])

# cost of each chocolate
price = 1;

# exchanged for one chocolate.
print(int(countMaxChoco(money, price, wrap)));
