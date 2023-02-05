var Simsimi, mess;
const freesimi = require('freesimi');

Simsimi = class Simsimi {
    async doPostRequest(content, language, level) {
        try {
            const uid = await freesimi.initUser();
            const result = await freesimi.talk(content, language, parseInt(level), uid);
            console.log('=======\nChat: ' + content);
            console.log('Trả lời: ' + result.sentence);
            mess = result.sentence;
        } catch (error) {
            console.error(error);
            mess = null;
        }
        return mess;
    }
};

module.exports = Simsimi;