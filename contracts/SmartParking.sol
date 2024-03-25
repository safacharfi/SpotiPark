// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0 ;

contract SmartParking{
        uint256 public vehicleCount;

    constructor() public{
        minter = msg.sender ;
        UserCount = 0;
        vehicleCount=0;

        
    }
    //money part
    address public minter ;
    mapping(address => uint) public balance ;

    // Events allow light client to react on changes effectively
    event Sent(address from, address to, uint amount) ;
    function mint(address receiver, uint amount) public{
        balance[receiver] += amount ;
    }

    function send(address sender, address receiver, uint amount) public{
        if(balance[sender] < amount) revert() ;
        balance[sender] -= amount ;
        balance[receiver] += amount ;
        emit Sent(sender,receiver,amount) ;
    }

    //authentification
        uint256 public UserCount;

    struct User {
        uint256 id;
        string name;
        string password;
        string phone;
    }

    event UserAdded(uint256 _id);
    event UserDeleted(uint256 _id);
    event UserEdited(uint256 _id);
  

    mapping(address => uint256) public userBalances;
    mapping(uint256 => User) public users;

   

    function getUserCount() public view returns (uint256) {
        return UserCount;
    }

    function addUser(
        string memory _name,
        string memory _password,
        string memory _phone
    ) public {
        users[UserCount] = User(
            UserCount,
            _name,
            _password,
            _phone
        );
        userBalances[msg.sender] = ++UserCount;

        emit UserAdded(UserCount);
    }

    function deleteUser(uint256 _id) public {
        delete users[_id];
        UserCount--;
        emit UserDeleted(_id);
    }

    function editUser(
        uint256 _id,
        string memory _name,
        string memory _password,
        string memory _phone
    ) public {
        users[_id] = User(_id, _name, _password, _phone);
        emit UserEdited(_id);
    }

    function signin(string memory _name, string memory _password) public view returns (bool) {
        for (uint256 i = 0; i < UserCount; i++) {
            if (keccak256(bytes(users[i].name)) == keccak256(bytes(_name)) &&
                keccak256(bytes(users[i].password)) == keccak256(bytes(_password))) {
                return true;
            }
        }
        return false;
    }
    //booking part
     address[20] public adopters ;

    function adopt(uint catId, address adopter, string memory duration,string memory startTime) public returns(uint) {
        require(catId>=0 && catId<=19) ;
        adopters[catId] = adopter ;
        return catId ;
    }

    function getAdopters() public view returns(address[20] memory){
        return adopters ;
    }
    //vehicule part
      struct Vehicle {
        uint256 id;
        string brand;
        string lisencePlate;
        string model;
    }
        mapping(uint256 => Vehicle) public vehicles;
   event VehicleAdded(uint256 _id);
    event VehicleDeleted(uint256 _id);
    event VehicleEdited(uint256 _id);
         function getVehiculeCount() public view returns (uint256 ){
        return vehicleCount;
    }

    function addVehicle(
        string memory _brand,
        string memory _lisencePlate,
        string memory _model
    ) public {
        vehicles[vehicleCount] = Vehicle(
            vehicleCount,
            _brand,
            _lisencePlate,
            _model
        );
        emit VehicleAdded(vehicleCount);
        vehicleCount++;
    }

    function deleteVehicle(uint256 _id) public {
        delete vehicles[_id];
        vehicleCount--;
        emit VehicleDeleted(_id);
    }

    function editVehicle(
        uint256 _id,
        string memory _brand,
        string memory _lisencePlate,
        string memory _model
    ) public {
        vehicles[_id] = Vehicle(_id, _brand, _lisencePlate, _model);
        emit VehicleEdited(_id);
    }


   }