/*
Kelompok 18 UAS-Flutter
Judul : Aplikasi Penjualan Skincare


1. Nadia Putri 19411027
2. Sephia Tasya Fabila 19411029
*/

"use strict";
const router = require("express").Router();
const Controller = require("../Controller/skincare_controller");

//Create atau Menambahkan data di controller
router.post("/add", (req, res) => {
  Controller.add(req.body)
    .then((result) => res.json(result))
    .catch((err) => res.json(err));
});

//Mengambil semua Data yang ada di data skincare
router.get("/get", (req, res) => {
  Controller.get(req.body)
    .then((result) => res.json(result))
    .catch((err) => res.json(err));
});

//menghapus data skincare
router.delete("/delete/:id", Controller.delete);

//Update Data skin care menggunakan id
router.put("/update/:id", Controller.update);

module.exports = router;
