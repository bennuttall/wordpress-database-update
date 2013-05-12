# Wordpress Database Update

When you move a Wordpress site from local to a server, or vice-versa, you need to update the URL in the database

## Usage

First add the appropriate MySQL username and password to the script

Then move the file ```wpdb.sh``` to your ```/usr/local/bin```:
```
mv wpdb.sh /usr/local/bin/wpdb
```

and then call it from the command line

```
$ wpdb
usage: wpdb DATABASE OLD_URL NEW_URL

$ wpdb mcrraspjam http://mcrraspjam http://mcrraspjam.org.uk
Replaced 'http://mcrraspjam' with 'http://mcrraspjam.org.uk' in database 'mcrraspjam'
```

### What does it do to my database?

It connects to the specified database and runs two simple queries:
```
UPDATE wp_options SET option_value = '$3' WHERE option_name IN ('siteurl', 'home');
UPDATE wp_posts SET post_content = REPLACE(post_content, '$2', '$3');
```

This changes the ```siteurl``` and ```home``` settings in the ```wp-options``` table and replaces all links inside post content (including internal links to media and to other posts)
