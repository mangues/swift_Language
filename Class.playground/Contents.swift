//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
//作为一门面向对象语言，类当然是Swift中的一等类型。首先通过下面的例子让大家对Swift的class有一个简单的印象，在下面的例子中可以看到Swift中的属性、方法（包括构造方法和析构方法）：
class Person {
    //定义属性
    var name:String
    var heigth = 0.0
    //构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(name:String){
        self.name = name;
    }
    
    //定义方法
    func showMessage(){
        println("name=\(name),heigth=\(heigth)")
        
    }
    
    //析构方法，在对象被稀释时调用，类似于oc的dealloc，注意此函数没有括号，没参数，无法直接调用
    deinit{
        println("deinit....e")
    }
    
    
}

var p = Person(name: "kenhin")     //要写上 外部参数名
p.heigth = 172.0
p.showMessage()

//类是引用类型
var p2 = p
p2.name = "mangues"
println(p.name)
if p===p2 {   // === 表示等价于，这里不能使用 == （等于用于比较值相等，p和p2是不同的值，只是指向的对象相同）
    println("p===p2") //p等价于p2,二者指向同一个对象
}

//从上面的例子不难看出：
//
//Swift中的类不必须继承一个基类（但是ObjC通常必须继承于NSObject），如果一个类没有继承于任何其他类则这个类也称为“基类”；
//Swift中的属性定义形式类似于其他语句中的成员变量（或称之为“实例变量”），尽管它有着成员变量没有的特性；
//Swift中如果开发者没有自己编写构造方法那么默认会提供一个无参数构造方法（否则不会自动生成构造方法）；
//Swift中的析构方法没有括号和参数，并且不支持自行调用；



/**
*  @author mangues, 15-08-27 14:08:54
*
*  属性

* Swift中的属性分为两种：存储属性（用于类、结构体）和计算属性（用于类、结构体、枚举），并且在Swift中并不强调* 成员变量的概念。 无论从概念上还是定义方式上来看存储属性更像其他语言中的成员变量，但是不同的是可以控制读写操作、通过属性监视器来属性的变化以及快速实现懒加载功能。
*/


class Account {
    var balance:Double = 0.0
    let sss:Int = 0
    var aaa:String;
    init(aaa:String){
        self.aaa = aaa
    }
}

class People {
    //firstName、lastName、age 是存储属性
    var firstName:String
    var lastName:String
    let age:Int
    
    //fullName 是一个计算属性。并且由于只定义了一个get方法，所以是一个只读属性
    var fullName:String {
        get{
            return firstName + "." + lastName
        }
        
        set{
            let array=split(newValue, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {$0=="."})
            if array.count == 2 {
                firstName=array[0]
                lastName=array[1]
            }
        }
        //set方法中的newValue表示即将赋的新值，可以自己设置set中的newValue变量，如下：
        //        set(myValue){
        
        //        }
    }
    //如果fullName只有get则是一个只读属性，只读属性可以简写如下：
    //    var fullName:String{
    //        return firstName + "." + lastName
    //    }
    
    //属性的懒加载，第一次访问才会计算初始值，在Swift中懒加载的属性不一定就是对象类型，也可以是基本类型
    lazy var account = Account(aaa:"aaa")//lazy属性必须有初始值
    
    
    //构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(firstName:String,lastName:String,age:Int){
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
    }
    
    //定义方法
    func showMessage(){
        println("name=\(self.fullName)")
    }
}
var p3=People(firstName: "Kenshin", lastName: "Cui",age:29)
p3.fullName="Kaoru.Sun"
p3.account.balance=10
p3.showMessage()

//需要提醒大家的是：
//
//计算属性并不直接存储一个值，而是提供getter来获取一个值，或者利用setter来间接设置其他属性；
//lazy属性必须有初始值，必须是变量不能是常量（因为常量在构造完成之前就已经确定了值）；
//在构造方法之前存储属性必须有值，无论是变量属性（var修饰）还是常量属性（let修饰）这个值既可以在属性创建时指定也可以在构造方法内指定；




/**
*  @author mangues, 15-08-27 14:08:27
*
*  从上面的例子中不难区分存储属性和计算属性，计算属性通常会有一个setter、getter方法，如果要监视一个计算属性的变化在setter方法中即可办到（因为在setter方法中可以newValue或者自定义参数名），但是如果是存储属性就无法通过监视属性的变化过程了，因为在存储属性中是无法定义setter方法的。不过Swift为我们提供了另外两个方法来监视属性的变化那就是willSet和didSet，通常称之为“属性监视器”或“属性观察器”。
*/

class Account1 {
    //注意设置默认值0.0时监视器不会被调用
    var balance:Double=0.0{
        willSet{
            self.balance=2.0
            //注意newValue可以使用自定义值,并且在属性监视器内部调用属性不会引起监视器循环调用,注意此时修改balance的值没有用
            println("Account.balance willSet,newValue=\(newValue),value=\(self.balance)")
        }
        didSet{
            self.balance=3.0
            //注意oldValue可以使用自定义值,并且在属性监视器内部调用属性不会引起监视器循环调用，注意此时修改balance的值将作为最终结果
            println("Account.balance didSet,oldValue=\(oldValue),value=\(self.balance)")
        }
    }
}


