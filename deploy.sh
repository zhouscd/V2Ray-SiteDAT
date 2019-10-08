#!/bin/bash

git remote add upstream "https://${geo_token}@github.com/zhouscd/V2Ray-SiteDAT.git"

wget https://raw.githubusercontent.com/h2y/Shadowrocket-ADBlock-Rules/master/sr_top500_banlist_ad.conf
wget https://raw.githubusercontent.com/h2y/Shadowrocket-ADBlock-Rules/master/sr_top500_whitelist_ad.conf

mkdir -p sites
cd sites
rm -rf ./*

cat ../sr_top500_banlist_ad.conf | grep Reject|grep DOMAIN-SUFFIX|awk -F, '{print $2}' > ad
cat ../sr_top500_banlist_ad.conf | grep Proxy |grep DOMAIN-SUFFIX|awk -F, '{print $2}' > gfw

cat ../sr_top500_whitelist_ad.conf | grep Direct |grep DOMAIN-SUFFIX|awk -F, '{print $2}' > cn

cd ..



mkdir -p geofiles
chmod +x ./v2sitedat
./v2sitedat -dat ./geofiles/geosite.dat -dir ./sites


#git checkout -b master
git add -A
git commit -m 'Update'
git push -u upstream HEAD:master 
