#!/bin/bash
old_line=$(head -n 1 ".env")
echo $old_line
new_line='DATABASE_URL="mysql://root:12345678@tweaxy.c9cizq8r8gpw.eu-north-1.rds.amazonaws.com:3306/tweaxy"'
sed -i "1s|$old_line|$new_line|" ".env"
echo "Running on prod_db"