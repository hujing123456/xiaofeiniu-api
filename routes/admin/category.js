// 菜品类别相关的路由
const express = require("express");
const pool = require("../../pool.js");
var router = express.Router();

/*API:get /admin/category
含义：客户端获取所有的菜品类别，按编号升序排列
*/
router.get('/',(req,res)=>{
    pool.query('SELECT * FROM xfn_category ORDER BY cid',(err,result)=>{
        if(err) throw err;
        res.send(result);
    })
})

/*API:DELETE /admin/category/:cid
含义：根据表示菜品编号的路由参数，删除该菜品
*/
router.delete("/:cid",(req,res)=>{
    pool.query("UPDATE xfn_dish SET categoryId=NULL WHERE categoryId=?",req.params.cid,(err,result)=>{
        if(err) throw err;
        //至此指定类别的菜品已经修改完毕
        pool.query("DELETE FROM xfn_category WHERE cid=?",req.params.cid,(err,result)=>{
            if(err) throw err;
            if(result.affectedRows>0){
                res.send({code:200,msg:"1 category deleted"})
            }else{
                res.send({code:400,msg:"0 category deleted"})
            }
        })
    })
    
})

// API:POST /admin/category
// 含义：添加新的菜品类别
router.post('/',(req,res)=>{
    var data=req.body;
    pool.query("INSERT INTO xfn_category VALUES (NULL,?)",data.cname,(err,result)=>{
        if(err) throw err;
        res.send({code:200,msg:"1 category added"})
    })
})
// API:PUT /admin/category
// 含义：根据菜品类别编号修改类别
router.put('/',(req,res)=>{
    var data=req.body;
    // 此处可以对数据进行验证
    pool.query("UPDATE xfn_category SET cname=? WHERE cid=?",[data.cname,data.cid],(err,result)=>{
        if(err) throw err;
        if(result.changedRows>0){
            res.send({code:200,mag:"1 category modified"})
        }else if(result.affectedRows==0){
            res.send({code:400,msg:"category not exits"})
        }else if(result.affectedRows==1  && result.changedRows==0){
            res.send({code:401,msg:"no category modified"})
        }
    })
})

module.exports = router;