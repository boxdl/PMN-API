import requests
import time
import os

master_ip = 'mc.wanys.xyz:5005'
download_dir = 'downloads'
if not os.path.exists(download_dir):
    os.makedirs(download_dir)

def get_all_nodes():
    """
    请求主控获取所有节点的 IP 地址
    """
    try:
        response = requests.get(f'http://{master_ip}/all_nodes')
        if response.status_code == 200:
            return response.json()
        else:
            print("无法获取节点列表")
            return []
    except requests.ConnectionError:
        print("无法连接到主控")
        return []

def ping_node(ip):
    """
    Ping 节点，返回响应时间
    """
    start_time = time.time()
    try:
        response = requests.get(f'http://{ip}/ping', timeout=2)
        if response.status_code == 200:
            return time.time() - start_time
    except requests.RequestException:
        return float('inf')

def get_best_node(nodes):
    """
    选择响应时间最短的节点
    """
    best_node = None
    best_time = float('inf')
    for ip in nodes:
        response_time = ping_node(ip)
        if response_time < best_time:
            best_time = response_time
            best_node = ip
    return best_node

def list_files(ip):
    """
    请求节点返回节点文件列表
    """
    try:
        response = requests.get(f'http://{ip}/files')
        if response.status_code == 200:
            return response.json()
        else:
            print(f"无法获取节点 {ip} 的文件列表")
            return []
    except requests.ConnectionError:
        print(f"无法连接到节点 {ip}")
        return []

def download_file(ip, file_name):
    """
    从节点下载文件
    """
    try:
        response = requests.get(f'http://{ip}/download', params={'file_name': file_name}, stream=True)
        if response.status_code == 200:
            file_path = os.path.join(download_dir, file_name)
            with open(file_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=1024):
                    f.write(chunk)
            print(f"文件 {file_name} 从节点 {ip} 下载成功")
        else:
            print(f"无法从节点 {ip} 下载文件 {file_name}")
    except requests.ConnectionError:
        print(f"无法连接到节点 {ip}")

if __name__ == "__main__":
    nodes = get_all_nodes()
    if not nodes:
        print("没有可用的节点")
        exit(1)

    best_node = get_best_node(nodes)
    if not best_node:
        print("没有可用的节点")
        exit(1)

    print(f"选择的最佳节点: {best_node}")
    files = list_files(best_node)
    if not files:
        print(f"节点 {best_node} 没有可用的文件")
        exit(1)

    print("可用文件列表:")
    for i, file_name in enumerate(files):
        print(f"{i + 1}. {file_name}")

    file_index = int(input("选择要下载的文件编号: ")) - 1
    if file_index < 0 or file_index >= len(files):
        print("无效的文件编号")
        exit(1)

    download_file(best_node, files[file_index])
