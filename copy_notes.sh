#! /usr/bin/bash

# copy the content of coding_documents/vimwiki to coding_documents/Joplin\ notes
# -a do the sync preserving all filesystem attributes
# -v run verbosely
# -u only copy files with a newer modification time, if times are equal compare the size difference
# --delete will delete extraneous files from dest dirs
rsync -avu --delete "/home/zoran/coding_documents/vimwiki" "/home/zoran/coding_documents/Joplin notes"
