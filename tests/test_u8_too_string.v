module test

fn main() {
	test_str := 'Hello Test!'
	test_u8 := test_str.bytes()
	println(test_u8.bytestr())

	test_arr := [test_u8, test_u8, test_u8]
	// println(test_arr)
	// println(typeof(test_arr).name)

	for line in test_arr {
		println(line.bytestr())
	}
}
