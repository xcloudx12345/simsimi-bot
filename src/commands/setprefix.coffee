module.exports.run = (client, message, args) ->

    # Check if there is a message to send
    if not args[0]
        return client.createMessage message.channel.id,
        """:x: Bạn chưa gõ dấu lệnh mới, lệnh hiện tại vẫn là .#{client.config.prefix}!"""
    else
        client.config.prefix = args[0]
        return client.createMessage message.channel.id,
        """:x: Lệnh của Sim đã được đổi thành .#{client.config.prefix}!"""


module.exports.help = {
    name: "setprefix",
    onlyMod: true
}