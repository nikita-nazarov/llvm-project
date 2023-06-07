
default:
	cmake -S llvm -B build -G  Ninja -DLLVM_BINUTILS_INCDIR="/usr/local/google/home/nikitanazarov/Projects/binutils/include" -DLLVM_ENABLE_PROJECTS="clang;lld" -DCMAKE_BUILD_TYPE=Debug -DLLVM_USE_LINKER=lld && ninja -j 20 -C build/
	 
