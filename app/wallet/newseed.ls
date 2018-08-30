require! {
    \react
    \whitebox
    \./navigate.ls
    \./web3.ls
    \./refresh-account.ls
    \./seed.ls : { set }
}
{ get-container, generate-wallet } = whitebox
# .newseed-405874293
#     padding-top: 50px
#     min-height: 300px
#     .title
#         color: #248295
#         font-size: 35px
#         margin-bottom: 20px
#     textarea
#         width: 300px
#         height: 100px
#         border-radius: 3px
#         resize: none
#         padding: 10px
#         font-size: 17px
#         border: 1px solid #CCC
#         text-align: center
#         outline: none
#         &:focus
#             border-color: #248295
#     button
#         outline: none
#         width: 125px
#         margin: 5px
#         height: 26px
#         border: 0
#         cursor: pointer
#         background: #248295
#         border-radius: 20px
#         font-size: 15px
#         color: white
#         &:hover
#             background: #248295 - 20
#     .hint
#         color: #c6c5c5
#         padding: 20px 38px
newseed = ({ store })->
    generate-seed = ->
        store.current.seed = generate-wallet!.mnemonic
    change-seed = (event)->
        store.current.seed = event.target.value
    save = ->
        return alert "Secret key cannot be empty" if store.current.seed.length is 0
        return alert "Secret key is so weak" if store.current.seed.length < 20
        return if not confirm "Please confirm that you stored this phrase in safe place?"
        store.current.saved-seed = yes
        set store.current.seed
        navigate store, \:init 
        <- refresh-account web3(store), store
    react.create-element 'div', { className: 'newseed newseed-405874293' }, children = 
        react.create-element 'div', { className: 'title' }, ' New Seed Phrase'
        react.create-element 'textarea', { value: "#{store.current.seed}", on-change: change-seed, placeholder: "Click Generate or Put Your Seed Phrase here" }
        react.create-element 'div', {}, children = 
            react.create-element 'button', { on-click: generate-seed, className: 'left' }, ' Generate'
            react.create-element 'button', { on-click: save, className: 'right' }, ' Save'
        react.create-element 'div', { className: 'hint' }, ' The phrase is stored securely on your computer. Do not transfer it to a third party and keep the duplicate in a safe place.'
init = (store)->
    <- set-timeout _, 100
    textarea = store.root.query-selector '.newseed textarea'
    textarea.focus!
newseed.init = init
module.exports = newseed