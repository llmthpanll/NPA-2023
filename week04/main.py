"""ip route"""
def main():
    """ip route  172.30.G.160/27"""
    # 2001:db8:(0001+G)::/48
    # 2001:db8:(0001+G)::/48
    ip = 0
    for i in range(1, 26):
        # print(f"ip route 172.30.{i}.0 255.255.255.0 172.17.99.{i}")
        hex_num = hex(i)
        hex_num2 = hex(i+1)
        hex_num = hex_num[2:]
        hex_num2 = hex_num2[2:]
        # print(i,  hex_num)
        
        # print(f"ipv6 route 2001:db8:{hex_num2}::/48 2001:db8:dada:aaaa::{hex_num}")
        # print(f"2001:db8:{hex_num}::/48")
        print(f"2001:db8:dada:aaaa::{hex_num}/64")
main()


# no ip route 172.30.1.128 255.255.255.128 172.17.99.1
# no ip route 172.30.2.128 255.255.255.128 172.17.99.2
# no ip route 172.30.3.128 255.255.255.128 172.17.99.3
# no ip route 172.30.4.128 255.255.255.128 172.17.99.4
# no ip route 172.30.5.128 255.255.255.128 172.17.99.5
# no ip route 172.30.6.128 255.255.255.128 172.17.99.6
# no ip route 172.30.7.128 255.255.255.128 172.17.99.7
# no ip route 172.30.8.128 255.255.255.128 172.17.99.8
# no ip route 172.30.9.128 255.255.255.128 172.17.99.9
# no ip route 172.30.10.128 255.255.255.128 172.17.99.10
# no ip route 172.30.11.128 255.255.255.128 172.17.99.11
# no ip route 172.30.12.128 255.255.255.128 172.17.99.12
# no ip route 172.30.13.128 255.255.255.128 172.17.99.13
# no ip route 172.30.14.128 255.255.255.128 172.17.99.14
# no ip route 172.30.15.128 255.255.255.128 172.17.99.15
# no ip route 172.30.16.128 255.255.255.128 172.17.99.16
# no ip route 172.30.17.128 255.255.255.128 172.17.99.17
# no ip route 172.30.18.128 255.255.255.128 172.17.99.18
# no ip route 172.30.19.128 255.255.255.128 172.17.99.19
# no ip route 172.30.20.128 255.255.255.128 172.17.99.20
# no ip route 172.30.21.128 255.255.255.128 172.17.99.21
# no ip route 172.30.22.128 255.255.255.128 172.17.99.22
# no ip route 172.30.23.128 255.255.255.128 172.17.99.23
# no ip route 172.30.24.128 255.255.255.128 172.17.99.24
# no ip route 172.30.25.128 255.255.255.128 172.17.99.25
# no ip route 172.30.1.160 255.255.255.224 172.17.99.1
# no ip route 172.30.2.160 255.255.255.224 172.17.99.2
# no ip route 172.30.3.160 255.255.255.224 172.17.99.3
# no ip route 172.30.4.160 255.255.255.224 172.17.99.4
# no ip route 172.30.5.160 255.255.255.224 172.17.99.5
# no ip route 172.30.6.160 255.255.255.224 172.17.99.6
# no ip route 172.30.7.160 255.255.255.224 172.17.99.7
# no ip route 172.30.8.160 255.255.255.224 172.17.99.8
# no ip route 172.30.9.160 255.255.255.224 172.17.99.9
# no ip route 172.30.10.160 255.255.255.224 172.17.99.10
# no ip route 172.30.11.160 255.255.255.224 172.17.99.11
# no ip route 172.30.12.160 255.255.255.224 172.17.99.12
# no ip route 172.30.13.160 255.255.255.224 172.17.99.13
# no ip route 172.30.14.160 255.255.255.224 172.17.99.14
# no ip route 172.30.15.160 255.255.255.224 172.17.99.15
# no ip route 172.30.16.160 255.255.255.224 172.17.99.16
# no ip route 172.30.17.160 255.255.255.224 172.17.99.17
# no ip route 172.30.18.160 255.255.255.224 172.17.99.18
# no ip route 172.30.19.160 255.255.255.224 172.17.99.19
# no ip route 172.30.20.160 255.255.255.224 172.17.99.20
# no ip route 172.30.21.160 255.255.255.224 172.17.99.21
# no ip route 172.30.22.160 255.255.255.224 172.17.99.22
# no ip route 172.30.23.160 255.255.255.224 172.17.99.23
# no ip route 172.30.24.160 255.255.255.224 172.17.99.24
# no ip route 172.30.25.160 255.255.255.224 172.17.99.25
# no ipv6 route 2001:db8:2::/48 2001:db8:dada:aaaa::1
# no ipv6 route 2001:db8:3::/48 2001:db8:dada:aaaa::2
# no ipv6 route 2001:db8:4::/48 2001:db8:dada:aaaa::3
# no ipv6 route 2001:db8:5::/48 2001:db8:dada:aaaa::4
# no ipv6 route 2001:db8:6::/48 2001:db8:dada:aaaa::5
# no ipv6 route 2001:db8:7::/48 2001:db8:dada:aaaa::6
# no ipv6 route 2001:db8:8::/48 2001:db8:dada:aaaa::7
# no ipv6 route 2001:db8:9::/48 2001:db8:dada:aaaa::8
# no ipv6 route 2001:db8:a::/48 2001:db8:dada:aaaa::9
# no ipv6 route 2001:db8:b::/48 2001:db8:dada:aaaa::10
# no ipv6 route 2001:db8:c::/48 2001:db8:dada:aaaa::11
# no ipv6 route 2001:db8:d::/48 2001:db8:dada:aaaa::12
# no ipv6 route 2001:db8:e::/48 2001:db8:dada:aaaa::13
# no ipv6 route 2001:db8:f::/48 2001:db8:dada:aaaa::14
# no ipv6 route 2001:db8:10::/48 2001:db8:dada:aaaa::15
# no ipv6 route 2001:db8:11::/48 2001:db8:dada:aaaa::16
# no ipv6 route 2001:db8:12::/48 2001:db8:dada:aaaa::17
# no ipv6 route 2001:db8:13::/48 2001:db8:dada:aaaa::18
# no ipv6 route 2001:db8:14::/48 2001:db8:dada:aaaa::19
# no ipv6 route 2001:db8:15::/48 2001:db8:dada:aaaa::20
# no ipv6 route 2001:db8:16::/48 2001:db8:dada:aaaa::21
# no ipv6 route 2001:db8:17::/48 2001:db8:dada:aaaa::22
# no ipv6 route 2001:db8:18::/48 2001:db8:dada:aaaa::23
# no ipv6 route 2001:db8:19::/48 2001:db8:dada:aaaa::24
# no ipv6 route 2001:db8:1a::/48 2001:db8:dada:aaaa::25





