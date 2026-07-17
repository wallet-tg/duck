#!/bin/sh

set -eu

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 OUTPUT_DIR" >&2
    exit 1
fi

repository_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
template="$repository_dir/templates/cf_error.html"
output_dir=$1

mkdir -p "$output_dir"

for error_range in 500 1000; do
    sed "s/::CLOUDFLARE_ERROR_BOX::/::CLOUDFLARE_ERROR_${error_range}S_BOX::/" \
        "$template" > "$output_dir/cf_${error_range}.html"
done
