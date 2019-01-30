/*
桌台相关的路由器
*/
const express = require('express');
const pool= require('../../pool.js');
var router = express.Router();
module.exports=router;
/*
GET/admin/table
获取桌台相关信息
*/ 
router.get("/",(req,res)=>{
    pool.query("SELECT * FROM xfn_table ORDER BY tid",(err,result)=>{
        if(err) throw err;
        res.send(result);
    })
})

