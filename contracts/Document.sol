 pragma solidity >=0.4.24 <0.6.0;

contract Document {

    struct DocumentEntry {
        bytes32 checksum;
        string name;
        string comment;
        uint timestamp;
        bool isSet;
        address setBy;
    }

    mapping (bytes32 => DocumentEntry) documentMapping;
    event NewDocumentEntry(bytes32 _checksum, string _name, uint _timestamp, address indexed _setBy);

    /**
     * Read an entry from the ledger.
     **/
    function get(bytes32 _checksum) public view returns(bytes32, string memory, string memory, uint, address) {
        // Check if the document exists.
        require(documentMapping[_checksum].isSet, "Document does not exists.");
        // Return document.
        return(documentMapping[_checksum].checksum, documentMapping[_checksum].name, documentMapping[_checksum].comment,
            documentMapping[_checksum].timestamp, documentMapping[_checksum].setBy);
    }

    /**
     * Add a new entry to the ledger.
     *
     * Example: 0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08, "Name", "Comment", "1572506961"
     **/
    function set(bytes32 _checksum, string memory _name, string memory _comment, uint _timestamp) public {
        // Check if the document does not exists.
        require(!documentMapping[_checksum].isSet, "Document already exists.");
        // Set input values of the document.
        documentMapping[_checksum].checksum = _checksum;
        documentMapping[_checksum].name = _name;
        documentMapping[_checksum].comment = _comment;
        documentMapping[_checksum].timestamp = _timestamp;
        documentMapping[_checksum].isSet = true;
        documentMapping[_checksum].setBy = msg.sender;
        // Trigger event after entry has been created.
        emit NewDocumentEntry(_checksum, _name, _timestamp, msg.sender);
    }
}
