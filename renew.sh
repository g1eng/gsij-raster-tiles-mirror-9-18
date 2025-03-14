#!/bin/sh

BASE_URL="https://maps.gsi.go.jp/xyz"
UA="GSI-renewer/0.1.2 (The GomenKudasai Bot)"

renew_tile(){ #path
	local path=${1:?no path}
	echo "[renew file $p]"
	[ -d ~/${path%/*} ] || mkdir -vp ~/${path%/*} 
	curl -A "$UA" $BASE_URL/$path -o ~/$path
}

awk -F , '{print $1; print $NF}' < $PWD/20250312-nippo.csv |
	while { read p; read q; } ; do 
		md5sum $p | awk '{print $1}' | {
			read q2
			[ $q = $q2 ] || renew_tile $p
		}
	done



n=1

## curl -A "$UA1" ${BASE_URL%/*}

