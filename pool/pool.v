module pool

import blockchain
import miner

pub struct Pool {
	block  blockchain.Block
	miners []miner.Miner
}
