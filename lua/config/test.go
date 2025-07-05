package main

import "fmt"

// commenting 
func main() {

	fmt.Printf("test")

	thisIsLong := 3 + 5

	thisIsLonger := "a very long string"
	res, err := tst(3, 4)
	if err != nil {
		if res == 5 {
			fmt.Println()
		}
	}
	fmt.Println(thisIsLong)
	test()
	l := len(thisIsLonger)
}

var ch = make(chan string, 5)

func another() {
	fmt.Println("test")
}

func test() {
	another := Test{
		name:  "my",
		value: 45,
	}
	fmt.Printf("sturct: %v", another)
}

func tst(x, y int) (int, error) {
	return x + y, nil
}

type Test struct {
	name  string
	value int
}
