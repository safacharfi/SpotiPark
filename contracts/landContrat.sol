pragma solidity >=0.4.22 <0.9.0;

contract Land {
    address contractOwner;

    constructor() public{
        contractOwner = msg.sender;
    }

    struct Admin {
        uint id;
        address _addr;
        string name;
        uint age;
        string designation;
        string city;
    }
     uint inspectorsCount;


    mapping(address => Admin) public InspectorMapping;
    mapping(uint => address[]) allAdminList;
    mapping(address => bool)  RegisteredInspectorMapping;
  


    function isContractOwner(address _addr) public view returns(bool){
        if(_addr==contractOwner)
            return true;
        else
            return false;
    }

    function changeContractOwner(address _addr)public {
        require(msg.sender==contractOwner,"you are not contractOwner");

        contractOwner=_addr;
    }

    //-----------------------------------------------Admin-----------------------------------------------

    function addAdmin(address _addr,string memory _name, uint _age, string memory _designation,string memory _city) public returns(bool){
        if(contractOwner!=msg.sender)
            return false;
        require(contractOwner==msg.sender);
        RegisteredInspectorMapping[_addr]=true;
        allAdminList[1].push(_addr);
        InspectorMapping[_addr] = Admin(inspectorsCount,_addr,_name, _age, _designation,_city);
        return true;
    }

    function ReturnAllLandIncpectorList() public view returns(address[] memory)
    {
        return allAdminList[1];
    }

    function removeAdmin(address _addr) public{
        require(msg.sender==contractOwner,"You are not contractOwner");
        require(RegisteredInspectorMapping[_addr],"Land Inspector not found");
        RegisteredInspectorMapping[_addr]=false;


        uint len=allAdminList[1].length;
        for(uint i=0;i<len;i++)
        {
            if(allAdminList[1][i]==_addr)
            {
                allAdminList[1][i]=allAdminList[1][len-1];
                allAdminList[1].pop();
                break;
            }
        }
    }

    function isAdmin(address _id) public view returns (bool) {
        if(RegisteredInspectorMapping[_id]){
            return true;
        }else{
            return false;
        }
    }







}