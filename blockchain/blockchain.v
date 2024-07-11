module blockchain

import time
import crypto.sha256
import rand

pub struct Blockchain {
pub mut:
	blocks []Block
}

pub struct Block {
pub mut:
	id                  int
	hash                string
	previous_block_hash string
	data                string
	transactionbox      TransactionBox
	timestamp           string
}

pub fn generate_genesis_block(timestamp string) Block {
	mut block := Block{}
	block.id = 0
	block.hash
	block.data = '{message: "This is the genesis block"}'
	this_time := time.new(time.now())
	block.timestamp = this_time.unix().str()
	hash_string := sha256.hexhash(block.timestamp)
	block.hash = hash_string

	// println(block.hash)
	return block
}

pub fn (bc Blockchain) get_previous_block() !Block {
	if bc.blocks.len > 0 {
		return bc.blocks[bc.blocks.len - 1]
	} else {
		return error('Did not found a previous block. Maybe need to generate the genesis block')
	}
}

pub fn (mut bc Blockchain) insert_block(block Block) int {
	bc.blocks << block
	return block.id
}

pub fn (mut bc Blockchain) new(transactionbox TransactionBox) !Block {
	if bc.blocks.len < 1 {
		return generate_genesis_block(time.now().str())
	}
	previous_block := bc.get_previous_block()!
	// println('Creating new block to the blockchain with ID: ${previous_block.id}')

	mut block := Block{
		id: previous_block.id + 1
		previous_block_hash: bc.get_previous_block()!.hash
		data: 'This is a new block on the chain'
		transactionbox: transactionbox
		timestamp: time.now().str()
	}
	block.hash = sha256.hexhash(previous_block.hash + block.str())
	return block
}
