# ~/Repo/ScriptFiles/Bash/sortphotos.sh ~/Pictures/@MoveToRyker ~/Ryker/mpanderson/Pictures

echo
echo Starting Move Photos

root_dir=/mnt/fe883bb0-1d09-4c5f-a73a-7ab7f3fd418f/Sync
from_dir=$root_dir/PhotoUpload
to_dir=$root_dir/Photos

$root_dir/Repo/ScriptFiles/Bash/sortphotos.sh $from_dir $to_dir $root_dir/Repo
mkdir $from_dir

echo Finished Move Photos
echo
