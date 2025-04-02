// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// 引用类型(Reference Type) ：包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置。

contract StorageScope {

    // Solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。
    // storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。
    // 整体消耗gas从多到少依次为：storage > memory > calldata。大致用法：
    // storage：合约里的状态变量默认都是storage，存储在链上。
    // memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
    // calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。例子：
    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        //_x[0] = 0; //这样修改会报错
        return(_x);
    }
    // 在不同存储类型相互赋值时候，有时会产生独立的副本（修改新变量不会影响原变量），有时会产生引用（修改新变量会影响原变量）。规则如下：
    // 赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：
    // storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。例子：
    uint[]  x = [1,2,3]; // 状态变量：数组 x

    function fStorage() public{
        //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }

    function fMemory() public view {
        // 声明一个memory类型的变量xMemory, 复制x，修改xMemory不会影响x
        uint[] memory xMemory = x;
        xMemory[0] = 1024;
    }

    // memory赋值给memory，会创建引用，改变新变量会影响原变量。

    // 其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方。这有时会涉及到开发中的问题，
    // 比如从storage中读取数据，赋值给memory，然后修改memory的数据，但如果没有将memory的数据赋值回storage，
    // 那么storage的数据是不会改变的。


}

// Solidity中变量按作用域划分有三种，分别是状态变量（state variable），局部变量（local variable）和全局变量(global variable)

// 状态变量
// 状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明：
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;

    // 我们可以在函数里更改状态变量的值：
    function foo() external{
        // 可以在函数里更改状态变量的值
        x = 5;
        y = 2;
        z = "0xAA";
    }
}

// 局部变量
// 局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明：
contract VariablesLocal {
    function bar() external pure returns(uint){
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }
}

// 全局变量
// 全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用：
contract VariablesGlobal {
    function global() external view returns(address, uint, bytes memory){
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender, blockNum, data);
    }
}

/*
在上面例子里，我们使用了3个常用的全局变量：msg.sender，block.number和msg.data，他们分别代表请求发起地址，当前区块高度，和请求数据。下面是一些常用的全局变量，更完整的列表请看这个链接：

blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于最近的256个区块, 不包含当前区块。
block.coinbase: (address payable) 当前区块矿工的地址
block.gaslimit: (uint) 当前区块的gaslimit
block.number: (uint) 当前区块的number
block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
gasleft(): (uint256) 剩余 gas
msg.data: (bytes calldata) 完整call data
msg.sender: (address payable) 消息发送者 (当前 caller)
msg.sig: (bytes4) calldata的前四个字节 (function identifier)
msg.value: (uint) 当前交易发送的 wei 值
block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。
*/


