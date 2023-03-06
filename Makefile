
default:
	cmake -S llvm -B build -G  Ninja -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Debug && ninja -C build/            	
