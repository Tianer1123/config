如何在一台电脑上配置多个git账号
===

去掉全局配置
---

``` sh
git config --global --unset user.name
git config --global --unset user.email
```
为每个账户生成一个秘钥
---
以github和gitlab为例。

github账户:
```sh
cd ~/.ssh
ssh-keygen -t rsa -C "youremail@domain.com"
```
输入完成后提示如下：
```sh
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/liugui/.ssh/id_rsa):
```
默认生成 `id_rsa` 文件，我们改成其他用于区分的文件名: `id_rsa_github` 。这样生成 `id_rsa_github` 和 `id_rsa_github.pub` 两个文件。

gitlab账户:
同理，用自己的邮箱生成key。名称可以写为: `id_rsa_gitlab` 。


添加私钥到本地:
---

``` sh
ssh-add ~/.ssh/id_rsa_github # 将GitHub私钥添加到本地
ssh-add ~/.ssh/id_rsa_gitlab # 将GitLab私钥添加到本地
ssh-add -l                   # 验证是否成功
```

配置config
---
``` sh
touch config
```
输入如下内容:
``` sh
Host github # 网站的别名，随意取
HostName github.com # 托管网站的域名
User youname # 托管网站上的用户名
IdentityFile ~/.ssh/id_rsa_github # 使用的密钥文件

// GitLab的配置相同
Host gitlab
HostName gitlab.com
User yourname
IdentityFile ~/.ssh/id_rsa_gitlab
```

公钥添加到github和gitlab
---
将对应的公钥添加到对应的git上。


验证:

``` sh
ssh -T git@github.com
ssh -T git@github
```

使用
---
以前的仓库，需要在仓库内部配置邮箱和用户名。
``` sh
git config user.name "yourname"
git config user.email "youremail"
```

然后
``` sh
cd .git        # 该目录是隐藏的，ls命令不可见，但是可以直接进入，如果是新建的文件夹需要先执行git init
vim config
```

添加如下信息，主要是改为别名。

``` sh
[remote "origin"]
        url = git@gitlab:GuiLiu/test.git
        fetch = +refs/heads/*:refs/remotes/origin/*
```
