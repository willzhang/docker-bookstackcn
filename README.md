# bookstack简介

BookStack，基于MinDoc，使用Beego开发的在线文档管理系统，功能类似Gitbook和看云。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210220155920809.png)


官网： [http://www.bookstack.cn](http://www.bookstack.cn)

项目地址：[https://github.com/TruthHun/BookStack](https://github.com/TruthHun/BookStack)


## docker部署bookstack

1、运行mysql容器

使用官方最新版本mysql镜像，根据实际情况修改数据库root密码，数据库名及登录用户名密码

```shell
docker run -d --name mysql \
  --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=bookstack \
  -e MYSQL_USER=bookstack \
  -e MYSQL_PASSWORD=bookstack123 \
  -v mysql:/var/lib/mysql \
  mysql --default-authentication-plugin=mysql_native_password
```

2、下载并修改bookstack配置文件

获取对应release版本配置文件：[https://github.com/TruthHun/BookStack/tree/v2.9/conf](https://github.com/TruthHun/BookStack/tree/v2.9/conf)

```shell
app.conf.example
oauth.conf.example
oss.conf.example
```

复制conf至本地/data/bookstack/目录下，该目录可自定义，配置文件重命名为xxx.conf，需要挂载到容器中：

```shell
mkdir -p /data/bookstack/conf
```

修改app.conf，这里仅修改了数据库连接信息：

```shell
# cat /data/bookstack/conf/app.conf |grep db
db_adapter=mysql
db_host=172.29.118.192
db_port=3306
db_username=bookstack
db_password=bookstack123
db_database=bookstack
```
注意：db_host为主机IP地址

3、运行bookstack容器

```shell
docker run -d --name bookstack \
  --restart always \
  -p 8181:8181 \
  -v /data/bookstack/conf:/bookstack/conf \
  willdockerhub/bookstack:v2.9_node
```

浏览器访问bookstack：[http://192.168.1.1:8181](http://192.168.1.1:8181)

默认管理员账号和密码为 admin/admin888

点击右侧管理员，选择我的项目，添加项目，然后选择编辑文档，完成后点击保存内容并发布书籍，即可阅读书籍内容：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210220171108534.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25ldHdvcmtlbg==,size_16,color_FFFFFF,t_70)
## 清理部署环境
```shell
docker stop bookstack && docker rm bookstack
docker stop mysql && docker rm mysql && docker volume rm mysql
```
