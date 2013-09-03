#!/bin/bash

usage()
{
    echo "Usage: wpdb DATABASE OLD_URL NEW_URL" >&2
    exit 1
}

[ "$#" -lt 3 ] && usage

# parse commandline
while [ $# -gt 0 ]
do
      arg="$1"
      case "$arg" in
         -h|--help) usage ;;
         --) shift; break;;  # no more options
         -*) usage ;; 
         *) break;; # not an option, it's some argument
       esac
       shift
done

mysql $1 -Bse "
UPDATE wp_options SET option_value = '$3' WHERE option_name IN ('siteurl', 'home');
UPDATE wp_posts SET post_content = REPLACE(post_content, '$2', '$3');
"

echo "Replaced '$2' with '$3' in database '$1'"
