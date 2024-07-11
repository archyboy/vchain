module miner

pub struct Miner {
pub mut:
	id   int
	hash string
	name string
}

pub fn (m Miner) start() {
	println('Starting mining process from ${m.name}')

	// mut i := 0
	for i in 0 .. 100 + 1 {
		println('${m.name} is guessing secret ${i} times\n')
		// time.sleep(1 * time.second / 4)
		// println('')
	}
}
