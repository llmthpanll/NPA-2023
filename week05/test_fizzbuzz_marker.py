import pytest
from fizzbuzz import fizzbuzz

@pytest.mark.num
def test_num():
    assert fizzbuzz(1) == 1
    assert fizzbuzz(2) == 2
    assert fizzbuzz(4) == 4
    assert fizzbuzz(7) == 7
    print("test_num passed")

@pytest.mark.fizz
def test_fizz():
    assert fizzbuzz(3) == "fizz"
    assert fizzbuzz(6) == "fizz"
    assert fizzbuzz(9) == "fizz"
    assert fizzbuzz(12) == "fizz"
    print("test_fizz passed")

@pytest.mark.buzz
def test_buzz():
    assert fizzbuzz(5) == "buzz"
    assert fizzbuzz(10) == "buzz"
    print("test_buzz passed")
    
@pytest.mark.fizzbuzz
def test_fizzbuzz():
    assert fizzbuzz(15) == "fizzbuzz"
    assert fizzbuzz(30) == "fizzbuzz"
    print("test_fizzbuzz passed")
    
if __name__ == "__main__":
    test_num()
    test_fizz()
    test_buzz()
    test_fizzbuzz()