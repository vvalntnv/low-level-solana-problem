use std::str::FromStr;

use solana_client::{
    rpc_client::RpcClient,
    rpc_config::{CommitmentConfig, UiTransactionEncoding},
    rpc_response::OptionSerializer,
};
use solana_sdk::{
    message::{Instruction, Message},
    pubkey::Pubkey,
    signature::{Keypair, read_keypair_file},
    signer::Signer,
    transaction::Transaction,
};

fn main() {
    let client = RpcClient::new_with_commitment(
        "https://api.devnet.solana.com".to_string(),
        CommitmentConfig::confirmed(),
    );

    let program_id = Pubkey::from_str("FZDHFDix4m5yYDzT9q4dm4doZ2erjNbVJjeMhnTD5LTn").unwrap();
    let payer = read_keypair_file("/Users/viktorvalentinov/.config/solana/id.json")
        .expect("could not read keypair");

    // let payer = Keypair::new();

    // client
    //     .request_airdrop(&payer.pubkey(), 10_000_000_000)
    //     .unwrap();

    println!("Balance = {}", client.get_balance(&payer.pubkey()).unwrap());

    let mut instruction_vec: Vec<u8> = vec![];
    let funny_number = -0x2995650000000000 as i64;

    for ele in funny_number.to_le_bytes().iter() {
        instruction_vec.push(*ele);
    }
    for ele in (0 as u64).to_le_bytes().iter() {
        instruction_vec.push(*ele);
    }

    let instruction = Instruction::new_with_bytes(program_id, &instruction_vec, vec![]);
    let message = Message::new(&[instruction], Some(&payer.pubkey()));

    println!("funny number: {}", funny_number);

    let recent_blockhash = client.get_latest_blockhash().expect("super");
    let tx = Transaction::new(&[payer], message, recent_blockhash);

    client.send_and_confirm_transaction(&tx).unwrap();

    // let trans = client
    //     .get_transaction(&sig, UiTransactionEncoding::Json)
    //     .unwrap();
    //
    // let tx_meta = match trans.transaction.meta {
    //     Some(meta) => meta,
    //     None => panic!("no meta ;("),
    // };
    //
    // match tx_meta.log_messages {
    //     OptionSerializer::Some(messages) => {
    //         for message in messages {
    //             println!("Message: ${}", message);
    //         }
    //     }
    //     _ => panic!("no logs :("),
    // }
}
