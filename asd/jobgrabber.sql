create database jobportal;
use jobportal;

drop table `user`;
drop table `jobSeeker`;
drop table recruiter;
drop table user;
drop table jobs;	
drop table admin;
drop table jobApplication;

CREATE TABLE `user` (
  id int primary key AUTO_INCREMENT,
  `name` varchar(100) NOT NUll,
  `password` varchar(50) NOT NULL,
  email_id varchar(100) NOT NULL UNIQUE,
  gender enum ('Male','Female','Others') not null,
  dateOfBirth date not null,
  userType varchar(100) not null
  
) ;

INSERT INTO `jobportal`.`user`
(
`name`,
`password`,
`email_id`,
`gender`,
`dateOfBirth`)
VALUES
('a','a','gha','Male','1212-12-12');



CREATE TABLE `jobSeeker` (
   id int primary key,
   foreign key(id)
		references `user`(id)
            on delete cascade
            on update cascade,
    `resume` blob ,
  phoneNumber varchar(10),
  location varchar(30)
    );
    
CREATE TABLE `recruiter` (    
    id int primary key, 
    foreign key(id)
		references `user`(id)
            on delete cascade
            on update cascade,
    `company` varchar(100) NOT NULL
    );
    
    
CREATE TABLE `admin` (    
    id int primary key, 
    foreign key(id)
		references `user`(id)
            on delete cascade
            on update cascade
    );
        
    
CREATE TABLE `jobs` (
      id int primary key,
      `postedBy` int not null,
      foreign key(`postedBy`)
			references `recruiter`(id)
            on update cascade
            on delete cascade,
	  `title` varchar(120) not null,
      `datePosted` date not null,
      `jobDetail` text ,
      `jobLocation` varchar(30)
      );
      
/*      
 CREATE TABLE `searchjob` (
	`searchedBy` int not null,
    foreign key (`searchedBy`) references `jobSeeker`(id)
		on update cascade on delete cascade,
    `searches` int not null,
    foreign key (`searches`) references `jobs`(id)
		on update cascade on delete cascade,
    `sortBy` enum ('Date', 'Company')   not null,
    primary key (`searchedBy`,`searches`)
    );
  */  
 CREATE TABLE `jobApplication` (
	`appliedBy` int not null,
    foreign key (`appliedBy`) references `jobSeeker`(id)
		on update cascade on delete cascade,
    `applies` int not null,
    foreign key (`applies`) references `jobs`(id)
		on update cascade on delete cascade,
    `accessedBy` int not null,
    foreign key (`accessedBy`) references `recruiter`(id)
		on update cascade on delete no action,
    primary key (`appliedBy`,`applies`, `accessedBy`)
    );           
    
    