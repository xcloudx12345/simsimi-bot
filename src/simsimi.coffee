fetch = require("node-fetch")
class Simsimi
    constructor: (@token) ->

    request: (content, language, token) ->
        tokenToUse = if token then token else @token
        url = new URL('https://dkmpostor-auto-chat.herokuapp.com/autochat/')
        params = 
        message: content
        lang: language
        url.search = new URLSearchParams(params).toString()
        return new Promise (resolve, reject) ->
            fetch(url).then (res) ->
                data = await res.json().catch(() -> {})
                if not data
                    console.log await res.text()
                resolve data


module.exports = Simsimi
