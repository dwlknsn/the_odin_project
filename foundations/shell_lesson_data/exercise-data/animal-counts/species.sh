# Prints the unique animal names in any number of CSV files
# Usage: bash species.sh file_names

for file in $@
do
	echo "Unique species in $file:"
	
	#Extract species names
	cut -d , -f 2 $file | sort | uniq
done
