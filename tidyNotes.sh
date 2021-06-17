notes=$1

if [[ -z "$1" ]] ; then
    echo 'Please provide a CSV file'
    exit 1
fi

truncate -s 0 cleanNotes.json
sed -n $'s/\r$//' $notes

while IFS=, read -r field1 field2
    do    
        tidy1=\"${field1}\"    
        tidy2=\"${field2}\"    
        echo "$tidy1: $tidy2," >> temp.txt
    done < $notes

awk '{ gsub(/\xef\xbb\xbf/,""); print }' temp.txt > cleanNotes.json
rm temp.txt