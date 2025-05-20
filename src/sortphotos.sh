SEARCH_DIR=$1
DEST_DIR=$2
SCRIPT_DIR=$3

export PATH="/usr/local/bin:/usr/bin:/bin"
echo "$(date) Starting to sort photos in $SEARCH_DIR and move them to $DEST_DIR."

# Remove json files
echo Removing non photo related files
python3 $SCRIPT_DIR/removefiles.py $SEARCH_DIR json
python3 $SCRIPT_DIR/removefiles.py $SEARCH_DIR db
python3 $SCRIPT_DIR/removefiles.py $SEARCH_DIR ctg

# Remove empty folders
echo Removing all empty folders
find $SEARCH_DIR -type f -empty -delete

# Sort photos
echo Sorting photos
python3 $SCRIPT_DIR/sortphotos.py $SEARCH_DIR $DEST_DIR --recursive --sort %Y/%Y-%m/ --rename %Y%m%d_%H%M%S%f --clean_src_dir True
mkdir -p $SEARCH_DIR
echo "$(date) Finished sorting photos."
echo ""