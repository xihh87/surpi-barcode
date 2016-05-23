BARCODES=`{find data/ -type f -name '*.fastq.gz' \
	| sed -e 's/_L00[0-9]_R[12]_.*/.fastq/g' -e 's#data/#results/barcodes/#g' \
	| sort -u}

barcodes:V: $BARCODES

'results/barcodes/(.*/)(.*)\.fastq':R:	'data/\1'
	dir=$prereq
	barcode=$stem2
	target=$target
	mkdir -p `dirname "$target"`
	find "$dir" -type f -name '*.fastq.gz' \
		| xargs zcat \
		| sed "s#\(@.*\)#\1:$barcode#g" \
		> "$target"
