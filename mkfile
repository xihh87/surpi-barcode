BARCODES=`{find data/ -type f -name '*.fastq.gz' \
	| sed -e 's/_L00[0-9]_R[12]_.*/.fastq/g' -e 's#data/#results/barcodes/#g' \
	| sort -u}

barcodes:V: $BARCODES

'results/barcodes/(.*/)(.*)\.fastq':R:	'data/\1'
	echo target=$target
	echo prereq=$prereq
	echo stem1=$stem1
	echo stem2=$stem2
	find "$prereq" -type f -name '*.fastq'
