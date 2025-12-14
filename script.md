find lib -name "*.dart" -type f -exec echo "// Файл: {}" \; -exec cat {} \; > all_dart.txt

для линукса, нужен чтобы консультироваться с ии и нужно дать полную картину кода