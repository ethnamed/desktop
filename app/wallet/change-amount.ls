require! {
    \./math.ls : { times, minus, plus, div }
    \mobx : { toJS }
}
change-amount = (store, amount-send)->
    { send } = store.current
    { wallet } = send.coin
    #return if not send.wallet
    send.amount-send = amount-send ? ""
    result-amount-send = amount-send ? 0
    send.value = result-amount-send `times` (10 ^ send.network.decimals)
    send-usd = result-amount-send `times` wallet.usd-rate
    send.amount-obtain = result-amount-send
    send.amount-obtain-usd = send.amount-obtain `times` wallet.usd-rate
    send.amount-send-usd = send-usd
    send.amount-send-fee = send.network.tx-fee
    send.amount-charged =  result-amount-send `plus` send.network.tx-fee
    send.amount-send-fee-usd = send.network.tx-fee `times` wallet.usd-rate
    send.error = 
        if parse-float(wallet.balance `minus` result-amount-send) < 0
        then "Not Enough Funds"
        else ""
module.exports = change-amount