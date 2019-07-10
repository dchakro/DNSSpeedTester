# DNS Speed Tester

This is an R script to test the speed (in milliseconds) of some of the public DNS resolvers from your Internet connection. Helps you choose a suitable DNS resolver should you wish to change from your ISPs DNS resolver.

These public DNS resolvers are checked by default (*Modify the script to add your preferred DNS resolvers*):
 * adguard *176.103.130.132*
 * cleanbrowsing *185.228.168.168*
 * cloudflare *1.1.1.1*
 * comodo *8.26.56.26*
 * DNSadvantage *156.154.70.1*
 * DNSWatch *84.200.69.80*
 * DYN *216.146.35.35*
 * freenom =*80.80.80.80*
 * google *8.8.8.8*
 * level3 *4.2.2.1*
 * neustar *156.154.70.3*
 * norton *199.85.126.10*
 * opendns *208.67.222.123*
 * opennic *176.126.70.119*
 * quad9 *9.9.9.9*
 * safeDNS *195.46.39.39*
 * verisign *64.6.64.6*
 * yandex *77.88.8.7*

# Dependencies 

You may need to install following utilities bc and dig for linux operating systems.

+ R [from CRAN](https://cran.r-project.org)
+ ```dig``` **d**omain **i**nformation **g**roper - [More on wikipedia](https://en.wikipedia.org/wiki/Dig_(command)). Dig is part of [bind](https://www.isc.org/downloads/bind/) package.
  + ```dig``` is pre-installed on MacOS but for linux system it can be installed using:

```sh
 $ sudo apt-get install dnsutils
```

# Usage

``` sh
 $ git clone https://github.com/robocopalpha/DNSSpeedTester/
 $ cd DNSSpeedTester
 $ Rscript ./DNSSpeedTest.R 
 
 DNS		test1		test2		test3		test4		test5		test6		test7		test8		test9		test10	test11	test12	test13	avg	sd
cloudflare	47 ms	45 ms	43 ms	43 ms	42 ms	43 ms	44 ms	43 ms	43 ms	43 ms	43 ms	42 ms	44 ms	43.5 ms	1.3
opennic	48 ms	44 ms	43 ms	43 ms	43 ms	44 ms	48 ms	44 ms	51 ms	43 ms	43 ms	43 ms	44 ms	44.7 ms	2.5
neustar	49 ms	45 ms	47 ms	43 ms	48 ms	48 ms	44 ms	45 ms	48 ms	47 ms	42 ms	48 ms	48 ms	46.3 ms	2.2
yandex	48 ms	46 ms	43 ms	44 ms	42 ms	48 ms	43 ms	52 ms	44 ms	43 ms	44 ms	90 ms	43 ms	48.5 ms	12.3
norton	51 ms	115 ms	43 ms	45 ms	43 ms	43 ms	42 ms	43 ms	43 ms	43 ms	44 ms	43 ms	43 ms	49.3 ms	19.1
safeDNS	51 ms	52 ms	51 ms	78 ms	49 ms	50 ms	60 ms	50 ms	47 ms	46 ms	46 ms	48 ms	46 ms	51.8 ms	8.4
cleanbrowsing	55 ms	49 ms	54 ms	53 ms	53 ms	50 ms	50 ms	69 ms	54 ms	59 ms	54 ms	49 ms	60 ms	54.5 ms	5.3
DNSadvantage	51 ms	47 ms	53 ms	49 ms	50 ms	56 ms	52 ms	50 ms	83 ms	86 ms	46 ms	43 ms	43 ms	54.5 ms	13.3
verisign	69 ms	67 ms	46 ms	48 ms	47 ms	87 ms	58 ms	49 ms	50 ms	43 ms	48 ms	49 ms	47 ms	54.5 ms	12.1
DNSWatch	52 ms	47 ms	44 ms	54 ms	43 ms	44 ms	44 ms	83 ms	63 ms	98 ms	48 ms	48 ms	50 ms	55.2 ms	16.2
opendns	46 ms	44 ms	48 ms	44 ms	135 ms	44 ms	77 ms	42 ms	44 ms	68 ms	48 ms	44 ms	42 ms	55.8 ms	25.1
google	52 ms	45 ms	48 ms	55 ms	59 ms	47 ms	62 ms	47 ms	49 ms	135 ms	67 ms	42 ms	44 ms	57.8 ms	23.4
adguard	50 ms	45 ms	43 ms	47 ms	76 ms	52 ms	48 ms	157 ms	43 ms	45 ms	54 ms	44 ms	49 ms	57.9 ms	29.8
level3	54 ms	56 ms	58 ms	57 ms	57 ms	58 ms	58 ms	127 ms	58 ms	59 ms	58 ms	59 ms	55 ms	62.6 ms	18.6
quad9	46 ms	86 ms	44 ms	46 ms	46 ms	42 ms	44 ms	42 ms	43 ms	43 ms	279 ms	44 ms	42 ms	65.2 ms	62.8
comodo	46 ms	47 ms	43 ms	45 ms	178 ms	45 ms	51 ms	121 ms	44 ms	110 ms	44 ms	43 ms	49 ms	66.6 ms	40.8
freenom	359 ms	65 ms	56 ms	142 ms	99 ms	48 ms	52 ms	107 ms	108 ms	170 ms	90 ms	334 ms	71 ms	130.8 ms	98.2
DYN	124 ms	130 ms	134 ms	129 ms	132 ms	127 ms	127 ms	302 ms	134 ms	449 ms	141 ms	130 ms	131 ms	168.5 ms	93


Results saved at ~/Desktop/DNS.test.result.tsv
```



This project was inspired by [DNSperftest](https://github.com/cleanbrowsing/dnsperftest/) and was written in R from the ground up to query DNS resolvers using dig, then calculate the mean and standard deviation for the DNS queries, sort the output based on average response time and subsequently, write the output to a TSV file.  DNS Speed Test also includes more DNS resolvers and attempts to resolve the address three times.