module main

import os
import time
import rand
import json
import blockchain
import pool
import miner
import filestuff
import steps

const valid_last_hash = '96dcf8ef9da4b3413498b7b06543d767b4263cae4c6051a8eb56bf9a42576f40'
// Little comment test

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

	for _ in 0 .. 10 {
		mut block := bc.new(tb)!
		println('Inserting block: ${bc.insert_block(block)}')
	}

	mut write_result := ''
	for {
		match os.input('Do you want to write new blockchain to disk (y/n):') {
			'y' {
				bc_json := json.encode_pretty(bc)
				write_result = filestuff.write_to_disk(bc_json) or {
					println(err)
					exit(1)
				}
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

	data_json_u8 := filestuff.read_from_disk() or {
		println(err)
		exit(1)
	}

	data_json_array := data_json_u8
	data_json_u8_str := data_json_u8.bytestr()

	// println(write_result)
	// println(data_json_u8)
	// println(typeof(data_json_u8))
	// println(data_json_u8_str)
	// println(bc)

	data_struct := json.decode(blockchain.Blockchain, data_json_u8_str) or {
		println('Failed to decode JSON, error: ${err}')
		return
	}
	// println(data_struct.blocks)

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

	last_block_hash := data_struct.blocks[data_struct.blocks.len - 1].hash

	println('Last block hash:' + last_block_hash)

	if last_block_hash == valid_last_hash {
		println('\nValidation completed! Blockchain status: OK')
	} else {
		println('\nWarning.. Someone or something has changed data in a block. The blockchain is not valid')

		for {
			match os.input('Delete blockchain (y/n)?: ') {
				'y' {
					os.rm('db/blockchain.json') or { println(err) }
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

	steps.start_mining()

	// mut new_miner_1 := miner.Miner{}
	// new_miner_1.name = 'AndyBoy'
	// mut new_miner_2 := miner.Miner{}
	// new_miner_2.name = 'TestBoy'
}

pub fn validate_blockchain(valid_last_hash string) {
}
