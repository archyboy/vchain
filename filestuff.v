module filestuff

import os

pub fn write_to_disk(bc_json string) !string {
	mut filename := os.create('blockchai.json') or {
		return error('Oooops..Could not write to file')
	}

	println('Saving data.....')
	filename.write(bc_json.bytes()) or { println(err) }

	filename.close() // always close file descriptor

	return 'Complete!'
}

pub fn read_from_disk() ![]u8 {
	mut filename := 'blockchai.json'
	mut file := os.open(filename) or { return error('Oooops..Could not read file') }

	println('Reading data.....')
	mut data_json := file.read_bytes(1000)

	file.close() // always close file descriptor

	return data_json
}
