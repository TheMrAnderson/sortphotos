SEARCH_DIR=$1
DEST_DIR=$2
REPO_DIR=$3

clear
# Remove empty files
echo Removing all empty files
find $SEARCH_DIR -type f -empty -delete

# Remove json files
echo Removing json files
python3 $REPO_DIR/ScriptFiles/Python/removefiles.py $SEARCH_DIR json

# Sort photos
echo Sorting photos
python3 $REPO_DIR/SortPhotos/src/sortphotos.py $SEARCH_DIR $DEST_DIR --recursive --sort %Y/%Y-%m/ --rename %Y%m%d_%H%M%S%f --clean_src_dir True
