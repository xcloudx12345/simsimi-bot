const express = require('express');
const server = express();
const { ReplitKill } = require('replit-kill');
server.all(`/`, (req, res) => {
    res.send(`Bé Sim online!.`);
});

function keepAlive() {
    server.listen(3000, () => {
        console.log(`Server is now ready! | ` + new Date().toLocaleString());
    });
}
module.exports = keepAlive;