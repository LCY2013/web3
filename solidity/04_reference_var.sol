// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// 介绍Solidity中的两个重要变量类型：数组（array）和结构体（struct）。

// 数组 array
// 数组（Array）是Solidity常用的一种变量类型，用来存储一组数据（整数，字节，地址等等）。数组分为固定长度数组和可变长度数组两种：
contract Ref {
    // 固定长度数组：在声明时指定数组的长度。用T[k]的格式声明，其中T是元素的类型，k是长度，例如：
    // 固定长度 Array
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;

    // 可变长度数组（动态数组）：在声明时不指定数组的长度。用T[]的格式声明，其中T是元素的类型，例如：
    // 可变长度 Array
    uint[] array4;
    bytes1[] array5;
    address[] array6;
    bytes array7;

    // bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

    // 创建数组的规则

    //  在Solidity里，创建数组有一些规则：

    // 对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：
    // memory动态数组
    function memArray() public pure returns(uint[] memory, bytes memory) { //创建内存动态数组)  
        uint[] memory _array8 = new uint[](5);
        bytes memory _array9 = new bytes(9);
        return(_array8, _array9);
    }

    // 数组字面常数(Array Literals)是写作表达式形式的数组，用方括号包着来初始化array的一种方式，
    // 并且里面每一个元素的type是以第一个元素为准的，例如[1,2,3]里面所有的元素都是uint8类型，因为在Solidity中，
    // 如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type，这里默认最小单位类型是uint8。
    // 而[uint(1),2,3]里面的元素都是uint类型，因为第一个元素指定了是uint类型了，里面每一个元素的type都以第一个元素为准。 
    // 下面的例子中，如果没有对传入 g() 函数的数组进行 uint 转换，是会报错的。

    function f() public pure {
        g([uint(1), 2, 3]);
    }
    
    function g(uint[3] memory _data) public pure {
        // ...
    }

    // 如果创建的是动态数组，你需要一个一个元素的赋值。
    function memoryArray() public pure  {
        uint[] memory x = new uint[](3);
        x[0] = 1;
        x[1] = 3;
        x[2] = 4;
    }

    //数组成员
    // length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
    // push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
    // push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
    // pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。
    function arrPush() public returns (uint[] memory) {
        uint[2] memory a = [uint(1), 2];
        array4 = a;
        array4.push(3);
        return array4;
    }

    // 结构体 struct
    //Solidity支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。创建结构体的方法：
    // 结构体
    struct Student{
        uint256 id;
        uint256 score; 
    }

    Student student; // 初始一个student结构体

    // 给结构体赋值的四种方法：
    //  给结构体赋值
    // 方法1:在函数中创建一个storage的struct引用
    function initStudent1() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }

    // 方法2:直接引用状态变量的struct
    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }

    // 方法3:构造函数式
    function initStudent3() external {
        student = Student(3, 90);
    }

    // 方法4:key value
    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }


}














