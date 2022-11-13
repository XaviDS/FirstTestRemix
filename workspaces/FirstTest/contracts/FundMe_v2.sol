//SPDX-License-Identifier: MIT

pragma solidity >0.6.0 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
contract FundMe_v2{
    uint256 convertToWei=1000000000000000000;
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    
    address public owner;
    address[] public funders;

    constructor() public{
        owner = msg.sender;

    }
    function fund() public payable{
           //Mínimo 10$.
           uint256 minimumUSD= 10;
           require(getConversionRateInUSD(msg.value)>=minimumUSD, "You need to send more ETH!");
        
            //Tasa de conversión ETH/USD.
            addressToAmountFunded[msg.sender] += msg.value;
            funders.push(msg.sender);

    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        ( ,int price, , , )=priceFeed.latestRoundData();
        return uint256(price*10000000000);

    }

    function getConversionRateInUSD(uint256 ethAmmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmmountInUSD = (ethPrice*ethAmmount)/(convertToWei**2);
        return ethAmmountInUSD;

    }

    modifier onlyOwner{

        require(msg.sender==owner);
        _;
   }

    function withdraw() payable onlyOwner public{
        msg.sender.transfer(address(this).balance);
        for(uint256 funderIndex; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
         
        }
       funders = new address[](0);

    
    }
        
        
        
        }