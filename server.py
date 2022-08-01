from http.server import HTTPServer, SimpleHTTPRequestHandler
import os
import ipget # $ sudo pip3 install ipget==0.0.3


os.chdir("./www")
a = ipget.ipget()
ip, bit = a.ipaddr("wlan0").split('/')
port = 5555

httpd = HTTPServer(('', port), SimpleHTTPRequestHandler)
print('HTTPServer began -> http://{}:{}'.format(ip, port))
httpd.serve_forever()
