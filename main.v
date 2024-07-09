module main

import time
import rand
import json
import blockchain
import pool { Pool }
import miner { Miner }
import filestuff

fn main() {
	// Test comment
	//
	mut stopwatch := time.StopWatch{}
	stopwatch.start()

	mut bc := blockchain.Blockchain{}
	mut tb := blockchain.TransactionBox{}
	// mut transactions := []Transaction

	for i in 0 .. 3 {
		random_amount := rand.f32() * rand.int_in_range(1, 5000)!
		tb.transactions << tb.new(rand.string(32), rand.string(32), random_amount, 'ID: ${i} Text: This is the transaction message')!
	}

	for _ in 0 .. 1_000 {
		mut block := bc.new(tb)!
		println('Inserting block: ${bc.insert_block(block)}')
	}

	bc_json := json.encode_pretty(bc)
	write_result := filestuff.write_to_disk(bc_json) or {
		println(err)
		exit(1)
	}
	println(write_result)

	data_json_u8 := filestuff.read_from_disk() or {
		println(err)
		exit(1)
	}

	// data_json_array := data_json_u8
	// println(write_result)
	// println(data_json_u8)
	// println(typeof(data_json_u8))
	data_json_u8_str := data_json_u8.bytestr()
	println(data_json_u8_str)

	// println(bc)

	// bc2 := Blockchain{}
	data_struct := json.decode(blockchain.Blockchain, data_json_u8_str) or {
		println('Failed to decode JSON, error: ${err}')
		return
	}
	println(data_struct.blocks[0])

	transaction := data_struct.blocks[1].transactionbox.transactions[0]
	println(transaction.message)
	println(transaction.hash)
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
	stopwatch.stop()
	println('\n\nFinished all operations in ${stopwatch.elapsed()}')

	miner_1 := Miner{}
	pool_1 := Pool{}
}
