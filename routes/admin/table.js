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

/*
POST/admin/table
增加桌台相关信息
*/ 
router.post("/",(req,res)=>{
    pool.query("INSERT INTO xfn_table SET ?",req.body,(err,result)=>{
        if(err) throw err;
        res.send({code:200,msg:"added table succ"});
    })
})

/*
DELETE/admin/table
删除桌台相关信息
*/ 
router.delete("/:tid",(req,res)=>{
    pool.query("DELETE FROM xfn_table WHERE tid=?",req.params.tid,(err,result)=>{
        if(err) throw err;
        res.send({code:200,msg:"deleted table succ"});
    })
})

