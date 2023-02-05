module.exports.run = (client, message, args) ->

    # Check if there is already a channel
    channel = await message.channel.guild.createChannel("Bé Sim nhiều chuyện", 0, {
        topic: """Trò chuyện với <@#{client.user.id}> !""",
        nsfw: false,
        rateLimitPerUser: 5
    })
    client.db.set("""serversChannels.#{message.channel.guild.id}""", channel.id)
    .write()

    return client.createMessage message.channel.id,
    """
    Đã tạo xong channel của Sim (<##{channel.id}>)!
    """


module.exports.help = {
    name: "create-channel",
    onlyMod: true
}