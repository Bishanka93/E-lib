// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Decentralised E-Library
/// @notice A basic contract to manage books and user access in a decentralised library
contract Project {
    address public owner;

    struct Book {
        string title;
        string author;
        string ipfsHash;
    }

    mapping(uint => Book) public books;
    uint public bookCount;

    mapping(address => bool) public registeredUsers;

    event BookAdded(uint bookId, string title, string author);
    event UserRegistered(address user);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Add a new book to the library
    function addBook(string memory _title, string memory _author, string memory _ipfsHash) public onlyOwner {
        books[bookCount] = Book(_title, _author, _ipfsHash);
        emit BookAdded(bookCount, _title, _author);
        bookCount++;
    }

    /// @notice Register a user to access library resources
    function registerUser(address _user) public onlyOwner {
        require(!registeredUsers[_user], "User already registered");
        registeredUsers[_user] = true;
        emit UserRegistered(_user);
    }

    /// @notice Get book info by ID
    function getBook(uint _id) public view returns (string memory, string memory, string memory) {
        require(_id < bookCount, "Book does not exist");
        Book memory book = books[_id];
        return (book.title, book.author, book.ipfsHash);
    }
}
