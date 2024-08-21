module miner

import rand
import crypto.sha256
import time

const difficulty = 7

pub struct Miner {
pub mut:
	id   int
	hash string
	name string
}

pub fn (m Miner) start() {
	println('Starting mining process from MyMiner_${m.name}')

	mut guess_hash := ''
	mut name_hash := ''
	mut rand_string := ''
	mut rand_name := ''
	mut solved := 0

	for i in 0 .. 100_000_000 {
		rand_string = rand.string(10)
		rand_name = rand.ulid()
		guess_hash = sha256.hexhash(rand_string).substr(0, miner.difficulty)
		name_hash = sha256.hexhash(rand_name).substr(0, miner.difficulty)

		if guess_hash == name_hash {
			println('[${guess_hash} == ${name_hash}] Miner: MyMiner_${m.name} guessed correct')
			solved++
		}

		// print('[${i}] ${guess_hash} : ${name_hash}\n')
		// time.sleep(1 * time.second / 10)
		// println('')
	}
	println('MyMiner_${m.name} solved the hash puzzle ${solved} times')
}
