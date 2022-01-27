module.exports.run = (client, message, args) ->
    # Reply
    client.createMessage message.channel.id,
    """
    :information_source: Danh sách lệnh:
    `#{client.config.prefix}chat <nội dung>` - Nói chuyện với Sim
    `#{client.config.prefix}ping` - Kiểm tra độ trễ của bot
    `#{client.config.prefix}lang` - Đổi ngôn ngữ bot
    `#{client.config.prefix}channel` - Set một channel có sẵn để nói chuyện với Sim không cần lệnh
    `#{client.config.prefix}create-channel` - Tạo channel để nói chuyện với Sim không cần lệnh
    `#{client.config.prefix}setprefix <lệnh mới>` - Đổi lệnh gọi Sim
    """

module.exports.help = {
    name: "help",
    onlyMod: false
}