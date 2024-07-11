module pool

import net.http
import json
import blockchain
import miner
import filestuff

const host_url = 'http://192.168.10.188:8082/users/:user'
const valid_last_hash = '4567df15286806c3f84262cf12512b96f36a980729fde46fab3c24dd265a5226'

pub struct Pool {
pub mut:
	name       string
	blockchain blockchain.Blockchain
	new_block  blockchain.Block
	miners     []miner.Miner
}

pub fn (mut p Pool) add_miner(new_miner miner.Miner) {
	println('Adding new miner too pool! ${p.name}')
	p.miners << new_miner
}

pub fn (mut p Pool) load_blockchain(bc_path string) {
	println('Loading blockchain from (${bc_path}) to pool (${p.name})')
	data_json_u8 := filestuff.read_from_disk() or {
		println(err)
		exit(1)
	}
	data_json_u8_str := data_json_u8.bytestr()
	data_struct := json.decode(blockchain.Blockchain, data_json_u8_str) or {
		println('Failed to decode JSON, error: ${err}')
		exit(1)
	}
	p.blockchain = data_struct
	// println(p.blockchain)
}

pub fn (p Pool) run() {
	mut threads := []thread{}
	for m in p.miners {
		threads << spawn m.start()
	}
	threads.wait()
}
