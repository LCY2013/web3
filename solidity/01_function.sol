// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
pure，中文意思是“纯”，这里可以理解为”纯打酱油的”。pure 函数既不能读取也不能写入链上的状态变量。就像小怪一样，看不到也摸不到碧琪公主。
 view，“看”，这里可以理解为“看客”。view函数能读取但也不能写入状态变量。类似马里奥，能看到碧琪公主，但终究是看客，不能入洞房。
 非 pure 或 view 的函数既可以读取也可以写入状态变量。类似马里奥里的 boss，可以对碧琪公主为所欲为🐶。
*/

contract FunctionTypes{
    uint256 public number = 5;

    // 默认function
    function add() external {
        number = number + 1;
    }

    /* 错误示例
    function add() external pure{
        number = number + 1;
    }
    function add() external view{
        number = number + 1;
    }
    */

    // pure: 纯纯牛马
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number + 1;
    }

    //如果 add() 函数被标记为 pure，比如 function add() external pure，就会报错。因为 pure 是不配读取合约里的状态变量的，更不配改写。
    //那 pure 函数能做些什么？举个例子，你可以给函数传递一个参数 _number，然后让他返回 _number + 1，这个操作不会读取或写入状态变量。

    //如果 add() 函数被标记为 view，比如 function add() external view，也会报错。
    //因为 view 能读取，但不能够改写状态变量。我们可以稍微改写下函数，读取但是不改写 number，返回一个新的变量。


    // view: 看客
    function addView() external view returns(uint256 new_number) {
        new_number = number + 1;
    }

    //internal v.s. external

    // internal: 内部函数
    function minus() internal {
        number = number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }

    // 我们定义一个 internal 的 minus() 函数，每次调用使得 number 变量减少 1。
    // 由于 internal 函数只能由合约内部调用，我们必须再定义一个 external 的 minusCall() 函数，通过它间接调用内部的 minus() 函数。

    // payable: 递钱，能给合约支付eth的函数
    function minusPayable() external payable returns(uint256 balance) {
        minus();    
        balance = address(this).balance;
    }

    // 我们定义一个 external payable 的 minusPayable() 函数，间接的调用 minus()，并且返回合约里的 ETH 余额（this 关键字可以让我们引用合约地址）。
    // 我们可以在调用 minusPayable() 时往合约里转入1个 ETH。

}


