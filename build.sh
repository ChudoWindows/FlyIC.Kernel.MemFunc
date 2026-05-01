#!/bin/bash
set -e

project_name="FlyIC.Kernel.MemFunc"

echo "Сборка пакета $project_name"
echo "Для работы необходим компилятор clang и линкер llvm"
echo ""

mkdir -p build
mkdir -p lib

echo "Введите тип сборки:"
read build_type

if [ $build_type != "Debug" ] && [ $build_type != "Release" ]; then
	echo "Не верный тип сборки ($build_type)"
	echo "Будет использован тип сборки \"Debug\""
	build_type="Debug"
fi

mkdir -p build/$build_type
mkdir -p lib/$build_type

compile_flags="-Iinclude -IFlyIC.Kernel.Base/include -nostdlib -ffreestanding -fno-rtti -fno-exceptions -fno-stack-protector"

if [ $build_type == "Debug" ]; then
	compile_flags="$compile_flags -g -O0"
fi

if [ $build_type == "Release" ]; then
	compile_flags="$compile_flags -O2 -march=native"
fi

echo "(1/2) lib.cpp"; clang++ -c ./src/lib.cpp -o ./build/$build_type/lib.o $compile_flags
echo "(2/2) Archiving..."; llvm-ar rcs ./lib/$build_type/$build_type.$project_name.a ./build/$build_type/lib.o

echo ""
echo "Успешно!"
echo "Для выхода нажмите Enter..."

read
