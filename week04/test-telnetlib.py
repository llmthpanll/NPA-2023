import telnetlib

IP = '172.31.109.3'
USERNAME = 'admin'
PASSWORD = 'cisco'

# tn = telnetlib.Telnet(IP)
# print("test2")
# tn.read_until(b'Username: ')
# print("test3")
# tn.write(USERNAME.encode('ascii') + b'\n')
# print("test4")
# tn.read_until(b'Password: ')
# print("test5")
# tn.write(PASSWORD.encode('ascii') + b'\n')
# print("test6")
# tn.write(b"sh ip vrf interfaces control-data\n")
# print("test7")
# tn.write(b'exit\n')
# print("test8")
# output = tn.read_all()
# print("test9")
# print(output.decode('ascii'))
# print("test10")



print("test1")
tn = telnetlib.Telnet(IP)
print("test2")
tn.read_until(b'Username: ')
print("test3")
tn.write(USERNAME.encode('ascii') + b'\n')
print("test4")
tn.read_until(b'Password: ')
print("test5")
tn.write(PASSWORD.encode('ascii') + b'\n')
print("test6")
tn.write(b"sh ip vrf interfaces control-data\n")
print("test7")
tn.write(b'exit\n')
print("test8")
output = tn.read_all()
print("test9")
print(output.decode('ascii'))
print("test10")