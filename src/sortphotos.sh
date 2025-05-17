SEARCH_DIR=$1
DEST_DIR=$2
SCRIPT_DIR=$3

echo "$(date) Starting to sort photos in $SEARCH_DIR and move them to $DEST_DIR."
clear
# Remove empty files
echo Removing all empty files
find $SEARCH_DIR -type f -empty -delete

# Remove json files
echo Removing json files
/usr/bin/python3 $SCRIPT_DIR/removefiles.py $SEARCH_DIR json

# Sort photos
echo Sorting photos
/usr/bin/python3 $SCRIPT_DIR/sortphotos.py $SEARCH_DIR $DEST_DIR --recursive --sort %Y/%Y-%m/ --rename %Y%m%d_%H%M%S%f --clean_src_dir True
mkdir -p $SEARCH_DIR
echo "$(date) Finished sorting photos."
echo ""