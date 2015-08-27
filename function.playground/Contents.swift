//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
//函数
//
//函数是一个完成独立任务的代码块，Swift中的函数不仅可以像C语言中的函数一样作为函数的参数和返回值，而且还支持嵌套，并且有C#一样的函数参数默认值、可变参数等。

func sum(num1:Int,num2:Int)->Int{
    return num1+num2
}

sum(1, 2)

//可以看到Swift中的函数仅仅表达形式有所区别(定义形式类似于Javascript，但是js不用书写返回值)，但是本质并没有太大的区别。不过Swift中对函数参数强调两个概念就是局部参数名（又叫“形式参数”）和外部参数名，这极大的照顾到了ObjC开发者的开发体验。在上面的例子中调用sum函数并没有传递任何参数名，因为num1、num2仅仅作为局部参数名在函数内部使用，但是如果给函数指定一个外部参数名在调用时就必须指定参数名。另外前面也提到关于Swift中的默认参数、可变长度的参数，包括一些高级语言中的输入输出参数，通过下面的例子大家会有一个全面的了解。

/*  函数参数名分为局部参数名和外部参数名*/

func split(string a:String,seperator b:Character)->[String]{
    return split(a, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==b})
}

//由于给splite函数设置了 外部参数名string和seperator。所以执行的时候必须带上外部参数名，此处可以看到一个意义的外部参数名
split(string: "hello,world", seperator: ",")

//下面通过在局部参数名前加上#来简写外部参数名（此时局部参数名和外部参数名相同）
func split2(#string :String,#seperator :Character)->[String]{
    return split(string, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==seperator})
}
split2(string: "hello,mangues", seperator: ",")


//上面splte函数的最后一个参数默认设置为",",如果使用默认参数，此时此参数名将默认作为外部参数名（此时局部参数名和外部参数名相同）
func split3(#string :String,seperator :Character=",")->[String]{
    return split(string, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==seperator})
}

split3(string: "hello,mangues");
split3(string: "hello,mangues", seperator: ",");


//但是如果有默认值，又不想指定局部参数名可以使用“_”取消外部参数名
func split4(string:String,_ seperator:Character=",")->[String]{
    return split(string, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0==seperator})
}
split4("hello,world,!", ",") //结果：["hello", "world", "!"]


/**
* 可变参数,一个函数最多有一个可变参数并且作为最后一个参数
* 下面strings参数在内部是一个[String]，对于外部是不定个数的String参数
*/
func joinStr(seperator:Character=",",string :String...)->String{
    var result:String = ""
    for var i=0;i<string.count;i++ {
        if i != 0 {
            result.append(seperator)
        }
        result+=string[i]
    }
    return result
}

joinStr(seperator:" ", "hello","world","!") //结果："hello world !"
joinStr(seperator:",","hello","world","!")

/**
* 函数参数默认是常量，不能直接修改，通过声明var可以将其转化为变量（但是注意C语言参数默认是变量）
* 但是注意这个变量对于外部是无效的，函数执行完就消失了
*/

func sum2(var num1:Int,num2:Int)->Int{
    num1 = num1 + num2
    return num1
}

//错误 默认是不能修改的
//func sum22(num1:Int)->Int{
//    return num1++
//}
sum2(1, 2)


/**
*  输入输出参数
*  通过输入输出参数可以在函数内部修改函数外部的变量（注意调用时不能是常量或字面量）
*  注意：下面的swap仅仅为了演示，实际使用时请用Swift的全局函数swap
*/
func swap(inout a:Int ,inout b:Int){
    a=a+b
    b=a-b
    a=a-b
}

var a=1,b=2
swap(&a, &b) //调用时参数加上“&”符号
println("a=\(a),b=\(b)") //结果："a=2,b=1"



/**
*  @author mangues, 15-08-27 11:08:09
*
*   和很多语言一样，Swift中的函数本身也可以看做一种类型，既可以作为参数又可以作为返回值。
*/

var sum3 = sum //自动推断sum3的类型：（Int,Int）->Int,注意不同的函数类型之间不能直接赋值
sum3(1,2)

//函数作为返回值
func fn()->(Int,Int)->Int {
    //下面的函数是一个嵌套函数，作用于是在fn函数的内部
    func minus(a:Int,b:Int)->Int {
        return a - b
    }
    return minus
}

var min = fn()

//函数作为参数
func caculate(num1:Int,num2:Int,fn:(Int,Int)->Int){
    return fn(num1,num2)
}

caculate(1,2,sum)
caculate(1,2,min)


