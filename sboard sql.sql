drop user 'jboard';

create user 'jboard'@'%' identified by '!Qw234rt';
grant all privileges on `jboard`.* to 'jboard'@'%';
flush privileges;

delete from article;