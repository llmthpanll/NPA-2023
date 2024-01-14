"""telnetlib-exercise"""
import telnetlib
import time

def main():
    """telnetlib-exercise"""
    IP = '172.31.109.3'
    USERNAME = 'admin'
    PASSWORD = 'cisco'
    COMMAND = ['int ', 'vrf forwarding control-data', 'ip address ', 'no shut', 'end']
    tn = telnetlib.Telnet(IP)
    tn.read_until(b'Username: ')
    tn.write(USERNAME.encode('ascii') + b'\n')
    time.sleep(1)
    tn.read_until(b'Password: ')
    tn.write(PASSWORD.encode('ascii') + b'\n')
    time.sleep(1)
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
    time.sleep(2)
    output = tn.read_very_eager()
    output = output.decode("ascii")
    output = output.split()
    expected_ip = {"Gi0/1": "192.168.1.1", "Gi0/2": "192.168.2.1"}
    for intf in expected_ip.keys():
        try:
            found_intf = output.index(intf)
            found_ip = output[found_intf + 1]
            if found_ip == expected_ip[intf]:
                print(f"{found_ip} of {intf} is assigned to VRF control-data")
            else:
                print("Wrong IP.")
        except Exception as e:
            print(e)

main()
