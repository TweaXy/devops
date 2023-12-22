#!/bin/bash
pushd /opt
old_line_edit=$(head -n 4 "test_db.sh" | tail -n 1)
echo $oldline_edit
new_line_edit="new_line=\'DATABASE_URL=\"mysql://root:1111@$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db):3306/TweeXy-testing\"\'"
echo $new_line_edit
sed -i "4s|$old_line_edit|$new_line_edit|" "test_db.sh"
popd



