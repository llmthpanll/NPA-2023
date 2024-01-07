"""pexpect"""
import pexpect

def main():
    """pexpect"""
    PROMPT = '#'
    ip = '172.31.109.1'
    username = 'admin'
    password = 'cisco'
    command = 'show ip int brief'
    child = pexpect.spawn('telnet ' + ip)
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

main()
