/*
菜品相关的路由
*/
const express = require('express');
const pool= require('../../pool.js');
const multer=require('multer');
const fs=require('fs');
var upload=multer({dest:'tmp/'})
var router = express.Router();
module.exports=router;

/*
API: GET /admin/dish
获取所有的菜品（按类别进行分类）
返回数据：[
    {cid:1,cname:'肉类',dishList:[{},{},{}]},
    {cid:2,cname:'菜类',dishList:[{},{},{}]}
    ....
]
*/
router.get('/',(req,res)=>{
    //查询所有的菜品类别
    pool.query("SELECT cid,cname FROM xfn_category ORDER BY cid",(err,result)=>{
        if(err) throw err;
        var categoryList =result;
        var count=0;
        for(let c of categoryList){
            pool.query('SELECT  * FROM xfn_dish WHERE categoryId=? ORDER BY did desc',c.cid,(err,result)=>{
                if(err) throw err;
                c.dishList=result;
                count++;
                if(count==categoryList.length){
                    res.send(categoryList);
                }
            })
        }
        
        
    })
})

/*
API: POST /admin/dish/image
请求参数：
接收客户端长传的菜品图片保存在服务器上，返回该图片在服务器上的随机文件名
返回数据：[
    {cid:1,cname:'肉类',dishList:[{},{},{}]},
    {cid:2,cname:'菜类',dishList:[{},{},{}]}
    ....
]
*/
router.post('/image',upload.single('dishImg'),(req,res)=>{
    console.log(req.file);
    var tmpFile=req.file.path;  //临时文件名
    var suffix=req.file.originalname.substring(req.file.originalname.lastIndexOf('.'));  //原始文件名的后缀部分
    var newFile=randFileName(suffix);  //目标文件名
    fs.rename(tmpFile,'img/dish/'+newFile,()=>{
        res.send({code:200,msg:'upload succ',fileName:newFile});

    })
})

//生成一个随机文件名
//参数：suffix表示要生成的文件名中的后缀
//形如 13165451-6545.jpg
function randFileName(suffix){
    var time=new Date().getTime(); //当前系统时间戳
    var num=Math.floor(Math.random()*(10000-1000) + 1000); //4位随机数字
    return time+'-'+num +suffix;
}
/*
API: POST /admin/dish
请求参数：{title:'xx',imgUrl:'..jpg',price:xxx,detail:'xxx',category:xx}
添加一个新的菜品
返回数据：
    {code:200,msg:'dish added succ',dishId:46},
*/
router.post('/',(req,res)=>{
    pool.query('INSERT INTO xfn_dish SET ?',req.body,(err,result)=>{
        if(err) throw err;
        res.send({code:200,msg:"dish added succ",dishId:result.insertId}) //将insert语句产生的自增编号输出给客户端
    })
})



/*
DELETE  /admin/dish/:did
根据指定的菜品编号删除该菜品
输出数据：
{code:200,msg:'dish deleted succ'}
{code:400,msg:'dish not exists'}
*/


/*
API:PUT /admin/dish
请求参数：{did:xx,title:'xx',imgUrl:'..jpg',price:xxx,detail:'xxx',category:xx}
根据指定的菜品编号修改菜品
返回数据：
    {code:200,msg:'dish updated succ'},
    {code:400,msg:'dish not exists'},
*/