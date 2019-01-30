const express = require('express');
const pool= require('../../pool.js');
var router = express.Router();
module.exports=router;
router.get("/",(req,res)=>{
    pool.query("SELECT * FROM xfn_settings LIMIT 1",(err,result)=>{
        if(err) throw err;
        res.send(result[0]);
    })
})

/*
PUT /admin/settings
修改全局设置信息
*/ 
router.put("/",(req,res)=>{
    pool.query("UPDATE xfn_settings SET ?",req.body,(err,result)=>{
        if(err) throw err;
        res.send({code:200,msg:'settings updated succ'});
    })
})