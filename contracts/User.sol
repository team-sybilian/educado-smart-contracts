 pragma solidity >=0.4.24 <0.6.0;

contract User {

    struct UserEntry {
        bytes32 checksum;
        string name;
        string userType;
        uint timestamp;
        bool isSet;
        address setBy;
    }

    mapping (bytes32 => UserEntry) userMapping;
    event NewUserEntry(bytes32 _checksum, string _name, string _userType, uint _timestamp, address indexed _setBy);
    /**
     * Add a new entry to the ledger.
     *
     * Example: 0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08, "Name", "Type", "1572506961"
     **/
    function createUserEntry(bytes32 _checksum, string memory _name, string memory _class, uint _timestamp) public {
        // Check if the entry does not exists.
        require(!userMapping[_checksum].isSet, "User already exists.");
        // Set the default and input values of the entry.
        userMapping[_checksum].checksum = _checksum;
        userMapping[_checksum].name = _name;
        userMapping[_checksum].userType = _userType;
        userMapping[_checksum].timestamp = _timestamp;
        userMapping[_checksum].isSet = true;
        userMapping[_checksum].setBy = msg.sender;
        // Trigger event after entry has been created.
        emit NewUserEntry(_checksum, _name, _class, _timestamp, msg.sender);
    }
    /**
     * Read an entry from the ledger.
     **/
    function readUserEntry(bytes32 _checksum) public view returns(bytes32, string memory, string memory, uint, address) {
        // Check if the entry exists.
        require(userMapping[_checksum].isSet, "User does not exists.");
        // Return entry.
        return(userMapping[_checksum].checksum, userMapping[_checksum].name, userMapping[_checksum].userType,
            userMapping[_checksum].timestamp, userMapping[_checksum].setBy);
    }
}
