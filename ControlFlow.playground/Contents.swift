//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var a=["a","b","c","d","e","f","g"]
let b=a[1]

/**
*  switch支持一个case多个模式匹配，同时case后不用写break也会在匹配到种情况后自动跳出匹配，不存在隐式贯穿，如果想要贯穿在case之后添加"fallthrough"关键字
*/

switch b{
case "a","b":
    println("b=a or b=b")
case "c","d","e","f":
    println("b in (c,d,e,f)")
default:
    println("b=g")
}

/**
* 匹配区间,同时注意switch必须匹配所有情况，否则必须加上default
*/

let c1:Int = 55
switch c1{
case 1...60:
    println("1-60")
case 61...90:
    println("61-90")
case 91...100:
    println("91-100")
default:
    println("1>c>100")
}


/**
*  元组匹配、值绑定、where条件匹配
*  注意下面的匹配没有default，因为它包含了所有情况
*/

var d = (x:900,y:1)
switch d{
case (0,0):
    println("d in (0,0)")
case (_,0)://忽略x值的绑定
    println("d in y")
case (0,let y)://值绑定
    println("d in x,y=\(y)")
case (-100...100,-100...100): //注意这里有可能和第一、二、三个条件重合，但是Swift允许多个case匹配同一个条件，但是只会执行第一个匹配
    println("x in（0-100），y in （0-100）")
case let (x,y) where x==y:
    println("x=x=\(x)")
case let (x,y):
    println("x=\(x),y=\(y)")
}

//
//在其他语言中通常可以使用break、continue、return（Swift中添加了fallthrough）等来终止或者跳出某个执行语句，但是对于其行为往往是具有固定性的，例如break只能终止其所在的内层循环，而return只能跳出它所在的函数。在Swift中这种控制转移功能得到了加强，那就是使用标签。利用标签你可以随意指定转移的位置，例如下面的代码演示了如何直接通过标签跳出最外层循环：


var aa = 5
whilwLooop:
    while --aa>0{
        for var i = 0; i<aa; i++ {
            println("a=\(aa),i=\(i)")
            break whilwLooop
              //如果此处直接使用break将跳出for循环，而由于这里使用标签直接跳出了while，结果只会打印一次，其结果为：a=4,i=0
        }
}










