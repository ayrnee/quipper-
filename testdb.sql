DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE FOLLOWS CASCADE CONSTRAINTS;
DROP TABLE TWEETS CASCADE CONSTRAINTS;
DROP TABLE MULTIMEDIA CASCADE CONSTRAINTS;



CREATE TABLE USERS
(
  USERID VARCHAR(20) NOT NULL PRIMARY KEY,
  UNAME VARCHAR(30)
);

CREATE TABLE FOLLOWS
(
  FOLLOWER VARCHAR(20) NOT NULL,
  USERID VARCHAR(20) NOT NULL,
  PRIMARY KEY (FOLLOWER, USERID),
  FOREIGN KEY(USERID) REFERENCES USERS(USERID) ON DELETE CASCADE
);

CREATE TABLE TWEETS
(
  USERID VARCHAR(20) NOT NULL,
  TID VARCHAR(20) NOT NULL,
  PRIMARY KEY (USERID, TID),
  MSG CLOB NOT NULL, --VARCHAR(MAX)
  TSTAMP TIMESTAMP,
  FOREIGN KEY(USERID) REFERENCES USERS(USERID) ON DELETE CASCADE
);

CREATE TABLE COMMENTS
(
  USERID VARCHAR(20) NOT NULL,
  TID VARCHAR(20) NOT NULL,
  CID VARCHAR(20) NOT NULL PRIMARY KEY,
  COMMENT CLOB NOT NULL,
  TSTAMP TIMESTAMP,
  FOREIGN KEY (USERID, TID) REFERENCES TWEETS(USERID, TID) ON DELETE CASCADE
)

CREATE TABLE MULTIMEDIA
(
  USERID VARCHAR(20) NOT NULL,
  TID VARCHAR(20) NOT NULL,
  MEDIA BLOB,
  PRIMARY KEY (USERID, TID),
  FOREIGN KEY(USERID, TID) REFERENCES TWEETS(USERID, TID) ON DELETE CASCADE
);

INSERT INTO USERS
VALUES ('420', 'ERNEST');

INSERT INTO USERS
VALUES ('60', 'MARK');

INSERT INTO USERS
VALUES ('7', 'JIMOTHY');

INSERT INTO USERS
VALUES ('80', 'GUNDERSON');

INSERT INTO USERS
VALUES ('1', 'MO');

--ERNEST FOLLOWS GUNDERSON
INSERT INTO FOLLOWS
VALUES ('420', '80');
--MO FOLLOWS ERNEST
INSERT INTO FOLLOWS
VALUES ('1', '420');

--ERNEST FOLLOWS MO
INSERT INTO FOLLOWS
VALUES ('420', '1');

--ERNEST FOLLOWS SOMEONE THAT DOESNT EXIST
INSERT INTO FOLLOWS
VALUES ('420', '0');

--GUNDERSON FOLLOWS JIMOTHY
INSERT INTO FOLLOWS
VALUES ('80', '7');

INSERT INTO TWEETS
VALUES ('1', '1', 'GOOD MORNING',  CURRENT_TIMESTAMP);

INSERT INTO TWEETS
VALUES ('420', '2', 'MAN THAT WAS A GOOD BURGER',  CURRENT_TIMESTAMP);

INSERT INTO TWEETS
VALUES ('80', '3', 'J MY BEST FRIEND THANKS',  CURRENT_TIMESTAMP);

INSERT INTO TWEETS
VALUES ('1', '4', 'GOOD NIGHT',  CURRENT_TIMESTAMP);

-- list all users, get all tweets from a user, get all followers of a user, get all followers from a user, get all tweets from users you follow
SELECT * FROM USERS WHERE USERID = '420';

SELECT * FROM TWEETS WHERE USERID = '420';

SELECT UNAME FROM USERS WHERE USERID IN
(SELECT FOLLOWER FROM FOLLOWS WHERE USERID = '420');

SELECT UNAME FROM USERS WHERE USERID IN
(SELECT USERID FROM FOLLOWS WHERE FOLLOWER = '420');

SELECT TID FROM TWEETS WHERE USERID IN (SELECT UNAME FROM USERS WHERE USERID IN
(SELECT USERID FROM FOLLOWS WHERE FOLLOWER = '420')) ORDER BY TIMESTAMP;
