### 文件夹结构准备
	src 放置Fortran程序
	build 空文件夹
	CMakeLists.txt
	data_in
	data_out
### netcdf的安装
	brew install netcdf --enable-fortran		
### CMakeLists.txt
 	
 	cmake_minimum_required (VERSION 2.8)
 	
	project (main Fortran)
	
	include_directories("/usr/local/Cellar/netcdf/4.3.3.1_4/include")
	link_directories("/usr/local/Cellar/netcdf/4.3.3.1_4/lib")
	set (source_directories
    "${PROJECT_SOURCE_DIR}/src"
	)
	foreach (dir ${source_directories})
    include_directories ("${dir}")
    file (GLOB code "${dir}/*.F90")
    list (APPEND sources ${code})
	endforeach ()

	add_executable (main ${sources})
	target_link_libraries (main netcdf netcdff	
### 命令行操作
	cd build
	which gfortran 复制gfortran所在工作目录
	FC=####/gfortran cmake ..
	make
	./main
	
			