class Person1 {
    var firstName:String
    var lastName:String
    let age:Int
    
    var fullName:String{
        get{
            return firstName + "." + lastName
        }
        set{
            //对于计算属性可以直接在set方法中进行属性监视
            let array=split(newValue, maxSplit: Int.max, allowEmptySlices: false, isSeparator: { $0 == "." })
            if array.count == 2 {
                firstName=array[0]
                lastName=array[1]
            }
        }
    }
    lazy var account = Account1()
    init(firstName:String,lastName:String,age:Int){
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
    }
    
    //类型属性
    static var skin:Array<String>{
        return ["yellow","white","black"];
    }
    
}

var pp = Person1(firstName: "Kenshin", lastName: "Cui",age:29)
pp.account.balance=1.0
println("p.account.balance=\(pp.account.balance)") //结果：p.account.balance=3.0
for color in Person1.skin {
    println(color)
}


//和setter方法中的newValue一样，默认情况下载willSet和didSet中会有一个newValue和oldValue参数表示要设置的新值和已经被修改过的旧值（当然参数名同样可以自定义）；
//存储属性的默认值设置不会引起属性监视器的调用（另外在构造方法中赋值也不会引起属性监视器调用），只有在外部设置存储属性才会引起属性监视器调用；
//存储属性的属性监视器willSet、didSet内可以直接访问属性，但是在计算属性的get、set方法中不能直接访问计算属性，否则会引起循环调用；
//在didSet中可以修改属性的值，这个值将作为最终值（在willSet中无法修改）；









/**
*  @author mangues, 15-08-27 14:08:13
*
*  方法

方法就是与某个特定类关联的函数，其用法和前面介绍的函数并无二致，但是和ObjC相比，ObjC中的函数必须是C语言，而方法则必须是ObjC。此外其他语言中方法通常存在于类中，但是Swift中的方法除了在类中使用还可以在结构体、枚举中使用。关于普通的方法这里不做过多赘述，用法和前面的函数区别也不大，这里主要看一下构造方法
*/

class Person2 {
    //定义属性
    var name:String
    var height:Double
    var age=0
    
    //指定构造器方法，注意如果不编写构造方法默认会自动创建一个无参构造方法
    init(name:String,height:Double,age:Int){
        self.name=name
        self.height=height
        self.age=age
    }
    
    //便利构造方法，通过调用指定构造方法、提供默认值来简化构造方法实现
    convenience init(name:String){
        self.init(name:name,height:0.0,age:0)
    }
    
    //实例方法
    func modifyInfoWithAge(age:Int,height:Double){
        self.age=age
        self.height=height
    }
    
    //类型方法
    class func showClassName(){
        println("Class name is \"Person\"")
    }
    
    //析构方法，在对象被释放时调用,类似于ObjC的dealloc，注意此函数没有括号，没有参数，无法直接调用
    deinit{
        println("deinit...")
    }
    
}

//通过便利构造方法创建对象
var p4=Person2(name: "kenshin")


//除构造方法、析构方法外的其他方法的参数默认除了第一个参数是局部参数，从第二个参数开始既是局部参数又是外部参数（这种方式和ObjC的调用方式很类似，当然，可以使用“#”将第一个参数同时声明为外部参数名，也可以使用“_”将其他参数设置为非外部参数名）。但是，对于函数，默认情况下只有默认参数既是局部参数又是外部参数，其他参数都是局部参数。
//构造方法的所有参数默认情况下既是外部参数又是局部参数；
//Swift中的构造方法分为“指定构造方法”和“便利构造方法（convenience）”，指定构造方法是主要的构造方法，负责初始化所有存储属性，而便利构造方法是辅助构造方法，它通过调用指定构造方法并指定默认值的方式来简化多个构造方法的定义，但是在一个类中至少有一个指定构造方法。



/**
*  @author mangues, 15-08-27 15:08:36
*
*  下标脚本
*/

//下标脚本是一种访问集合的快捷方式，例如：var a:[string],我们经常使用a[0]、a[1]这种方式访问a中的元素，0和1在这里就是一个索引，通过这种方式访问或者设置集合中的元素在Swift中称之为“下标脚本”（类似于C#中的索引器）。从定义形式上通过“subscript”关键字来定义一个下标脚本，很像方法的定义，但是在实现上通过getter、setter实现读写又类似于属性。假设用Record表示一条记录，其中有多列，下面示例中演示了如何使用下标脚本访问并设置某一列的值。



class Record {
    //定义属性，假设store是Record内部的存储结构
    var store:[String:String]
    
    init(data:[String:String]){
        self.store=data
    }
    
    //下标脚本（注意也可以实现只有getter的只读下标脚本）
    subscript(index:Int)->String{
        get{
            var key=sorted(Array(self.store.keys))[index]
            return self.store[key]!
        }
        set{
            var key=sorted(Array(self.store.keys))[index]
            self.store[key]=newValue //newValue参数名可以像属性一样重新自定义
        }
    }
    
    //下标脚本（重载）
    subscript(key:String)->String{
        get{
            return store[key]!
        }
        set{
            store[key]=newValue
        }
    }
}

var r=Record(data:["name":"kenshin","sex":"male"])
println("r[0]=\(r[0])") //结果：r[0]=kenshin
r["sex"]="female"
println(r[1]) //结果：female






















