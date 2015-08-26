//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"
println(str)

var a:Int = 1
var b = 2
var c:UInt = 3
let d = a+b
println("d=\(d)")
//注意由于Swift是强类型语言，a是Int类型而c是UInt类型，二者不能运算，下面的语句报错;但是注意如果是类似于：let a=1+2.0是不会报错的，因为两个都是字面量，Swift会首先计算出结果再推断a的类型
//let e=a+c


//Int.max是Int类型的最大值，类似还有Int.min、Int32.max、Int32.min等
let e=Int.max //结果：9223372036854775807

var f:Float = 1.0
var g = 2.0  //浮点型自动推断为Double类型

var h:String = "hello"

//emoj表情也可以作为变量或者常量，事实上所有Unicode字符都是可以的
var 💖🍎="love and apple"
var 许涛 = "mangues"
println(许涛+💖🍎)

//两个字符串相加，但是注意不同类型不能相加
var i=h+💖🍎 //结果:hello love and apple


//布尔类型只有两个值true、false，类似于if语句中的条件只能是布尔类型不能像ObjC一样非0即真
var j:Bool = true

//字符类型，同样使用双引号，但是只能是一个字符，如果不指定类型则"c"默认会推断为字符串（var k:Character="c"是字符类型，但是var k="c"是字符串类型）

var k:Character = "c"

var l = 00100 //等于100，可以在前面添加额外的0

var m=10_000_000 //等于10000000，可以使用增加额外的下划线方便阅读而不改变值的大小




//集合类型
//
//Swift提供了三种集合类型：数组Array、集合Set、字典Dictionary。和ObjC不同的是，由于Swift的强类型，集合中的元素必须是同一类型，而不能像ObjC一样可以存储任何对象类型,并且注意Swift中的集合是值类型而非引用类型（事实上包括String、结构体struct、枚举enum都是值类型）。

var a2:[String] = ["Hello","World"]
var a1:Array<String> = ["Hello","World"]

for i in a2{
    println("i=\(i)")
}

//下面创建一个Double类型的数组，这里没有使用字面量，当前是一个空数组，当然也可以写成

var b2=[Double]()
var b1:[Double]=[]


//添加元素 Swift中可变类型不再由单独的一个类型来表示，统统使用Array，如果想声明为不可变数组只要使用let定义即可
a2.append("!")

a2+=["mangues","good"]

println("a count=\(a2.count)")

a2[1...3]=["I","Love","Swift"] //修改元素,但是注意无法用这种方式添加元素

//a[6]=["."]//这种方式时错误的

a2.insert("new", atIndex: 5)//插入元素：hello world! I Love New Swift

a2.removeAtIndex(5)//删除指定元素

//使用全局enumerate函数遍历数据索引和元素
for (index,element) in enumerate(a2){
    println("index=\(index),element=\(element)")
}

//使用构造函数限制数组元素个数并且指定默认值,等价于var c=Array(count: 3, repeatedValue: 1)，自动推断类型

var c1=Array(count: 3, repeatedValue: 1)
var c2 = [Int](count:3,repeatedValue:1)


//Set表示没有顺序的集合：
var a11:Set<String> = ["Hello","World"]
var a12:Set = [1,2]  //类型推断：Set<Int>
if(!a11.isEmpty){   //判断是否为空
    a11.remove("Hello")
}

if !a11.contains("!"){
    a11.insert("!")
}

//Dictionary字典同样是没有顺序的，并且在Swift中字典同样要在使用时明确具体的类型。和ObjC中一样，字典必须保证key是唯一的，而这一点就要求在Swift中key必须是可哈希的，不过幸运的是Swift中的基本类型（如Int、Float、Double、Bool、String）都是可哈希的，都可以作为key。

//通过字面量进行字典初始化，注意等价于
var a21:Dictionary<Int,String>=[200:"success",404:"not found"]
var a22:[Int:String] = [200:"Success",300:"no found"]
var a23 = [200:"Success",300:"no found"]


a22[200]   //读取
a22[300] = "mangues"  //修改
a22[400] = "bbbbbb"   //添加
//a=[:]  //设置为空字典，等价于:a = [Int:String]()

for code in a22.keys{
    println("code=\(code)")
}

for description in a22.values{
    println("description=\(description)")
}

for (code,description) in a22{
    println("code=\(code),description=\(description)")
}






















