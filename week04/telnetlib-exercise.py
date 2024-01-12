"""telnetlib-exercise"""
import telnetlib
import time

def main():
    """telnetlib-exercise"""
    IP = '172.31.109.3'
    USERNAME = 'admin'
    PASSWORD = 'cisco'
    # COMMAND = ['show ip int br', 'configure terminal', 'exit']
    COMMAND = ['int ', 'vrf forwarding control-data', 'ip address ', 'no shut', 'end']
    # COMMAND_g0_2 = ['int g0/2', 'vrf forwarding control-data', 'ip address 192.168.2.1 255.255.255.0', 'no shut', 'exit']
    tn = telnetlib.Telnet(IP)
    tn.read_until(b'Username: ')
    tn.write(USERNAME.encode('ascii') + b'\n')
    tn.read_until(b'Password: ')
    tn.write(PASSWORD.encode('ascii') + b'\n')
    for i in range(2):
        tn.write(b'conf t\n')
        for command in COMMAND:
            if command == 'int ':
                if i == 0:
                    command = command + 'g0/1'
                else:
                    command = command + 'g0/2'
            if command == 'ip address ':
                if i == 0:
                    command = command + '192.168.1.1 255.255.255.0'
                else:
                    command = command + '192.168.2.1 255.255.255.0'
            tn.write(b'%s\n' % command.encode('ascii'))
            time.sleep(2)
    tn.write(b'sh ip vrf interfaces control-data\n')
    tn.write(b'exit\n')
    output = tn.read_all()
    # output = tn.read_very_eager()
    print(output.decode('ascii'))

main()
