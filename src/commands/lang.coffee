module.exports.run = (client, message, args) ->

    languages = [
        ["vn", "Việt Nam"],
        ["en", "English"],
        ["fr", "Français"],
        ["it", "Italiano"],
        ["es", "español"],
        ["jp", "Japan"],
        ["ru", "Russia"]
        ["...", "..."]
    ]
    formattedLanguage = languages.map((l) -> """`#{l[0]}` (#{l[1]})""").join "\n"

    # Check if there is a new lang
    if not args[0] or not languages.some (l) -> l[0] is args[0]
        return client.createMessage message.channel.id,
        """
        :x: Bạn phải nhập đúng kiểu ngôn ngữ!
        Các mã ngôn ngữ ví dụ:
        #{formattedLanguage}
        """

    # Change the language
    client.db.set("""serversLanguages.#{message.channel.guild.id}""", args[0])
    .write()
    
    # Reply
    client.createMessage message.channel.id,
        """
        Sim sẽ trả lời bằng tiếng `#{languages.find((l) -> l[0] is args[0])[1]}`
        """


module.exports.help = {
    name: "lang",
    onlyMod: true
}