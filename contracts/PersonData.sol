pragma solidity >=0.7.0 <0.9.0;

contract PersonData{
     struct Person{
         string IsStudent;
         string name;
         uint8 age;
         string placeHold;
         uint classStudy;
     }

     uint public countStudent;
     address public admin;
     mapping(address => Person) public persons;
     address[] public totalAddressOfStudent;

     constructor() {
         admin = msg.sender;
     }

     modifier onlyAdmin(){
      require(admin == msg.sender, "Only admin can resovle enything");
      _;
     }

     modifier onlyCumstomer(){
          require(admin != msg.sender, "Only admin can resovle enything");
          _;
     }
     
     function addDataOffStudentToAdmin(address _addressStuednt, string memory _IsStudent, string memory _name, uint8 _age, string memory _placeHold, uint _class)  public onlyAdmin {
        bool statusAdding = true;
        if(totalAddressOfStudent.length == 0){
            statusAdding = true;
        }else{
            for(uint i = 0 ; i < totalAddressOfStudent.length ; i++){
                if(_addressStuednt == totalAddressOfStudent[i]){
                    statusAdding = false;
                    break;
                }
            } 
        }
         if(statusAdding){
                totalAddressOfStudent.push(_addressStuednt);
                persons[_addressStuednt].IsStudent = _IsStudent;
                persons[_addressStuednt].name = _name;
                persons[_addressStuednt].age = _age;
                persons[_addressStuednt].placeHold = _placeHold;
                persons[_addressStuednt].classStudy = _class;
                countStudent++;
            }else{
                revert("Address of student exited! Please use an othor address");
            }
     }

     function addDataOffStudenrToCumstom(string memory _IsStudent, string memory _name, uint8 _age, string memory _placeHold, uint _class) public onlyCumstomer{
        bool statusAdding = true;
        if(totalAddressOfStudent.length == 0){
            statusAdding = true;
        }else{
            for(uint i = 0 ; i < totalAddressOfStudent.length ; i++){
                if(msg.sender == totalAddressOfStudent[i]){
                    statusAdding = false;
                    break;
                }
            } 
        }
        if(statusAdding){
            totalAddressOfStudent.push(msg.sender);
            persons[msg.sender].IsStudent = _IsStudent;
            persons[msg.sender].name = _name;
            persons[msg.sender].age = _age;
            persons[msg.sender].placeHold = _placeHold;
            persons[msg.sender].classStudy = _class;
            countStudent++;
        }else{
            revert("Address of student exited! Please use an othor address");
        }
     }

     function deleteDataOffStuedent(address _addressOfStudent) public {
        bool statusAdding = true;
        uint positionData;
        for(uint i = 0 ; i < totalAddressOfStudent.length ; i++){
            if(msg.sender == totalAddressOfStudent[i]){
                statusAdding = false;
                positionData = i;
                break;
            }
        } 

        if(statusAdding){
            revert("Address of student not exited! Please check data of student");
        }else{
            delete totalAddressOfStudent[positionData];
            persons[_addressOfStudent].IsStudent = "";
            persons[_addressOfStudent].name = "";
            persons[_addressOfStudent].age = 0;
            persons[_addressOfStudent].placeHold = "";
            persons[_addressOfStudent].classStudy = 0;
        }
     }
}