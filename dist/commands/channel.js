// Generated by CoffeeScript 2.7.0
module.exports.run = function(client, message, args) {
  var simchannel;
  // Check if there is already a channel
  simchannel = client.db.get("serversChannels").value()[message.channel.guild.id];
  if (simchannel !== message.channel.id || simchannel === null) {
    client.db.set(`serversChannels.${message.channel.guild.id}`, message.channel.id).write();
    return client.createMessage(message.channel.id, `Sim sẽ trả lời trong channel này (<#${message.channel.id}>)!`);
  } else {
    //return client.createMessage(message.channel.id, `Sim đã ở đây rồi (<#${message.channel.id}>)!`);
      client.db.set(`serversChannels.${message.channel.guild.id}`,"").write();
      return client.createMessage(message.channel.id, `Sim sẽ không chat ở channel (<#${message.channel.id}>) nữa!`);
  }
};

module.exports.help = {
  name: "channel",
  onlyMod: true
};
