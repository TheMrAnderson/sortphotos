import glob
import os


def clear_files(dir_name, extensions):
    ext = extensions.split(",")
    for e in ext:
        e = e.replace('.', '')
        print(f'  Searching for {e} files in {dir_name}.')
        files = glob.glob(dir_name + '/**/*.' + e, recursive=True)
        print(f'  Found {len(files)} files.  Deleting now...')
        for f in files:
            if f.endswith(f".{e}"):  # Double check
                try:
                    # Following SNYK recommendation to stop directory traversal attack
                    # https://learn.snyk.io/lessons/directory-traversal/python/
                    safepath = os.path.realpath(f)
                    prefix = os.path.commonpath(dir_name, safepath)
                    if prefix == dir_name:
                        os.remove(os.path.join(dir_name, safepath))
                    print(f'Removed {f}')
                except:
                    print(f'Failed to remove {f}')
        print(f'All {e} files have been removed')


def main():
    import argparse
    # setup command line parsing
    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
                                     description='Remove files containing extension from directory')
    parser.add_argument('search_dir', type=str, help='search directory')
    parser.add_argument('extension', type=str, help='file extension to remove')

    # parse command line arguments
    args = parser.parse_args()

    clear_files(args.search_dir, args.extension)


if __name__ == '__main__':
    main()
