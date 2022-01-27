module.exports.run = (client, message, args) ->

    # Check if there is a message to send
    if not args[0]
        return client.createMessage message.channel.id,
        """:x: Bạn chưa gõ gì để nói với Sim!"""

    userData = client.db.get("chatUses").value()[message.author.id] or 0
    if userData > client.config.maxRequestPerUser
        return client.createMessage message.channel.id,
        """:x: Bạn hành Sim quá trời. Sim nghỉ chơi bạn rồi..."""

    # Try to get guild language
    guildLanguage = client.db.get("serversLanguages").value()[message.channel.guild.id]

    # Make the request
    res = await client.simsimi.request(args.join(" "), guildLanguage)

    if not res.success
        return message.addReaction "😢"

    # Reply
    client.createMessage message.channel.id,
    """#{res.success}"""

    # Save uses
    client.db.set("""chatUses.#{message.author.id}""", userData + 1)
    .write()


module.exports.help = {
    name: "chat",
    onlyMod: false
}