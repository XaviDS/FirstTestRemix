//SPDX-License-Identifier: MIT

pragma solidity >0.6.0 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
contract FundMe{
    
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    
    function fund() public payable{
            //Tasa de conversión ETH/USD.
            addressToAmountFunded[msg.sender] += msg.value;

    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        ( ,int price, , , )=priceFeed.latestRoundData();
        return uint256(price);

    }

    function getConversioonRate(uint256 ethAmmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmmountInUSD = (ethPrice*ethAmmount)/100000000000000000000000000;
        return ethAmmountInUSD;

    }
        
        
        
        }