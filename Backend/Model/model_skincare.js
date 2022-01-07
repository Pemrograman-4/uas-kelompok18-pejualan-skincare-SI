const mongoose = require('mongoose')
const Schema = mongoose.Schema
const ClientSchema = new Schema({
    namaProduk: { 
        type: String 
    },
    jenis: { 
        type: String 
    },
    stok: { 
        type: String
    },
    harga: { 
        type: String 
    },
    deskripsi: { 
        type: String 
    },
    date: { type: Date, default: Date.now }

})
module.exports = mongoose.model('skincare', ClientSchema)