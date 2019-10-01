#!/bin/bash

git remote add upstream "https://${geo_token}@github.com/zhouscd/V2Ray-SiteDAT.git"

wget https://raw.githubusercontent.com/h2y/Shadowrocket-ADBlock-Rules/master/sr_top500_banlist_ad.conf

mkdir -p sites
cd sites
rm -rf ./*

cat ../sr_top500_banlist_ad.conf | grep Reject|grep DOMAIN-SUFFIX|awk -F, '{print $2}' > ad
cat ../sr_top500_banlist_ad.conf | grep Proxy |grep DOMAIN-SUFFIX|awk -F, '{print $2}' > gfw

cd ..

mkdir -p ips
cd ips
rm -rf ./*

cat ../sr_top500_banlist_ad.conf | grep Reject|grep IP-CIDR|awk -F, '{print $2}' > ad
cat ../sr_top500_banlist_ad.conf | grep Proxy |grep IP-CIDR|awk -F, '{print $2}' > gfw
cp ../private .

cd ..

rm -rf sr_top500_banlist_ad.conf


mkdir -p geofiles
chmod +x ./v2sitedat
chmod +x ./v2ipdat
./v2sitedat -dat ./geofiles/geosite.dat -dir ./sites
./v2ipdat -dat ./geofiles/geoip.dat -dir ./ips

#git checkout -b master
git add -A
git commit -m 'Update'
git push -u upstream HEAD:master 
