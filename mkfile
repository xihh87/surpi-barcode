barcodes:VE:
	./targets | xargs mk

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
