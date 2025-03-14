#!/bin/sh
awk -F , '{print $1; print $NF}' < $PWD/20250312-nippo.csv |
	while { read p; read q; } ; do 
		md5sum $p | awk '{print $1}' | {
			read q2
			[ $q = $q2 ] || echo expected $q, real $q2: $p >&2
		}
	done

