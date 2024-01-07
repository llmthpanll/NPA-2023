"""pexpect"""
import pexpect

def main():
    """pexpect"""
    PROMPT = '#'
    IP = '172.31.109.3'
    USERNAME = 'admin'
    PASSWORD = 'cisco'
    COMMAND = ['show ip int br', 'configure terminal']
    
    child = pexpect.spawn('telnet ' + IP)
    child.expect('Username:')
    child.sendline(USERNAME)
    child.expect('Password:')
    child.sendline(PASSWORD)
    child.expect(PROMPT)
    
    # for i in range(len(COMMAND)):
    #     child.sendline(COMMAND[i])
    #     child.expect(PROMPT)
    child.sendline(COMMAND[1])
    child.expect(PROMPT)
    result = child.before
    # print(result)
    # print()
    print(result.decode('utf-8'))
    child.sendline('exit')
    # child.sendline('exit')

main()
