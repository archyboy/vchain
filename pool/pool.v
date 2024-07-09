module pool

import blockchain
import miner

struct Pool {
	block  blockchain.Block
	miners []miner.Miner
}
