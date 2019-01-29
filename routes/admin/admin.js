/*管理员相关*/
const express = require('express');
const pool= require('../../pool.js');
var router = express.Router();
module.exports=router;
 
/*
 API:GET /admin/login
 请求数据：{aname:'xxx',apwd:'xxx'}
 完成用户登录验证(提示：有登录日志的情况下使用post)
 返回数据:
 {code:200,msg:'login succ'}
{code:400,msg:'aname or apwd no exits'}
*/
router.get('/login',(req,res)=>{
    pool.query("SELECT aid FROM xfn_admin WHERE aname=? AND apwd=PASSWORD(?)",[req.query.aname,req.query.apwd],(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            res.send({code:200,msg:'login succ'})
        }else{
            res.send({code:400,msg:'aname or apwd no exits'})
        }
    })
})

/*
 API:PATCH /admin/login
 请求数据：{aname:'xxx',oldPwd:'xxx',newPwd:'xxx'}
 根据管理员名和密码修改管理员密码
 返回数据:
 {code:200,msg:'modified succ'}
{code:400,msg:'aname or apwd err'}
{code:401,msg:'apwd not modified'}
*/
router.patch("/",(req,res)=>{
    var data=req.body;
    pool.query("SELECT aid FROM xfn_admin WHERE aname=? AND apwd=PASSWORD(?)",[data.aname,data.oldPwd],(err,result)=>{
        if(err) throw err;
        if(result.length>0){
            pool.query("UPDATE xfn_admin SET apwd=PASSWORD(?) WHERE aname=?",[data.newPwd,data.aname],(err,result)=>{
                if(err) throw err;
                if(result.changedRows>0){
                    res.send({code:200,msg:'modified succ'})
                }else{
                    res.send({code:401,msg:'apwd not modified'})
                }
            })
        }else{
            res.send({code:400,msg:"apwd err"})
        }
    })
})
