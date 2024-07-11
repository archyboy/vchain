module miner

// import net
import os
import net
import time
// import coroutines

// import pool

pub struct Miner {
pub mut:
	id   int
	hash string
	name string
}

pub fn (m Miner) start() {
	print('Starting mining process from ${m.name}')

	// mut i := 0
	for i in 0 .. 1000 + 1 {
		print('${m.name} is guessing secret ${i} times\n')
		// time.sleep(1 * time.second / 4)
		println('')
	}
}
