"""test-paramiko"""
import paramiko
from time import sleep
def main():
    """test-paramiko"""
    ip = "172.31.109.4"
    username = "admin"
    my_key = paramiko.RSAKey.from_private_key_file("/home/devasc/.ssh/id_rsa")
    
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(
        hostname=ip,
        username=username,
        disabled_algorithms={"pubkeys": ["rsa-sha2-256", "rsa-sha2-512"]},
        pkey=my_key,
    )
    session = client.invoke_shell()
    session.send(b"conf t\n")
    session.send(b"int g0/1\n")
    session.send(b"vrf forwarding control-data\n")
    session.send(b"ip address 192.168.2.2 255.255.255.0\n")
    session.send(b"no shut\n")
    session.send(b"exit\n")
    
    # session.send(b"conf t\n")
    session.send(b"int g0/2\n")
    session.send(b"vrf forwarding control-data\n")
    session.send(b"ip address 192.168.3.1 255.255.255.0\n")
    session.send(b"no shut\n")
    session.send(b"exit\n")
    
    # session.send(b"conf t\n")
    session.send(b"int g0/3\n")
    session.send(b"vrf forwarding control-data\n")
    session.send(b"ip address dhcp\n")
    session.send(b"no shut\n")
    session.send(b"end\n")
        
    session.send(b"sh ip route vrf control-data\n")
    sleep(10)
    output = session.recv(65535).decode('utf-8')
    print(output.strip())
main()
