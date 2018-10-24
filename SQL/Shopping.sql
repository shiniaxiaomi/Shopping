#��ݿ�����ȫ��Сд
create database shopping;

use shopping;

create table ruser 
(
id int primary key auto_increment,
username varchar(40),
password varchar(16),
phone varchar(40),
addr varchar(255),
rdate datetime
);

create table category
(
id int primary key auto_increment,
name varchar(255), 
pid int, #pidΪ0�������ڵ�
desrc varchar(255),
isleaf int, #������, ÿ��ռ��λ, ���99���ӽڵ�
grade int #��?��, ��1��ʼ
);

create table product
(
id int primary key auto_increment,
name varchar(255),
desrc varchar(255),
normalprice double,
memberprice double,
pdate datetime,
categoryid int references catetory(id)
);

create table salesorder
(
id int primary key auto_increment,
userid int,
addr varchar(255),
odate datetime,
status int
);

create table salesitem 
(
id int primary key auto_increment,
productid int, 
unitprice double, 
pcount int,
orderid int
);

#select pid, sum(pcount) sumCount from salesitem group by pid order by sumCount desc limit 0, 10 


