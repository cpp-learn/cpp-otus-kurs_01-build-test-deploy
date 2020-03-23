# создает makefile
#cmake -DCMAKE_BUILD_TYPE=Debug .
cmake .

# выполняет команду, которая собирает бинарники и либы
cmake --build .

# запускает тесты
cmake --build . --target test

# запустит команду, которая создает пакет
cmake --build . --target package
