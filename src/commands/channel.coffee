module.exports.run = (client, message, args) ->

    # Check if there is already a channel
    simchannel = client.db.get("serversChannels").value()[message.channel.guild.id]
    if (simchannel?){ ... }
    client.db.set("""serversChannels.#{message.channel.guild.id}""", message.channel.id)
    .write()

    return client.createMessage message.channel.id,
    """
    Sim sẽ trả lời trong channel này (<##{channel.id}>)!
    """


module.exports.help = {
    name: "channel",
    onlyMod: true
}