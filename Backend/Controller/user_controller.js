/*
Kelompok 18 UAS-Flutter
Judul : Aplikasi Penjualan Skincare


1. Nadia Putri 19411027
2. Sephia Tasya Fabilla 19411029
*/

const userModel = require('../Model/model_user')
const response = require('../Config/response')
const bcrypt = require('bcrypt')


//Mebuat Fungsi Registrasi
exports.register = (data) =>
  new Promise((resolve, reject) => {
    userModel.findOne({
      email: data.email
    }).then((user) => {
      if (user) {
        reject(response.errorResponse('E-Mail Sudah Digunakan'))
      } else {
        bcrypt.hash(data.password, 10, (err, hash) => {
          data.password = hash
          userModel.create(data)
            .then(() => {
              resolve(response.suksesResponse('Berhasil Registrasi'))
            }).catch(() => {
              reject(response.errorResponse('Gagal Registrasi'))
            })
        })
      }
    })
  })

  
// Membuat Fungsi Login
exports.login = (data) =>
  new Promise((resolve, reject) => {
    userModel.findOne({
      email: data.email
    }).then(user => {
      if (user) {
        if (bcrypt.compareSync(data.password, user.password)) {
          resolve(Object.assign(response.suksesResponse('Berhasil Login'), {
            user: user
          }))
        } else {
          reject(response.errorResponse('Password Salah'))
        }
      } else {
        reject(response.errorResponse('Email Salah Atau Tidak Terdaftar'),
        )
      }
    })
  })