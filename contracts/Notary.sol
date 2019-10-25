 pragma solidity >=0.4.24 <0.6.0;

contract Notary {

    struct NotaryEntry {
        string name;
        uint timestamp;
        bytes32 checksum;
        string comment;
        bool isSet;
        address setBy;
    }

    mapping (bytes32 => NotaryEntry) notaryMapping;
    event NewNotaryEntry(bytes32 _checksum, string _name, address indexed _setBy);
    /**
     * Add a new entry to the ledger.
     *
     * Example: 0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08, "Name", "Comment"
     **/
    function createEntry(bytes32 _checksum, string memory _name, string memory _comment) public {
        // Check if the entry does not exists.
        require(!notaryMapping[_checksum].isSet, "Entry already exists.");
        // Set the default and input values of the entry.
        notaryMapping[_checksum].isSet = true;
        notaryMapping[_checksum].name = _name;
        notaryMapping[_checksum].timestamp = now;
        notaryMapping[_checksum].comment = _comment;
        notaryMapping[_checksum].setBy = msg.sender;
        // Trigger event after entry has been created.
        emit NewNotaryEntry(_checksum, _name, msg.sender);
    }
    /**
     * Read an entry from the ledger.
     **/
    function readEntry(bytes32 _checksum) public view returns(string memory, uint, string memory, address) {
        // Check if the entry exists.
        require(notaryMapping[_checksum].isSet, "Entry does not exists.");
        // Return entry.
        return(notaryMapping[_checksum].name, notaryMapping[_checksum].timestamp,
        notaryMapping[_checksum].comment, notaryMapping[_checksum].setBy);
    }
}