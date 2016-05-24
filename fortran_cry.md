###private & public
在封装好的模块中（module），其中会有很多变量，如果申明private variable(变量名)，那么这个变量只能在这一个module中使用，如果是public，该变量对外公开，如果不做说明，那么默认变量是public的，也就是对外公开的。
###基本声明方法
####常值参数
    integer,    parameter   ::  r8  =   8
    integer,    parameter   ::  charlen =   500
    logical, parameter :: if_diag = .false.
    real(r8), public, parameter ::  g0  =   9.8d0
###Fortran 77 CP 90
Fortran 77： 固定格式（fixed format），程序代码扩展名：.f或.for
（1）若某行以C,c或*开头，则该行被当成注释；
（2）每行前六个字符不能写程序代码，可空着，或者1~5字符以数字表明行代码（用作格
式化输入出等）；7~72为程序代码编写区；73往后被忽略；
（3）太长的话可以续行，所续行的第六个字符必须是"0"以外的任何字符。
Fortran 90：自由格式（free format）， 扩展名：.f90
（1）以"!"引导注释；
（2）每行可132字符，行代码放在每行最前面；
（3）以&续行，放在该行末或下行初。
###函数
Fortran中函数分两类：子程序（subroutine）和自定义函数（function）。自定义函数一般要传递自变量给自定义函数，返回函数值。子程序可以没有返值。传递参数要注意类型的对应。
1、子程序
目的：把某一段经常使用的有特定功能的程序独立出来，可以方便调用。
习惯上一般都把子程序放在主程序结束之后。
形式：
	
	subroutine name (parameter1, parameter2) 
	mreturn !跟C不同，这里表示子程序执行后回到调用它的地方继续执行下面的程序。不一定放在最后    
	子程序中return之后的部分不执行。
	end [subroutine name]
调用：使用call命令直接使用，不需要声明。在调用处写：

	call subroutine name(parameter1,parameter2)
2、自定义函数
和子程序的明显不同在于：需要在主程序中声明之后才能使用。
调用方式也有差别。另外按照惯例用函数不去改变自变量的值。如果要改变传递参数的值，习惯上用子程序来做。
	
	声明方式：real, external :: function_name

形式：

	function function_name(parameter1, parameter2)
	implicit none
	real:: parameter1, parameter2    !声明函数参数类型，这是必需的
	real::function_name         !声明函数返回值类型，这是必需的
	……
	……   
	function_name=….    !返回值的表达式
	return
	end    
也可以这样直接声明返回值类型，简洁些：
	
		real function function_name(parameter1, parameter2)
调用：

	function_name(parameter1,parameter2)  !不需要call命令。

总之，调用自定义函数前需要做声明，调用子程序则不需要。
###Module
Module不是函数。它用于封装程序模块，一般是把具有相关功能的函数及变量封装在一起
。用法很单，但能提供很多方便，使程序变得简洁，比如使用全局变量不必每次都声明一长串，
写在Module里调用就行了。Module一般写在主程序开始之前。
形式：

	module module_name
	……
	……
	end [module [module_name]]
使用：在主程序或函数中使用时，需要在声明之前先写上一行：

	use module_name.
Module中有函数时必须在contains命令之后（即在某一行写上contains然后下面开始写函数，多所有函数都写在这个contains之后）。并且module中定义过的变量在module里的函数中可直接使用，函数之间也可以直接相互调用，连module中的自定义函数在被调用时也不用先声明。
###intent
	real (r8), intent (in) ::  ::  nmax, n, na
    real (r8), intent (out) ::  Amld
###基本数据运算
	Z(:)    =   Z0(:)*1.0d+2
###常用函数
	minval(rib)
	maxval(rib)
###IO
	write (*, *) "Error in ifsali: ", ifsali
	
	print *,ridb
	
	OPEN(UNIT=66,FILE='ridb.txt',STATUS='replace')
	write(66,*) ridb
    close(66)
###判断与循环语句
	IF(ifexpabstable.EQ.0) THEN
           idifs = (ABS(iri)-mt0)*iristep
    ELSE IF(ifexpabstable.EQ.1) THEN
           idif = ABS(iri)-mt0
    END IF
循环语句：可对其命名    
    
     loop_mwq2: DO ind2on2 = -mt,mt
                   CALL oursal2_zeroshear &
                   (and2on2a1(ind2on2),amtaun2a1(ind2on2) &
                   ,sma1(ind2on2),sha1(ind2on2),ssa1(ind2on2))
                END DO loop_mwq2
cycle命令可由略过循环的程序模块中，在cycle命令后面的所有程序代码，直接跳回循环的开头来进行下一次循环。
    
    DO irid= 0,mt*iridstep,iridstep
    loop_YZF1:   DO irisign=0,1
                       IF(slq2b(iri,irid).LT.0.0D0) THEN
                               irimax(irid) = iri - 1 
                               cycle loop_YZF1
                            
                       END IF
                 END DO loop_YZF1
    END DO
另一个例子
	
	do floor=1,dest 
	if(floor==4) cycle  
	write(*,*) floor 
	end do 
执行结果如下 1 2 3 5 6  
    
###字符串操作
	'AB'//'CD' !表示字符型量的合并,可以是字符型常量、变量、表达式。
###common
公用语句，其后变量相等，用来在程序单位间传递数据，同时可以用来说明数组。程序中可有一个无名公用区和多个有名公用区。

1.common 不共享数据的类型，仅共享数据的值。
2.如果你在某个程序单元需要使用 common 内的变量，则需要声明。
3.common 是个过时的语法，是错误的根源。强烈建议你看见了认识，但千万不要使用。
4.common 通过变量顺序来一一对应，而不是变量名字。这需要你特别注意。这也是它特别容易出错的原因。
		
无名公用区的规则和特点：
1.common语句必须在所有可执行语句之前
2.一个程序只有一个无名公用区
有名共用区

	common /group1/ a
common中的变量不能使用接在子程序或主程序中的data来赋初值，要在block data程序模块中使用data设置初值
	
	data c,d /3,4/
###参数传递
SOUBROUTINE NAME (虚拟参数,...)
CALL NAME (实在参数,...)	
	
###基本语法参考网站
	http://asc.2dark.org/node/45
