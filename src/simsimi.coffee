fetch = require("node-fetch")

class Simsimi
    constructor: (@token) ->

    request: (content, language, token) ->
        tokenToUse = if token then token else @token
        url = new URL('https://api-sv2.simsimi.net/v2/')
        params = 
        text: content
        lc: language
        cf: false
        url.search = new URLSearchParams(params).toString()
        return new Promise (resolve, reject) ->
            fetch(url).then (res) ->
                data = await res.json().catch(() -> {})
                if not data
                    console.log await res.text()
                resolve data

module.exports = Simsimi
