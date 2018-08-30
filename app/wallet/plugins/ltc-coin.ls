export mainnet = 
    decimals: 8
    tx-fee: \0.0001
    mask: 'L000000000000000000000000000000000'
    api: 
        provider: \insight
        url: \https://insight.litecore.io
        decimal: 8
    message-prefix: '\x19Litecoin Signed Message:\n'
    bip32:
        public: 0x019da462
        private: 0x019d9cfe
    pub-key-hash: 0x30
    script-hash: 0x32
    wif: 0xb0
export testnet = 
    decimals: 8
    tx-fee: \0.0001
    topup: \https://litecoin-faucet.com/
    mask: 'n000000000000000000000000000000000'
    api: 
        provider: \insight
        url: \https://testnet.litecore.io
        decimal: 8
    message-prefix: '\x19Litecoin Signed Message:\n'
    bip32:
        public: 0x0436ef7d
        private: 0x0436f6e1
    pub-key-hash: 0x6f
    script-hash: 0xc4
    wif: 0xef
export type = \coin    
export enabled = yes
export token = \ltc
export image = \./res/litecoin-ethnamed.png