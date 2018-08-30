require! {
    \./new-account.ls
    \./plugin-loader.ls : { coins }
    \prelude-ls : { map, pairs-to-obj }
    \./seed.ls : { saved }
    \./browser/location.ls
}
saved-seed = saved!
store =
    root: null
    current:
        demo: location.href.index-of('wallet.ethnamed.io') > -1 
        network: \mainnet
        pin: ""
        pin-trial: 0
        refreshing: no
        copied: ""
        page: \locked
        send-to-mask: ""
        status: \main
        nickname: ""
        nicknamefull: \nickname@domain.com
        message: ""
        custom-domain: no
        can-buy: no
        checking-name: no
        seed: ""
        saved-seed: saved-seed
        balance-usd: \...
        filter: <[ IN OUT ]>
        send: 
            id: ""
            to: ""
            propose-escrow: no
            address: ''
            value: \0
            amount-send: \0
            amount-charged: \0
            amount-send-usd: \0
            amount-send-fee: \0
            amount-send-fee-usd: \0
            amount-obtain: \0
            data: ""
            decoded-data: ""
            show-data-mode: \encoded
            error: ''
    rates: 
        coins 
            |> map -> [it.token.to-upper-case!, USD: 0] 
            |> pairs-to-obj
#store.current.account = new-account store, seed-str
module.exports = store