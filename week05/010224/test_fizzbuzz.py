"""TDD-example"""
from fizzbuzz import fizzbuzz

def test_fizzbuzz():
    """test_fizzbuzz"""
    assert fizzbuzz(1) == 1
    assert fizzbuzz(2) == 2
    assert fizzbuzz(3) == "fizz"
    assert fizzbuzz(4) == 4
    assert fizzbuzz(5) == "buzz"
    assert fizzbuzz(6) == "fizz"
    assert fizzbuzz(7) == 7
    assert fizzbuzz(8) == 8
    assert fizzbuzz(9) == "fizz"
    assert fizzbuzz(10) == "buzz"
    assert fizzbuzz(11) == 11
    assert fizzbuzz(12) == "fizz"
    assert fizzbuzz(13) == 13
    assert fizzbuzz(14) == 14
    assert fizzbuzz(15) == "fizzbuzz"
    print("all tests are passed")
    
if __name__ == "__main__":
    test_fizzbuzz()
