#!/bin/bash

git remote add upstream "https://${geo_token}@github.com/zhouscd/V2Ray-SiteDAT.git"

mkdir -p sites
cd sites
rm -rf ./*

wget https://raw.githubusercontent.com/h2y/Shadowrocket-ADBlock-Rules/master/sr_top500_banlist_ad.conf
cat sr_top500_banlist_ad.conf | grep Reject|grep DOMAIN-SUFFIX|awk -F, '{print $2}' > addomain
cat sr_top500_banlist_ad.conf | grep Reject|grep IP-CIDR|awk -F, '{print $2}' > adip

cat sr_top500_banlist_ad.conf | grep Proxy |grep DOMAIN-SUFFIX|awk -F, '{print $2}' > gfwdomain
cat sr_top500_banlist_ad.conf | grep Proxy |grep IP-CIDR|awk -F, '{print $2}' > gfwip
rm -rf sr_top500_banlist_ad.conf



cd ..
cp private ./sites/
mkdir -p geofiles
chmod +x ./v2sitedat
./v2sitedat -dat ./geofiles/geosite.dat -dir ./sites


#git checkout -b master
git add -A
git commit -m 'Update'
git push -u upstream HEAD:master 
