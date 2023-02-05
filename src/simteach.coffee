fetch = require("node-fetch")



class simteach
    constructor: (@token) ->

    request: (content, language, token) ->
        tokenToUse = if token then token else @token
        url = new URL('https://simsimi.info/api/')
        text = content.split('=>')
        params = 
        teach: 'true'
        ask: text[0]
        ans: text[1]
        lc: language
        url.search = new URLSearchParams(params).toString()
        return new Promise (resolve, reject) ->
            fetch(url).then (res) ->
                data = await res.json().catch(() -> {})
                if not data
                    console.log await res.text()
                resolve data

module.exports = simteach
