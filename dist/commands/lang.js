module.exports.run = function(client, message, args) {
    let currentLang = client.db.get("serversLanguages").value()[message.channel.guild.id];
    const languages = [["vi", "Việt Nam"], ["en", "English"], ["fr", "Français"], ["it", "Italiano"], ["es", "español"], ["jp", "Japan"], ["ru", "Russia"], ["...", "..."]];
    const formattedLanguage = languages.map(l => `\`${l[0]}\` (${l[1]})`).join("\n");
    let clang = languages.find(l => l[0] === currentLang)[1];
    if (!args[0]) {
        if (!currentLang) {
            return client.createMessage(message.channel.id, `Vui lòng chọn ngôn ngữ để Sim trả lời bạn!
Các mã ngôn ngữ ví dụ:${formattedLanguage}`);
        } else {
            return client.createMessage(message.channel.id, `Ngôn ngữ hiện tại là: \`${clang}\``);
        }
    }

    if (!languages.some(l => l[0] === args[0])) {
        return client.createMessage(message.channel.id, `:x: Bạn phải nhập đúng kiểu ngôn ngữ!
Các mã ngôn ngữ ví dụ:
${formattedLanguage}`);
    }

    client.db.set(`serversLanguages.${message.channel.guild.id}`, args[0]).write();
    const selectedLanguage = languages.find(l => l[0] === args[0])[1];
    return client.createMessage(message.channel.id, `Sim sẽ trả lời bằng tiếng \`${selectedLanguage}\``);
};

module.exports.help = {
    name: "lang",
    onlyMod: true
};
