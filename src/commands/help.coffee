module.exports.run = (client, message, args) ->
    # Reply
    client.createMessage message.channel.id,
    """
    :information_source: Here is the command list:
    `#{client.config.prefix}chat` - Nói chuyện với Sim
    `#{client.config.prefix}ping` - Kiểm tra độ trễ của bot
    `#{client.config.prefix}lang` - Đổi ngôn ngữ bot
    `#{client.config.prefix}channel` - Set một channel có sẵn để nói chuyện với Sim không cần lệnh
    `#{client.config.prefix}create-channel` - Tạo channel để nói chuyện với Sim không cần lệnh
    """

module.exports.help = {
    name: "help",
    onlyMod: false
}