#!/bin/bash
old_line=$(head -n 1 ".env")
echo $old_line
new_line='DATABASE_URL="mysql://root:1111@172.17.0.2:3306/TweeXy-testing"'
sed -i "1s|$old_line|$new_line|" ".env"
echo "Running on test_db"




