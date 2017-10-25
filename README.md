#  The Rouge Project crowdfunding ERC20 tokens 

This repo contains Solidity smart contract code to issue the Rouge Project ERC20 compliant crowdfunding tokens.

They are directly derived from ConsenSys/Tokens work. 

Differences with standard ERC20 tokens :

   - The tokens can be bought by sending ether to the contract address (funding procedure).
     The price is hardcoded: 1 token = 1 finney (0.001 eth).
     A minimum contribution can be set by the owner.

   - The funding can only occur if the current date is superior to the startFunding parameter timestamp.
     At anytime, the creator can change this token parameter, effectively closing the funding.

   - The owner can also freeze part of his tokens to not be part of the funding procedure.

   - At the creation, a discountMultiplier is saved which can be used later on 
     by other contracts (eg to use the tokens as a voucher).


### Pull requests are welcome! Please keep standards discussions to the EIP repos.

> "You get a token, you get a token, everyone gets a token!" - Token the 3rd: the fun gerbil.  


### Proof of addresses (founders' seeds)

You can verify the signatures of these 2 messages : https://etherscan.io/verifySig

{
 "address":"0x4D6EEdec5579Fd9C22206896CBedcbC5e5605aeA",
 "msg":"vdg is 0xaa22fe5704007024b0cb4a2f46547199417fefb7 - Naira 24 July 2017",
 "sig":"0x1c8c6409ca136d75509906afe3df32db4f1df6fc8fe8d7f2cfa1558e3e9bf11346b02671d544ab2b274b68ffd2fa013c123543371c1d03b9d138c75f3a5eb20a1b"
}

{
 "address":"0xAa22Fe5704007024B0CB4A2f46547199417FEFB7",
 "msg":"Naira is 0x4d6eedec5579fd9c22206896cbedcbc5e5605aea - Vdg 24 July 2017",
 "sig":"0xb8c904f17289769c5eedeccea7db1fb3e516be00ae7b4af748f4772591e00d055ed749897ae1def1bdcd29b6985c0c208e91e98e8078a478944e66527587dc101c"
}

Addresses and the 2 messages have been posted on the 24 July at these urls :

https://twitter.com/NdArcollieres/status/889256076625014787
https://twitter.com/NdArcollieres/status/889256408855846915
https://twitter.com/NdArcollieres/status/889256681082847232
https://21.co/naira/

https://twitter.com/polygonism/status/889254546811256833
https://twitter.com/polygonism/status/889254952371191809
https://bitcointalk.org/index.php?action=profile;u=19103


### Licensed under MIT.  

This code is licensed under MIT.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
