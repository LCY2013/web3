// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
Solidity 中与函数输出相关的有两个关键字：return和returns。它们的区别在于：

returns：跟在函数名后面，用于声明返回的变量类型及变量名。
return：用于函数主体中，返回指定的变量。
*/

contract function_out{ // 定义一个合约
    uint public a; // 定义一个变量a
    
    constructor () { // 定义一个构造函数
        a = 100;
    }
    
    function returnValue() external view  returns(uint) {// 定义一个返回值为uint的函数
        return a; // 返回a
    }

    // 返回多个变量
    function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
        return(1, true, [uint256(1),2,5]);
    }

    /*
    在上述代码中，我们利用 returns 关键字声明了有多个返回值的 returnMultiple() 函数，然后我们在函数主体中使用 return(1, true, [uint256(1),2,5]) 确定了返回值。

    这里uint256[3]声明了一个长度为3且类型为uint256的数组作为返回值。因为[1,2,3]会默认为uint8(3)，因此[uint256(1),2,5]中首个元素必须强转uint256来声明该数组内的元素皆为此类型。
    数组类型返回值默认必须用memory修饰.
    */

    // 可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些变量的值，无需使用 return。
    // 命名式返回
    function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        _number = 2;
        _bool = false;
        _array = [uint256(3),2,1];
    }

    // 在上述代码中，我们用 returns(uint256 _number, bool _bool, uint256[3] memory _array) 声明了返回变量类型以及变量名。这样，在主体中只需为变量 _number、_bool和_array 赋值，即可自动返回。
    // 当然，你也可以在命名式返回中用 return 来返回变量：
    // 命名式返回，依然支持return
    function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        return(1, true, [uint256(1),2,5]);
    }

    // Solidity 支持使用解构式赋值规则来读取函数的全部或部分返回值。

    function readReturn() public pure {
        // 读取所有返回值：声明变量，然后将要赋值的变量用,隔开，按顺序排列。
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;
        (_number, _bool, _array) = returnNamed();
        
    }


}
