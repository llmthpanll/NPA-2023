"""wexpect"""
import wexpect

def main():
    """wexpect"""
    PROMPT = '#'
    ip = '172.31.109.1'
    username = 'admin'
    password = 'cisco'
    command = 'show ip int brief'
    # child = wexpect.spawn('telnet ' + ip)
    child = wexpect.spawn('telnet ' + ip) # type: ignore
    child.expect('Username:')
    child.sendline(username)
    child.expect('Password:')
    child.sendline(password)
    child.expect(PROMPT)
    child.sendline(command)
    child.expect(PROMPT)
    result = child.before
    print(result)
    print()
    print(result.decode('utf-8'))
    child.sendline('exit')
    child.close()

main()