# no ipv6 route 2001:DB8:2::/48 2001:DB8:DADA:AAAA::1
# no ipv6 route 2001:DB8:3::/48 2001:DB8:DADA:AAAA::2
# no ipv6 route 2001:DB8:4::/48 2001:DB8:DADA:AAAA::3
# no ipv6 route 2001:DB8:5::/48 2001:DB8:DADA:AAAA::4
# no ipv6 route 2001:DB8:6::/48 2001:DB8:DADA:AAAA::5
# no ipv6 route 2001:DB8:7::/48 2001:DB8:DADA:AAAA::6
# no ipv6 route 2001:DB8:8::/48 2001:DB8:DADA:AAAA::7
# no ipv6 route 2001:DB8:9::/48 2001:DB8:DADA:AAAA::8
# no ipv6 route 2001:DB8:A::/48 2001:DB8:DADA:AAAA::9
# no ipv6 route 2001:DB8:B::/48 2001:DB8:DADA:AAAA::A
# no ipv6 route 2001:DB8:C::/48 2001:DB8:DADA:AAAA::B
# no ipv6 route 2001:DB8:D::/48 2001:DB8:DADA:AAAA::C
# no ipv6 route 2001:DB8:E::/48 2001:DB8:DADA:AAAA::D
# no ipv6 route 2001:DB8:F::/48 2001:DB8:DADA:AAAA::E
# no ipv6 route 2001:DB8:10::/48 2001:DB8:DADA:AAAA::F
# no ipv6 route 2001:DB8:11::/48 2001:DB8:DADA:AAAA::10
# no ipv6 route 2001:DB8:11::/48 2001:DB8:DADA:AAAA::1
# no ipv6 route 2001:DB8:12::/48 2001:DB8:DADA:AAAA::11
# no ipv6 route 2001:DB8:12::/48 2001:DB8:DADA:AAAA::2
# no ipv6 route 2001:DB8:13::/48 2001:DB8:DADA:AAAA::12
# no ipv6 route 2001:DB8:13::/48 GigabitEthernet0/0/1 2001:DB8:DADA:AAAA::3
# no ipv6 route 2001:DB8:13::/48 2001:DB8:DADA:AAAA::3
# no ipv6 route 2001:DB8:14::/48 2001:DB8:DADA:AAAA::13
# no ipv6 route 2001:DB8:14::/48 2001:DB8:DADA:AAAA::4
# no ipv6 route 2001:DB8:15::/48 2001:DB8:DADA:AAAA::14
# no ipv6 route 2001:DB8:15::/48 2001:DB8:DADA:AAAA::5
# no ipv6 route 2001:DB8:16::/48 2001:DB8:DADA:AAAA::15
# no ipv6 route 2001:DB8:16::/48 2001:DB8:DADA:AAAA::6
# no ipv6 route 2001:DB8:17::/48 2001:DB8:DADA:AAAA::16
# no ipv6 route 2001:DB8:17::/48 2001:DB8:DADA:AAAA::7
# no ipv6 route 2001:DB8:18::/48 2001:DB8:DADA:AAAA::17
# no ipv6 route 2001:DB8:18::/48 2001:DB8:DADA:AAAA::8
# no ipv6 route 2001:DB8:19::/48 2001:DB8:DADA:AAAA::18
# no ipv6 route 2001:DB8:19::/48 2001:DB8:DADA:AAAA::9
# no ipv6 route 2001:DB8:1A::/48 2001:DB8:DADA:AAAA::19
# no ipv6 route 2001:DB8:1A::/48 2001:DB8:DADA:AAAA::10
# no ipv6 route 2001:DB8:1B::/48 2001:DB8:DADA:AAAA::11
# no ipv6 route 2001:DB8:1C::/48 2001:DB8:DADA:AAAA::12
# no ipv6 route 2001:DB8:1D::/48 2001:DB8:DADA:AAAA::13
# no ipv6 route 2001:DB8:1E::/48 2001:DB8:DADA:AAAA::14
# no ipv6 route 2001:DB8:1F::/48 2001:DB8:DADA:AAAA::15
# no ipv6 route 2001:DB8:20::/48 2001:DB8:DADA:AAAA::16
# no ipv6 route 2001:DB8:21::/48 2001:DB8:DADA:AAAA::17
# no ipv6 route 2001:DB8:22::/48 2001:DB8:DADA:AAAA::18
# no ipv6 route 2001:DB8:23::/48 2001:DB8:DADA:AAAA::19
# no ipv6 route 2001:DB8:24::/48 2001:DB8:DADA:AAAA::20
# no ipv6 route 2001:DB8:25::/48 2001:DB8:DADA:AAAA::21
# no ipv6 route 2001:DB8:26::/48 2001:DB8:DADA:AAAA::22
# no ipv6 route 2001:DB8:27::/48 2001:DB8:DADA:AAAA::23
# no ipv6 route 2001:DB8:28::/48 2001:DB8:DADA:AAAA::24
# no ipv6 route 2001:DB8:29::/48 2001:DB8:DADA:AAAA::25

