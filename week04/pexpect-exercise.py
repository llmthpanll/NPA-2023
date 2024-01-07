"""pexpect"""
import pexpect

def main():
    """pexpect"""
    PROMPT = '#'
    router_id = [1, 2]
    routers_ip = ['172.31.109.3', '172.31.109.4']
    USERNAME = 'admin'
    PASSWORD = 'cisco'
    COMMAND = ['configure terminal', 'int loop 0', 'ip address ', 'no shut', 'end']
    test_command = "sh ip int bri"
    
    for rid, rip in zip(router_id, routers_ip):
        loopback_ip = f"172.16.{rid}.{rid}"
        child = pexpect.spawn('telnet ' + rip)
        child.expect('Username:')
        child.sendline(USERNAME)
        child.expect('Password:')
        child.sendline(PASSWORD)
        child.expect(PROMPT)
        for command in COMMAND:
            if command == 'ip address ':
                command = command + loopback_ip + ' 255.255.255.255'
            child.sendline(command)
            child.expect(PROMPT)
        child.sendline(test_command)
        child.expect(PROMPT)
        result = child.before
        expected_result = ["Loopback0", loopback_ip]
        success = test(result, expected_result)
        if success:
            print(f"{expected_result[0]} {expected_result[1]} is created on {rip}")
        else:
            print(f"Fail to create {expected_result[0]} {expected_result[1]} on {rip}")
        # print(result.decode('utf-8'))
        child.sendline('exit')

def test(result, expected_result):
    result = result.decode("UTF-8")
    result_list = result.split("\n")
    success = False
    for result in result_list:
        if len(result.split()) == 6:
            interface, ip_address, ok, method, status, protocol = result.split()
            if interface == expected_result[0] and ip_address == expected_result[1] and ok == 'YES' and method == 'manual' and status == 'up' and protocol == 'up':
                success = True
    return success

main()
