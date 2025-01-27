# PMN-API
## 介绍

PMN-API 核心为P2P CDN简称PCDN，说白了就一个分布式文件存储和同步系统，此代码为节点端,申请节点需要向作者申请密钥,你启动了节点同步了文件也没用,这个项目为公益项目,提供一些文件储存,加速下载等功能

下面是一些api的接口
## 主控节点 API
## 安装教程
选择你所需要的文件夹(ip-node)是公网的用的,(node)文件夹是内网穿透的用的

### Linux/Macos
#### ```sh start.sh```

### Windows
#### <b>直接双击打开或者</b>
#### ```ba start.bat```

### 配置文件

```json
{
    "node_ip": "127.0.0.1:5000",//这个是填你公网地址和端口
    "port": 5000,//这个是启动在哪个端口
    "secret_key": ""//这个填密钥的，找作者要
}
```
### 查询文件所在节点

**URL:** `/query`  
**方法:** `GET`  
**描述:** 查询文件所在的节点。

**请求参数:**
- `file_name`: 文件名

**响应:**
```json
{
  "文件名": "file_name",
  "节点列表": ["节点IP1", "节点IP2", ...]
}
```

### 获取所有文件信息

**URL:** `/all_files`  
**方法:** `GET`  
**描述:** 获取所有在线节点的文件信息，包括主控的文件信息。

**响应:**
```json
{
  "节点IP1": ["文件名1", "文件名2", ...],
  "节点IP2": ["文件名1", "文件名2", ...],
  "master": ["文件名1", "文件名2", ...]
}
```

### 上传文件

**URL:** `/upload`  
**方法:** `POST`  
**描述:** 接收文件上传并保存文件元数据。

**请求头:**
- `Secret-Key`: 用户密钥

**请求体:** 文件

**响应:**
```json
{
  "消息": "文件 {file_name} 上传并保存元数据成功"
}
```

### 下载文件

**URL:** `/download`  
**方法:** `GET`  
**描述:** 提供文件下载接口。

**请求参数:**
- `file_name`: 文件名

**响应:** 文件流

### 获取文件哈希值

**URL:** `/file_hash`  
**方法:** `GET`  
**描述:** 获取指定文件的哈希值。

**请求参数:**
- `file_name`: 文件名

**响应:**
```json
{
  "file_hash": "文件哈希值"
}
```

### 获取所有节点

**URL:** `/all_nodes`  
**方法:** `GET`  
**描述:** 获取所有节点的 IP 地址。

**响应:**
```json
["节点IP1", "节点IP2", ...]
```
## 工作节点 API

### 节点心跳检测

**URL:** `/ping`  
**方法:** `GET`  
**描述:** 节点心跳检测。

**响应:**
```json
{
  "状态": "在线"
}
```

### 下载文件

**URL:** `/download`  
**方法:** `GET`  
**描述:** 提供文件下载接口。

**请求参数:**
- `file_name`: 文件名

**响应:** 文件流

### 列出文件

**URL:** `/files`  
**方法:** `GET`  
**描述:** 列出节点上的文件。

**响应:**
```json
["文件名1", "文件名2", ...]
```
