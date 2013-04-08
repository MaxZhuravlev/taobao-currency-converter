dev = yes
APP_NAME="taobao-currency-converter"
syncStorage = chrome.storage[ if dev then 'local' else 'sync' ]
getMessage = chrome.i18n.getMessage

window.onload = () ->
  window.app = new App

  syncStorage.get APP_NAME, (items) ->
    console.log 'data from syncStorage', items[APP_NAME]

    app.options = items[APP_NAME] if items[APP_NAME]

    do app.init

class App

  options: {}

  init: ->

    console.log (APP_NAME+' start')

    # http://josscrowcroft.github.io/money.js/#basic-install
    fx.base = "RUR"

    fx.rates =
      CNY: 0.198514907 # RUR to CNY
      USD: 0.032001 # RUR to USD
      RUR: 1 # always include the base rate (1:1)


    $(".price").each ->
      text = $(this).text()

      newText="";

      newText+=(app.convert text.replace(/￥/g, ""), "RUR")
      newText+=" "
      newText+=(app.convert text.replace(/￥/g, ""), "USD")

      $(this).html newText

  convert: (sum, toCurrency) ->
    sum=fx.convert sum,
      from: "CNY"
      to: toCurrency

    return  accounting.formatMoney sum,
      symbol: toCurrency
      format: "%v %s"








unless dev
  console.log = console.error = ->