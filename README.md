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

You may need to install following for the script to work.

+ R [from CRAN](https://cran.r-project.org)
+ ```dig``` **d**omain **i**nformation **g**roper - [More on wikipedia](https://en.wikipedia.org/wiki/Dig_(command)). Dig is part of [bind](https://www.isc.org/downloads/bind/) package.
  + ```dig``` is pre-installed on MacOS but for linux system it can be installed using:

```sh
 $ sudo apt-get install dnsutils
```

# Usage

``` sh
 $ git clone https://github.com/robocopAlpha/DNSSpeedTester.git
 $ cd DNSSpeedTester
 $ Rscript ./DNSSpeedTest.R 
 
DNS	test1	test2	test3	test4	test5	test6	test7	test8	test9	test10	test11	test12	test13	avg	sd
cloudflare	34 ms	34 ms	34 ms	34 ms	35 ms	35 ms	34 ms	35 ms	34 ms	34 ms	34 ms	62 ms	34 ms	34 ms	7.4
comodo	35 ms	34 ms	34 ms	37 ms	34 ms	35 ms	34 ms	66 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	8.5
DNSadvantage	34 ms	35 ms	35 ms	34 ms	34 ms	34 ms	34 ms	49 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	4
DNSWatch	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	60 ms	34 ms	124 ms	34 ms	39 ms	34 ms	34 ms	24.4
google	34 ms	34 ms	52 ms	34 ms	54 ms	34 ms	34 ms	34 ms	34 ms	71 ms	56 ms	34 ms	34 ms	34 ms	12.1
neustar	34 ms	37 ms	36 ms	37 ms	35 ms	34 ms	34 ms	35 ms	35 ms	34 ms	34 ms	34 ms	34 ms	34 ms	1.1
norton	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	36 ms	35 ms	34 ms	34 ms	34 ms	0.6
opendns	35 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	100 ms	34 ms	67 ms	34 ms	36 ms	34 ms	34 ms	19
opennic	34 ms	34 ms	34 ms	34 ms	9 ms	35 ms	34 ms	37 ms	34 ms	34 ms	34 ms	34 ms	34 ms	34 ms	6.8
safeDNS	35 ms	35 ms	34 ms	35 ms	35 ms	34 ms	34 ms	100 ms	47 ms	213 ms	35 ms	34 ms	35 ms	35 ms	49.3
verisign	40 ms	35 ms	34 ms	34 ms	34 ms	34 ms	50 ms	35 ms	41 ms	34 ms	118 ms	50 ms	34 ms	35 ms	22.2
yandex	35 ms	49 ms	34 ms	34 ms	46 ms	34 ms	34 ms	65 ms	54 ms	51 ms	34 ms	50 ms	34 ms	35 ms	10.2
adguard	35 ms	139 ms	37 ms	43 ms	35 ms	34 ms	34 ms	84 ms	34 ms	81 ms	36 ms	46 ms	35 ms	36 ms	30.5
cleanbrowsing	37 ms	39 ms	37 ms	38 ms	38 ms	38 ms	37 ms	37 ms	39 ms	37 ms	38 ms	48 ms	37 ms	38 ms	2.8
level3	41 ms	40 ms	39 ms	39 ms	39 ms	39 ms	41 ms	89 ms	39 ms	134 ms	40 ms	41 ms	40 ms	40 ms	27.5
quad9	206 ms	41 ms	188 ms	35 ms	34 ms	40 ms	36 ms	397 ms	43 ms	609 ms	34 ms	40 ms	34 ms	40 ms	174.3
DYN	171 ms	115 ms	114 ms	115 ms	203 ms	115 ms	113 ms	113 ms	113 ms	113 ms	113 ms	114 ms	113 ms	114 ms	27.3
freenom	236 ms	284 ms	35 ms	131 ms	287 ms	34 ms	151 ms	100 ms	121 ms	126 ms	34 ms	108 ms	34 ms	121 ms	86.9


Results saved at ~/Desktop/DNS.test.result.tsv
```



This project was inspired by [DNSperftest](https://github.com/cleanbrowsing/dnsperftest/) and was written in R from the ground up to query DNS resolvers using dig, then calculate the mean and standard deviation for the DNS queries, sort the output based on average response time and subsequently, write the output to a TSV file.  DNS Speed Test also includes more DNS resolvers and attempts to resolve the address three times.