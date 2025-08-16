from faker import Faker
import random
import csv
from datetime import datetime, timedelta

fake = Faker()


# 生成CSV文件
def generate_traffic_csv(filename, num_rows=1000):
    # 定义可能的协议和状态码
    protocols = ['TCP', 'UDP', 'HTTP', 'HTTPS', 'ICMP']
    methods = ['GET', 'POST', 'PUT', 'DELETE', 'HEAD']
    status_codes = [200, 301, 302, 400, 401, 403, 404, 500]

    # 生成源IP和目标IP
    source_ips = [fake.ipv4() for _ in range(20)]
    dest_ips = [fake.ipv4() for _ in range(10)]

    # 生成时间序列
    start_time = datetime.now() - timedelta(days=1)

    with open(filename, 'w', newline='') as csvfile:
        fieldnames = ['timestamp', 'source_ip', 'destination_ip', 'protocol',
                      'method', 'path', 'status_code', 'size', 'duration']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()

        for i in range(num_rows):
            protocol = random.choice(protocols)
            method = random.choice(methods) if protocol in ['HTTP', 'HTTPS'] else ''
            path = '/' + fake.uri_path() if protocol in ['HTTP', 'HTTPS'] else ''

            writer.writerow({
                'timestamp': (start_time + timedelta(seconds=i * 5)).strftime('%Y-%m-%d %H:%M:%S'),
                'source_ip': random.choice(source_ips),
                'destination_ip': random.choice(dest_ips),
                'protocol': protocol,
                'method': method,
                'path': path,
                'status_code': random.choice(status_codes) if protocol in ['HTTP', 'HTTPS'] else '',
                'size': random.randint(100, 5000),
                'duration': round(random.uniform(0.01, 2.0), 3)
            })


# 生成日志文件
def generate_log_file(filename, num_entries=500):
    methods = ['GET', 'POST', 'PUT', 'DELETE']
    status_codes = [200, 301, 302, 400, 401, 403, 404, 500]
    paths = ['/index.html', '/api/data', '/images/logo.png', '/static/css/style.css', '/login']

    with open(filename, 'w') as f:
        for _ in range(num_entries):
            ip = fake.ipv4()
            timestamp = fake.date_time_this_month().strftime('[%d/%b/%Y:%H:%M:%S %z]')
            method = random.choice(methods)
            path = random.choice(paths)
            status = random.choice(status_codes)
            size = random.randint(100, 5000)

            log_entry = f'{ip} - - {timestamp} "{method} {path} HTTP/1.1" {status} {size}\n'
            f.write(log_entry)


# 生成示例文件
generate_traffic_csv('network_traffic.csv', 1000)
generate_log_file('access.log', 500)

print("已生成示例文件: network_traffic.csv 和 access.log")