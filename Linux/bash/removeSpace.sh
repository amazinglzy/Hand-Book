#!/bin/bash
#@filename: removespace.sh
#@args: d - directory name
# usages: remove the space of filename in the directory of specified.

if [ ${#1} -eq 0 ];
then
	echo 'Please add the directory name';
else
	cd $1;
	for file in *;
	do 
		new_file=$(echo $file | tr ' ' '-');
		echo "$file => $new_file ...";
		mv "$file" "$new_file";
		echo done;
	done
fi
