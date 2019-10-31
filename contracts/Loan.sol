 pragma solidity >=0.4.24 <0.6.0;

contract Loan {

    struct LoanEntry {
        bytes32 checksum;
        string code;
        string status;
        uint timestamp;
        bool isSet;
        address setBy;
    }

    mapping (bytes32 => LoanEntry) loanMapping;
    event NewLoanEntry(bytes32 _checksum, string _code, string _status, uint _timestamp, address indexed _setBy);
    /**
     * Add a new entry to the ledger.
     *
     * Example: 0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08, "P8ADSJ0ASA", "Status"
     **/
    function createLoanEntry(bytes32 _checksum, string memory _code, string memory _status, uint _timestamp) public {
        // Check if the entry does not exists.
        require(!loanMapping[_checksum].isSet, "Loan already exists.");
        // Set the default and input values of the entry.
        loanMapping[_checksum].checksum = _checksum;
        loanMapping[_checksum].code = _code;
        loanMapping[_checksum].status = _status;
        loanMapping[_checksum].timestamp = _timestamp;
        loanMapping[_checksum].isSet = true;
        loanMapping[_checksum].setBy = msg.sender;
        // Trigger event after entry has been created.
        emit NewLoanEntry(_checksum, _code, _status, _timestamp, msg.sender);
    }
    /**
     * Read an entry from the ledger.
     **/
    function readLoanEntry(bytes32 _checksum) public view returns(bytes32, string memory, string memory, uint, address) {
        // Check if the entry exists.
        require(loanMapping[_checksum].isSet, "Loan does not exists.");
        // Return entry.
        return(loanMapping[_checksum].checksum, loanMapping[_checksum].code, loanMapping[_checksum].status,
            loanMapping[_checksum].timestamp, loanMapping[_checksum].setBy);
    }
}
