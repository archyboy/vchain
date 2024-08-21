module steps

import time
import os
import rand
import miner
import pool
import crypto.sha256

pub fn start_mining() {
	for {
		match os.input('Start mining (y/n):') {
			'y' {
				mut stopwatch_mining := time.StopWatch{}
				stopwatch_mining.start()
				mut new_pool := pool.Pool{}
				new_pool.name = 'LegionPool'

				new_pool.load_blockchain('db/blockchain.json')

				mut i := 0
				for _ in 0 .. 1 {
					i++
					mut new_miner := miner.Miner{}
					new_miner.name = '${rand.ulid()}'
					new_miner.id = i
					new_miner.hash = sha256.hexhash(new_miner.name)
					new_pool.add_miner(new_miner)
				}
				new_pool.run()
				stopwatch_mining.stop()
				println('\n\nFinished all mining operations in ${stopwatch_mining.elapsed()}')
				break
			}
			'n' {
				break
			}
			else {
				continue
			}
		}
	}
}
