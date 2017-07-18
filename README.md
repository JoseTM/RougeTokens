#  The Rouge Project crowdfunding ERC20 tokens 

This repo contains Solidity smart contract code to issue the Rouge Project ERC20 compliant crowdfunding tokens.

They are directly derived from ConsenSys/Tokens work. 

Differences with standard ERC20 tokens :

   - The tokens can be bought by sending ether to the contract address
     (the price is hardcoded 1 token = 1 finney (0.001 eth).

   - The contract implements two states (Opened & Closed) to let the owner start/stop the funding.

   - At the creation, a discountMultiplier is saved which can be used later on 
     by other contracts (eg to use the tokens as a voucher).


### Pull requests are welcome! Please keep standards discussions to the EIP repos.

> "You get a token, you get a token, everyone gets a token!" - Token the 3rd: the fun gerbil.  

### Licensed under MIT.  

This code is licensed under MIT.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
