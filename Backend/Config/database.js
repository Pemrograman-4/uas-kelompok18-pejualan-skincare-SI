const mongoose = require('mongoose')
const mongoURL ='mongodb://localhost:27017/skincare';
mongoose.connect(mongoURL,
    err => {
        if(err) throw err;
        console.log('Success Ke Database MONGODB')
    });