# Load config
config = require("../config.json")
# Create Discord Client
Eris = require("eris")
client = new Eris(process.env.TOKEN)
client.commands = []
client.config = config
emojic = require("discord-emoji-converter")
# Create Simsimi Client
Simsimi = require("./simsimi")
client.simsimi = new Simsimi config.simsimi

# Init database
lowdb = require("lowdb")
FileSync = require("lowdb/adapters/FileSync")
adapter = new FileSync('./db.json')
db = lowdb(adapter)
db.defaults({ chatUses: {}, serversLanguages: {}, serversChannels: {} ,serversPrefix: {}})
.write()
client.db = db

# Load commands
fs = require("fs")
fs.readdir """#{__dirname}/commands""", (err, data) ->
    if not data then return console.log """Không tìm thấy lệnh..."""
    data.forEach (filePath) ->
        cmdData = require("""#{__dirname}/commands/#{filePath}""")
        client.commands.push({
            name: cmdData.help.name,
            onlyMod: cmdData.help.onlyMod,
            run: cmdData.run
        })
        console.log """Loading Command: #{cmdData.help.name} 👌"""
    console.log """Loading a total of #{client.commands.length} commands!"""
    
   
client.on 'ready', ->
    console.log """
        Logged as #{client.user.username}##{client.user.discriminator}
    """
    
client.on 'messageCreate', (message) ->
 
    # Ignore bots
    if message.author.bot or not message.channel then return

    guildChannel = client.db.get("serversChannels").value()[message.channel.guild.id]
    if guildChannel and message.channel.id is guildChannel
    
        # Check uses
        userData = client.db.get("chatUses").value()[message.author.id] or 0
        if userData > client.config.maxRequestPerUser
            return client.createMessage message.channel.id,
            """:x: Bạn hành sim quá nhiều, sim đã nghỉ chơi bạn rồi!..."""

        # Try to get guild language
        guildLanguage = client.db.get("serversLanguages").value()[message.channel.guild.id]

        # Make the request
        res = await client.simsimi.request(message.content, guildLanguage)
        if not res.message
            return message.addReaction "😢"
        if res.message == "error"
            return client.createMessage message.channel.id,
            """:x: đừng gửi emo hông hiểu má ơi!..."""
            
        if /bố m là ai|bố mày là ai|ba m là ai|ba mày là ai/.test(message.content.toLowerCase())
            return client.createMessage message.channel.id,
            """Là Pikachu chứ ai!!!"""
        # Reply
        client.createMessage message.channel.id,
        """#{res.message_info.message_reply}"""

        # Save uses
        client.db.set("""chatUses.#{message.author.id}""", userData + 1)
        .write()


    if not message.content.startsWith config.prefix then return

    args = message.content.slice(config.prefix.length).trim().split(/ +/g)
    command = args.shift().toLowerCase()

    commandFound = client.commands.find (cmdData) -> cmdData.name is command
    if not commandFound
        client.createMessage message.channel.id,
        """Sai lệnh. Gõ `#{config.prefix}help` để xem lệnh."""
    else
        if commandFound.onlyMod and not message.member.permission.json.manageMessages
            return client.createMessage message.channel.id, ":x: QTV mới xài được lệnh này"
        if commandFound.name is "eval" and message.author.id isnt config.owner
            return client.createMessage message.channel.id,
            ":x: Chỉ có Pikachu mới xài được lệnh này"
        commandFound.run client, message, args


# Login to Discord

client.connect()

express = require "express"

app = express()

app.get('/', (req, res) => res.send('Hello World!'))

app.listen 3000