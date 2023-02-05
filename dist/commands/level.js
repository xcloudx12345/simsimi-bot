module.exports.run = function(client, message, args) {
    // Lấy giá trị level hiện tại
    let currentLevel = client.db.get("serverLevel").value()[message.channel.guild.id];
    console.log(currentLevel)
    if (!args[0]) {
        return client.createMessage(message.channel.id, `Độ nói nhiều của Sim hiện tại là: ${currentLevel}. Để thay đổi dùng lệnh ;level <số level từ 1-10>`);
    }

    if (isNaN(args[0]) || args[0] < 1 || args[0] > 10) {
        return client.createMessage(message.channel.id, ':x: Bạn phải nhập số từ 1 đến 10, tương ứng với độ mất dạy tăng dần!');
    }

    // Lưu giá trị mới
    client.db.set(`serverLevel.${message.channel.guild.id}`, args[0]).write();

    // Reply
    return client.createMessage(message.channel.id, `Đã đặt nói nhiều của Sim là: ${args[0]}.`);
};

module.exports.help = {
    name: "level",
    onlyMod: true
};