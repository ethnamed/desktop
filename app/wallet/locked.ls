require! {
    \react
    \prelude-ls : { map }
    \./pin.ls : { set, check, exists } 
    \./navigate.ls
}
# .locked1567056849
#     padding-top: 200px
#     min-height: 300px
#     text-align: center
#     >.title
#         font-size: 35px
#         color: #248295
#         margin-bottom: 20px
#     >.inputs
#         input
#             text-align: center
#             font-size: 24px
#             display: inline-block
#             width: 40px
#             height: 40px
#             background: white
#             border: 1px solid #CCC
#             border-radius: 3px
#             margin: 5px
#             outline: none
#             &:focus
#                 border-color: #248295
#     >.wrong
#         color: red
#     button.setup
#         cursor: pointer
#         margin-top: 20px
#         width: 100px
#         height: 30px
#         border-radius: 3px
#         border: 0px
#         background: #248295
#         &:hover
#             background: #248295 - 20
#         color: white
#     .hint
#         color: #bab7b7
#         padding: 20px 38px
goto = (store, number)->
    return if not store.root?
    items = store.root.query-selector-all '.locked input'
    input = items[number]
    return if not input?
    input.focus!
    <- set-timeout _, 100
    input.set-selection-range 0, 1
wrong-pin = (store)->
    store.current.pin = ""
    store.current.pin-trial += 1
    goto store, 0
check-pin = (store)->
    return if not exists!
    return wrong-pin store if not check(store.current.pin)
    store.current.pin-trial = 0
    store.current.pin = ""
    navigate store, \:init
go-back = (store, number)->
    prev = number - 1
    return if prev < 0
    goto store, prev
go-forward = (store, number)->
    nxt = number + 1
    return if nxt > 3
    arr = store.current.pin.split('')
    return if (arr[number] ? "").length isnt 1
    goto store, nxt
set-val = (store, number, value)->
    arr = store.current.pin.split('')
    arr[number] = value
    store.current.pin = arr.join('')
    return check-pin store if number is 3
    nextn = number + 1
    goto store, nextn
setup-keydown = (store)-> (number)-> (event)->
    { key-code } = event
    return set-val store, number, key-code - 48 if key-code >= 48 and key-code <= 57
    return go-back store, number if key-code in [8, 37]
    return go-forward store, number if key-code is 39
setup-val = (store)-> (number)->
    store.current.pin[number] ? ""
input = (store)-> (number)->
    keydown = setup-keydown store
    val = setup-val store
    type = 
        | not exists! => \input
        | _ => \password
    react.create-element 'input', { key: "#{number}", type: "#{type}", value: "#{val number}", placeholder: "0", on-key-down: keydown(number), tabindex: "#{number + 1}", pattern: "[0-9]", inputmode: "numeric" }
wrong-trials = (store)->
    return null if store.current.pin-trial is 0
    react.create-element 'div', { className: 'wrong' }, ' Wrong PIN. Trials: ' + store.current.pin-trial
setup-button = (store)->
    setup = ->
        return alert('PIN should be 4 digits') if not store.current.pin.match(/^[0-9]{4}$/)?
        set store.current.pin
        check-pin store
    react.create-element 'div', {}, children = 
        react.create-element 'button', { on-click: setup, className: 'setup' }, ' Setup'
        react.create-element 'div', { className: 'hint' }, ' Please memorize this PIN and do not provide it to third party.'
locked = ({ store })->
    title = 
        | not exists! => "Setup PIN"
        | _ => "Enter PIN"
    footer =
        | not exists! => setup-button
        | _ => wrong-trials
    react.create-element 'div', { className: 'locked locked1567056849' }, children = 
        react.create-element 'div', { className: 'title' }, ' ' + title
        react.create-element 'div', { className: 'inputs' }, children = 
            [0 to 3] |> map input store
        footer store
init = (store)->
    goto store, 0
locked.init = init
module.exports = locked