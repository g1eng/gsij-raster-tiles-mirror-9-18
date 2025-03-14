#!/bin/sh -e


BASE_URL="https://maps.gsi.go.jp/xyz"
UA="GSI-fetcher/0.1.2 (The GomenKudasai Bot)"
n=1

## curl -A "$UA1" ${BASE_URL%/*}

fetch_tile(){ #path
	local path=${1:?no path}
	[ -d ~/${path%/*} ] || mkdir -vp ~/${path%/*} 
	curl -A "$UA" $BASE_URL/$path -o ~/$path
}

awk -F , '{print $1; print $4;}' < $PWD/20250312-nippo.csv |
	while { read p; read q; } do
		p=$p
		q="$q"
		## [ -f ~/$p ] && echo ok
		[ -f ~/$p ] || fetch_tile $p
		#md5sum $p | {
		#	read q2
		#	q2="${q2%% *}"
		#	[ "$q" = "$q2" ] || {
		#		echo latest file found >&2
		#		fetch_tile $p
		#	}
		#}
		[ $(($n % 100)) -ne 0 ] || echo REACHED: $n
		n=$((n+1))
	done
