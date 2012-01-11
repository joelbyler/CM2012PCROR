This project is code from the 'Fundamental Rails' precompiler at CodeMash 2012.

Nothing really exciting to see here.  But if you want to look, feel free.

Notes below.

Tutorial, open source.  

http://tutorials.jumpstartlab.com/paths/codemash_rails.html
http://tutorials.jumpstartlab.com/projects/jsblogger.html


MRI-Max Ruby Interpreter.

Ruby -> Interpreter -> OS -> Hardware Resources -> OS -> Interpreter -> Ruby

User
V
Verb & URL (GET /articles/1)
V
Webserver Apache or Nginx
V
Router
	verb is GET
	controler is ArticlesController
	params[:id] = 1
V	
ArticlesController
	SHOW Action
V
Article Model
	.find(1)
V
Database
	SELECT * FROM articles WHERE id=1 LIMIT 1
V
Article Model
V
View Template
	/views/articles/show.html.erb
V
Response
	HTML


instead of TDD for this session, we'll do EDD (Error Driven Development) ;o)




