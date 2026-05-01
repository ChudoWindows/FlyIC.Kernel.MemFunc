#!/bin/bash
set -e

project_name="FlyIC.Kernel.MemFunc"

mkdir -p build
mkdir -p lib

# Инициализация переменных
build_type=""
hide=0

# Разбор аргументов командной строки
while [ $# -gt 0 ]; do
    case "$1" in
        --build-type|-b)
            build_type="$2"
            shift 2
            ;;
        --hide|-h)
            hide=1
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [ $hide -eq 0 ]; then
	echo "Сборка модуля $project_name"
	echo "Для работы необходимо:"
	echo "  * Компилятор clang"
	echo "  * Линковщик llvm"
	echo ""
fi

# Если тип сборки не указан, запрашиваем
if [ -z "$build_type" ]; then
    echo "Введите тип сборки:"
    read build_type
fi

# Проверка и установка типа сборки
if [ "$build_type" != "Debug" ] && [ "$build_type" != "Release" ]; then
    echo "Не верный тип сборки ($build_type)"
    echo "Будет использован тип сборки \"Debug\""
    build_type="Debug"
fi

mkdir -p "build/$build_type"
mkdir -p "lib/$build_type"

compile_flags="-Iinclude -IFlyIC.Kernel.Base/include -nostdlib -ffreestanding -fno-rtti -fno-exceptions -fno-stack-protector"

if [ "$build_type" = "Debug" ]; then
    compile_flags="$compile_flags -g -O0"
elif [ "$build_type" = "Release" ]; then
    compile_flags="$compile_flags -O2 -march=native"
fi

log() {
    if [ "$hide" -eq 0 ]; then
        echo "($1/$2) $3"
    fi
}

log 1 3 "FlyIC.Kernel.Base"

cd FlyIC.Kernel.Base
./build.sh -b $build_type -h

cd ..


log 2 3 "lib.cpp"
clang++ -c ./src/lib.cpp -o "./build/$build_type/lib.o" $compile_flags

log 3 3 "Archiving..."
llvm-ar rcs "./lib/$build_type/$build_type.$project_name.a" \
    "./build/$build_type/lib.o"

# Если не указан флаг --hide, ждём нажатия Enter
if [ "$hide" -eq 0 ]; then
    echo ""
    echo "Успешно!"
    echo "Для выхода нажмите Enter..."
    read
fi
