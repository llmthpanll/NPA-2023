def fizzbuzz(number):
    """fizzbuzz"""
    if number % 3 == 0 and number % 5 == 0:
        return "fizzbuzz"
    elif number % 3 == 0:
        return "fizz"
    elif number % 5 == 0:
        return "buzz"
    else:
        return number

if __name__ == "__main__":
    for i in range(1, 101):
        print(fizzbuzz(i))
