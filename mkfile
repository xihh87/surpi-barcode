BARCODES=`{find data/./ -type f \
		-name '*.fastq.gz' \
	| sed -r \
		-e 's/_L00[0-9](_R[12])_.*/\1.fastq.gz/g' \
		-e 's#data/#results/barcodes/#g' \
	| sort -u \
}

barcodes:V: $BARCODES

'results/barcodes/(.*/)(.*)(_R[12])\.fastq\.gz':R:	'data/\1'
	dir=$prereq
	barcode=$stem2
	orientation=$stem3
	target=$target
	mkdir -p `dirname "$target"`

	prefix="$barcode"'*'"$orientation"'*'
	find "$dir" -type f \
		-name "$prefix"'.fastq.gz' \
	| xargs zcat \
	| sed -r -e 's#^@(.*)$#@'"$barcode"'.\1#g' \
	| gzip - \
	> "$target"
