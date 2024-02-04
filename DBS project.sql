create schema library;
use library;

CREATE TABLE bookInfo (
  ISBN VARCHAR(20) PRIMARY KEY,
  title VARCHAR(100) NOT NULL CHECK(title <> ''),
  publisher VARCHAR(100),
  numCopy INT CHECK(numCopy > 0)
);

CREATE TABLE bookAuthor (
  ISBN VARCHAR(20) PRIMARY KEY,
  authorFirstName VARCHAR(50) NOT NULL,
  authorMiddleName VARCHAR(50) NOT NULL,
  authorLastName VARCHAR(50) NOT NULL,
  FOREIGN KEY (ISBN) REFERENCES bookInfo(ISBN)
);

CREATE TABLE userInfo (
  userID VARCHAR(50) PRIMARY KEY,
  firstName VARCHAR(50) NOT NULL,
  middleName VARCHAR(50) NOT NULL,
  lastName VARCHAR(50) NOT NULL,
  street VARCHAR(100) NOT NULL,
  city VARCHAR(50) NOT NULL,
  postalCode VARCHAR(10) NOT NULL,
  CHECK (firstName <> ''),
  CHECK (middleName <> ''),
  CHECK (lastName <> ''),
  CHECK (street <> ''),
  CHECK (city <> ''),
  CHECK (postalCode <> '')
);

CREATE TABLE userContact (
  phoneID INT PRIMARY KEY,
  userID VARCHAR(50),
  FOREIGN KEY (userID) REFERENCES userInfo(userID)
);

CREATE TABLE issues (
  userID VARCHAR(50),
  ISBN VARCHAR(20),
  issueDate DATE,
  PRIMARY KEY (userID, ISBN, issueDate),
  FOREIGN KEY (userID) REFERENCES userInfo(userID),
  FOREIGN KEY (ISBN) REFERENCES bookInfo(ISBN)
);

CREATE TABLE circulationRecord (
  circulationID INT PRIMARY KEY,
  userID VARCHAR(50),
  ISBN VARCHAR(20),
  dueDate DATE NOT NULL,
  returnDate DATE,
  FOREIGN KEY (userID) REFERENCES userInfo(userID),
  FOREIGN KEY (ISBN) REFERENCES bookInfo(ISBN),
  CHECK (dueDate IS NOT NULL),
  CHECK (returnDate IS NOT NULL)
);

CREATE TABLE fineRecord (
  fineID INT PRIMARY KEY,
  userID VARCHAR(50) NOT NULL,
  reason VARCHAR(100),
  ISBN VARCHAR(20) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (userID) REFERENCES userInfo(userID),
  FOREIGN KEY (ISBN) REFERENCES bookInfo(ISBN),
  CHECK (userID IS NOT NULL),
  CHECK (ISBN IS NOT NULL),
  CHECK (amount > 0)
);

CREATE TABLE fineDetails (
  ISBN VARCHAR(20),
  reason VARCHAR(100),
  amount DECIMAL(10,2),
  PRIMARY KEY (ISBN, reason),
  FOREIGN KEY (ISBN) REFERENCES bookInfo(ISBN)
);

ALTER TABLE usercontact ADD phoneNum CHAR(10);