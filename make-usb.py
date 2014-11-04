# Assemble a nengo folder suitable for being dropped into a USB memory stick for
# offline installation
# TODO: Make it multi-threaded

import os
import urllib, urlparse
import re

from bs4 import BeautifulSoup

# Because I want pretty dict initialization
class Vividict(dict):
    def __missing__(self, key):
        value = self[key] = type(self)()
        return value

# TODO: Figure out how to just get the most recent version and then dynamically
# create the batch file and shell file 
# Use http://repo.continuum.io/anaconda3/ if you want Python3, but for now we're going to use Python2, because I haven't converted the GUI to be Python2 compatible
anaconda_url = "http://repo.continuum.io/archive/"
soup = BeautifulSoup(urllib.urlopen(anaconda_url).read())
most_recent_version = re.search(r"[0-9]+\.[0-9]+\.[0-9]+", soup.find_all('a')[-1].text).group(0)

# Where to get the various packages
anaconda_list = Vividict()
anaconda_list["os_x"]["64_bit"] = ("%sAnaconda-%s-MacOSX-x86_64.pkg" %(anaconda_url, most_recent_version))
anaconda_list["linux"]["32_bit"] = ("%sAnaconda-%s-Linux-x86.sh" %(anaconda_url, most_recent_version))
anaconda_list["linux"]["64_bit"] = ("%sAnaconda-%s-Linux-x86_64.sh" %(anaconda_url, most_recent_version))
anaconda_list["windows"]["32_bit"] = ("%sAnaconda-%s-Windows-x86.exe" %(anaconda_url, most_recent_version))
anaconda_list["windows"]["64_bit"] = ("%sAnaconda-%s-Windows-x86_64.exe" %(anaconda_url, most_recent_version))


# Make directories and download packages
for op_sys, op_key in anaconda_list.iteritems():
    for arch, url in op_key.iteritems():
        print("%s %s %s" %(op_sys, arch, url))
        target_dir = "packages/%s/%s/" %(op_sys, arch,)
        if not os.path.exists(target_dir):
            os.makedirs(target_dir)

        print("downloading %s" %url)
        print("target %s/%s" %(target_dir, urlparse.urlsplit(url).path.split("/")[-1],))
        urllib.urlretrieve(url, "%s/%s" %(target_dir, urlparse.urlsplit(url).path.split("/")[-1],))

# Build the docs # TODO: Add offline README indicating where the offline docs are