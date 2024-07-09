module filestuff

import os

pub fn write_to_disk(bc_json string) !string {
	mut filename := os.create('db/blockchain.json') or {
		return error('Oooops..Could not write to file')
	}

	println('Saving data.....')
	filename.write(bc_json.bytes()) or { println(err) }

	filename.close() // always close file descriptor

	return 'Complete!'
}

pub fn read_from_disk() ![]u8 {
	mut filename := 'db/blockchain.json'
	mut file := os.open(filename) or { return error('Oooops..Could not read file') }
	filesize := os.file_size(filename)
	if filesize > 1_000_000_000 {
		println('File is too big...Exiting')
		exit(1)
	} else {
		println('Reading data from: ${filename}')
	}

	mut data_json := file.read_bytes(1_000_000_000)

	file.close() // always close file descriptor

	return data_json
}
