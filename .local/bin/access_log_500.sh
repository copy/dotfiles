awk '($9 ~ /^5/)' $1 | awk '{print $9 " " $7}' | sort | uniq -c | sort -rn
