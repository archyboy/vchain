module main

import time
import crypto.sha256
import rand
import json
import filestuff

struct Transaction {
mut:
	id        int
	hash      string
	amount    f32
	reciever  string
	message   string
	timestamp string
}

struct TransactionBox {
mut:
	transactions []Transaction
}

struct Block {
mut:
	id                  int
	hash                string
	previous_block_hash string
	data                string
	transactionbox      TransactionBox
	timestamp           string
}

struct Blockchain {
mut:
	blocks []Block
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

pub fn (tb TransactionBox) get_last_transaction() !Transaction {
	if tb.transactions.len > 0 {
		return tb.transactions[tb.transactions.len - 1]
	} else {
		return error('Did not found a last transaction. Maybe need to generate one first')
	}
}

pub fn (mut bc Blockchain) insert_block(block Block) ! {
	bc.blocks << block
}

pub fn (mut bc Blockchain) new(transactionbox TransactionBox) !Block {
	if bc.blocks.len < 1 {
		return generate_genesis_block(time.now().str())
	}

	previous_block := bc.get_previous_block()!

	block := Block{
		id: previous_block.id + 1
		hash: sha256.hexhash(time.now().str() + rand.string(256))
		previous_block_hash: bc.get_previous_block()!.hash
		data: 'This is a new block on the chain'
		transactionbox: transactionbox
		timestamp: time.now().str()
	}
	return block
}

pub fn (tb TransactionBox) new(reciever string, amount f32, message string) !Transaction {
	mut last_transaction := Transaction{}

	if tb.transactions.len > 0 {
		last_transaction = tb.get_last_transaction() or {
			println(err)
			exit(1)
		}
	} else {
		last_transaction.id = 0
	}
	transaction := Transaction{
		id: last_transaction.id + 1
		hash: sha256.hexhash(time.now().str() + rand.string(64))
		amount: amount
		reciever: reciever
		message: message
	}
	return transaction
}

fn main() {
	mut bc := Blockchain{}
	mut tb := TransactionBox{}
	// mut transactions := []Transaction

	for i in 1 .. 50 {
		random_amount := rand.f32() * rand.int_in_range(1, 5000)!
		tb.transactions << tb.new(rand.string(32), random_amount, 'ID: ${i} Text: This is the transaction message')!
	}

	for _ in 1 .. 5000 {
		mut block := bc.new(tb)!
		bc.insert_block(block)!
	}

	bc_json := json.encode(bc)
	write_result := filestuff.write_to_disk(bc_json) or {
		println(err)
		exit(1)
	}

	data_json_u8 := filestuff.read_from_disk() or {
		println(err)
		return
	}

	data_json_array := data_json_u8
	// println(write_result)
	println(data_json_u8)
	println(typeof(data_json_u8))
	println(data_json_u8.len)

	for _, line in data_json_u8 {
		println(line.hex())
	}

	// println(bc_json)

	// println(block_1)
	// println(block_2)
	// previous_block := block_chain.get_previous_block() or { println(err) return }
	// previous_block_hash := previous_block.previous_block_hash
	// block_chain.insert_block(block_1)!
	// block_chain.insert_block(block_2)!

	// println(bc)
	// println(tb)
	// println(previous_block)
}
