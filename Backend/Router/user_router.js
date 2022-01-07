/*
Kelompok 18 UAS-Flutter
Judul : Aplikasi Penjualan Skincare


1. Nadia Putri 19411027
2. Sephia Tasya Fabilla 19411029
*/
const router = require('express').Router()
const userController = require('../Controller/user_controller')


//menggunakan register controller ke router
router.post('/register', (req, res) => {
  userController.register(req.body)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})


//menggunakan Login ke router
router.post('/login', (req, res) => {
  userController.login(req.body)
    .then(result => res.json(result))
    .catch(err => res.json(err))
})
module.exports = router