module steps

import os
import rand
import miner
import pool

pub fn start_mining() {
	for {
		match os.input('Start mining (y/n):') {
			'y' {
				mut new_pool := pool.Pool{}
				new_pool.name = 'LegionPool'

				new_pool.load_blockchain('db/blockchain.json')

				mut i := 0
				for _ in 0 .. 1000 {
					i++
					mut new_miner := miner.Miner{}
					new_miner.name = '${rand.ulid()} ${rand.ulid()}'
					new_miner.id = i
					new_pool.add_miner(new_miner)
				}
				new_pool.run()
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
