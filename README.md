## 同步DockerHub上的镜像仓库到阿里云镜像仓库

DockerHub域名被封杀，无法直接访问拉取镜像。国内的镜像源又宣布停止服务，所以需要一个工具将将DockerHub上的镜像同步到阿里云镜像仓库。

阿里云镜像仓库提供了个人实例服务，支持最多创建300个仓库，而且免费。个人使用完全够满足需求。

阿里云镜像仓库地址： [https://cr.console.aliyun.com/](https://cr.console.aliyun.com/)

## Copy.yml 运行介绍

![Run Copy workflow](assets/copy.jpg)

这个工具主要是将 DockerHub 上某个仓库下的某个标签同步到阿里云镜像仓库。

1. 使用阿里云开通个人实例服务，并获取 [登录用户名和固定密码](https://cr.console.aliyun.com/cn-hangzhou/instance/credentials)

2. 克隆本仓库，在仓库设置中配置阿里云密码，注意 *Name* 必须为 `DESTINATION_CREDENTIAL` 且内容格式必须为 `<Username>:<Password>` 即用户名和密码之间用冒号分隔。

![配置密码页面](assets/settings-actions-secrets.jpg)

![配置内容](assets/new-secret.jpg)

3. 在 *Actions* 页面上选择 *copy.yml* 点击 *Run workflow* 填写内容即可运行。

> 填写说明：
>
> 如同步 DockerHub 上的 nginx:1.13 到 阿里云镜像仓库 registry.cn-beijing.aliyuncs.com/ikrong/nginx:1.13，则填写如下：
>
> ```yaml
> source: docker.io
> destination: registry.cn-beijing.aliyuncs.com
> source_repo: nginx:1.13
> destination_repo: ikrong/nginx:1.13
> ```

## Sync.yml 运行介绍

这个工具主要是将 DockerHub 上某个仓库下的所有标签全部同步到阿里云镜像仓库。

![RUN Sync workflow](assets/sync.jpg)

1. 配置密码同上

2. 在 *Actions* 页面上选择 *sync.yml* 点击 *Run workflow* 填写内容即可运行。

> 填写说明：
>
> 如同步 DockerHub 上的 nginx 的所有标签到阿里云镜像仓库 registry.cn-beijing.aliyuncs.com/ikrong/nginx，则填写如下：
>
> ```yaml
> source: docker.io
> destination: registry.cn-beijing.aliyuncs.com
> source_repo: nginx
> destination_scope: ikrong
> ```
