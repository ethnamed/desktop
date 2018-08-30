require! {
    \superagent : { get }
    \../math.ls : { div }
    \../json-parse.ls
}
export create-transaction = ({ sender, recepient, amount, amount-fee } , cb)-->
    cb "Not implemented"
export push-tx = ({ network, rawtx } , cb)-->
    cb "Not implemented"
export get-balance = ({ address } , cb)->
    err, res <- get "https://nodes.wavesnodes.com/addresses/balance/#address"  .timeout(deadline: 15000).end
    return cb err if err?
    err, result <- json-parse res.text
    return cb err if err?
    return cb "Balance is not available" if not result?balance?
    balance = result.balance `div` 100000000
    cb null, balance
export get-transactions = ({ network, address}, cb)->
    cb null, []