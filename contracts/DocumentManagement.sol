pragma solidity ^0.4.8;


contract DocumentManagement {

    mapping (address => string[]) documents;

    event DocumentAdded(string indexed hash);

    function DocumentManagement() {

    }

    function addDocument(string _hash) returns (bool succcess) {
        if (hashExists(msg.sender, _hash)) {
            return false;
        }
        documents[msg.sender].push(_hash);

        DocumentAdded(_hash);

        return true;
    }

    function getDocuments() returns (bytes32[] hashes) {
        uint _count = documents[msg.sender].length;
        bytes32[] memory _hashes = new bytes32[](_count);
        for (uint i = 0; i < _count; i++) {
            _hashes[i] = stringToBytes32(documents[msg.sender][i]);
        }

        return _hashes;
    }

    function hashExists(address _user, string _hash) internal returns (bool success) {
        for (uint i = 0; i < documents[_user].length; i++) {
            if (stringsEqual(documents[_user][0], _hash)) {
                return true;
            }
        }

        return false;
    }

    function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
        bytes storage a = bytes(_a);
        bytes memory b = bytes(_b);
        if (a.length != b.length)
        return false;
        // @todo unroll this loop
        for (uint i = 0; i < a.length; i ++)
        if (a[i] != b[i])
        return false;
        return true;
    }

        function stringToBytes32(string memory source) internal returns (bytes32 result)  {
        assembly {
        result := mload(add(source, 32))
        }
        }


}
