module blockchain

import crypto.sha256
import time
import rand

pub struct Transaction {
pub mut:
	id        int
	hash      string
	amount    f32
	sender    string
	reciever  string
	message   string
	timestamp string
}

pub struct TransactionBox {
pub mut:
	transactions []Transaction
}

pub fn (tb TransactionBox) get_last_transaction() !Transaction {
	if tb.transactions.len > 0 {
		return tb.transactions[tb.transactions.len - 1]
	} else {
		return error('Did not found a last transaction. Maybe need to generate one first')
	}
}

pub fn (tb TransactionBox) new(sender string, reciever string, amount f32, message string) !Transaction {
	mut last_transaction := Transaction{}

	if tb.transactions.len > 0 {
		last_transaction = tb.get_last_transaction() or {
			println(err)
			exit(1)
		}
	} else {
		last_transaction.id = -1
	}
	transaction := Transaction{
		id: last_transaction.id + 1
		hash: sha256.hexhash(time.now().str() + rand.string(64))
		amount: amount
		sender: sender
		reciever: reciever
		message: message
	}
	return transaction
}
