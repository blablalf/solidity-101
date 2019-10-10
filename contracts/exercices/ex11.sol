pragma solidity >=0.4.21 <0.6.0;


import "../exerciceTemplate.sol";
import "./ex11b.sol";
/*
Exercice 11: Understanding how contracts communicate with each other.
This contract (11) reads a value from another contract (11b).
In this exercice, you need to:
- Find out the address of contract 11b
- Understand which function of contract 11b contract 11 calls
- Use contract 11b to find out what is the value required
- Call contract 11 with the correct value, which will call contract 11b to check you have the correct value, and deliver your points.
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c#targetText=When%20we%20write%20Smart%20Contracts,treating%20deployed%20contracts%20like%20libraries.

*/
contract ex11 is exerciceTemplate {

  address public ex11bAddress;
  constructor(address payable _studentsOrganAddres, address payable _teachersOrganAddress, address payable _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}

  function setex11bAddress(address _ex11bAddress) 
  public 
  onlyTeacher
  {
   ex11bAddress = _ex11bAddress;
  }

  function askForPoints(uint _aValueToInput) 
  public 
  canWorkOnExercice 
  {
    // Instanciating the external contract
    ex11b ex11bInstance = ex11b(ex11bAddress);

    // Retrieving value from external contract
    uint retrievedSecretValue = ex11bInstance.secretValue();

    // Checking that our input value is the one stored in contract ex11b
    require(_aValueToInput == retrievedSecretValue);

    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }


}
