#!/bin/bash
cd /home/abgroup/web/anabolicgroup.com/public_html
WP=/home/abgroup/web/anabolicgroup.com/wp-cli.phar
for id in 4949 5252 71061 124808 124818 124828 124841 124852 124863 124877 124888 124899 124933 124942 414 3784 15391; do
  title=$(php $WP post get $id --field=post_title 2>/dev/null)
  type=$(php $WP post get $id --field=post_type 2>/dev/null)
  echo "$id | $type | $title"
done
