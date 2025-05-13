# SortPhotos

PythonScript forked from [andrewning](https://github.com/andrewning/sortphotos) but his repo went stale.  I made a small [PR](https://github.com/andrewning/sortphotos/pull/147) that never got merged into his code and after 3 years, I decided it was time to Dockerize this and consolidate my additions I had used to clean up my multiple iPhoto libraries and the random mix of pictures after iPhoto.  I had been searching for a better way to manage my photos, looking at all the libraries and decided it was better to manage them myself in folders than have some proprietary tool manage them however seemed fit.

This is now my only means of managing my photos & videos and I just have viewers like Plex mapped to my photo directory.  I can download photos from our phones, SLR camera, action cameras, professional photos and any other source, dump them all into a single folder and let this handle the rest.  Naming schemes no longer matter and all the photos & videos get sorted by their EXIF data, so as long as the cameras have the correct time, all your memories will be together.  I have mine grouped by year and month which makes it pretty easy to find.  If I am looking back for something, like my son's 3rd birthday party, I know exactly where to go.

## Arguments

- `SORT_FORMAT`: The way the photos will be sorted in the `/dest_photo`.  For example `%Y/%Y-%m/` will create a folder per year with a 4 digit name, then a folder with a 4 digit name a dash and 2 digit month inside like 2004/2004-02
- `RENAME_FORMAT`: The style to rename the photos.  For exammple `%Y%m%d_%H%M%S%f` will create a 4 digit year, 2 digit month, 2 digit day, hour, minute, second and unique number within that second like 20040215_200102000000.jpg.
- `EXT_REMOVE`: Comma separated file extension list to remove.  I had a lot of `json` files to remove in my photo cleanup and using this I was able to sort my photos and remove all the json files, leaving empty directories.  I just leave it set on `json` now because there's never a reason to have a `json` file with my pictures.  Any file without EXIF data will stay in the `/src_photo` once the process has completed.
- `CLEAN_SRC_DIR`:  Values: `True`, `False`.  Setting this to true will remove any empty directories in `/src_photo`.  I leave mine on `True` and when cleaning a directory like an iPhoto library, it will ensure that any empty directory is removed to make looking through what's left easier.  Also in an everyday manner, it keeps this folder nice and tidy.

## Drive Mapping

- `/src_photo` The source of your messy photos
- `/dest_photo` The final destination for your sorted photos

## Usage

Dump your photos from all your old sources into `/src_photo` and treat this as your photo upload folder.  This allows you to point this to a continuous location.  Photos from the phone, and SD cards get dumped into this folder.  I have called mine PhotoUpload on my computer so I avoid confusion.

The folder I have mapped to `/dest_photo` on my server is simply called Photos and I make it a practice to never put anything in this folder, but instead to let `sortphotos` put all the pictures in this folder so I don't contaminate this clean folder.  The one exception to this rule is photo release forms.  I just have them in a folder within the `/dest_photo` directory so they are with the photos.
