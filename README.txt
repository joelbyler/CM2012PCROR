This project is code from the 'Fundamental Rails' precompiler at CodeMash 2012.

git add .
git commit -m 'comment goes here'
git push -u origin master

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

to create rails application
rails new jsblogger

for dependancy management
Notice 'bundle install' in console output after running rails new

Folders:
app folder is where you spend 99% of your time as a developer
config/environments allows you to set up different environments
config/database.yml allows you to set up db connections for different environments
	In dev you can run sqlite db and postgresql in production (SQL Server, MySQL, Oracle, etc).
If following an old tutorial and they say to put something in environment, usually they mean to put it in the app folder.
locales is rarely used but locales folder is where you put your other language translations
lib folder is for code that you control but it doesn't belong solely to this project (re-used for multiple projects).  Not used as much anymore, rather create your own ruby gem.
public folder is for static assets (js, css, have been moved to app folder though). Confusing.
test folder is where tests go, many users prefer to use rspec others use testunit?
db/development.sqlite3 is default location of sqlite database for dev environment.

start app with 
rails server

Don't recommend using WeBrick (works find for development)

default address is http://0.0.0.0:3000/ or http://localhost:3000
click on 'About your application’s environment' for some interesting info.  Big loud errors can show up here if there is a problem.

try command below for help on params to pass to rails generate command
rails generate

Below shows help for creating model
rails generate model 

Below will generate model, db migration script, and test stubs for Article object
rails generate model Article

Review db/migrate/20120111141624_create_articles.rb
this shows info for creating new db table 
new in rails 3.1 change instead of up / down.  write upgrade and rails can figure out how to rollback if needed.

t.string :title	instructions to add a string column to the table with the name 'title'
t.text :body 	will create a large string fild named 'body'
t.timestamps	will create two fields (created_at and updated_at) this is boiler plate and rails will maintain these for you automagically

below command will apply changes to the database for you.  This command is idpotent (spelling?), can run multiple times without fear of doing harm.
rake db:migrate

irb is interactive ruby
rails console is a rails console.  Command below
rails console

can do cool stuff in console
1.9.2-p290 :001 > 5+5
 => 10 
1.9.2-p290 :002 > Article
 => Article(id: integer, title: string, body: text, created_at: datetime, updated_at: datetime) 
1.9.2-p290 :003 > Article.new
 => #<Article id: nil, title: nil, body: nil, created_at: nil, updated_at: nil> 
1.9.2-p290 :004 > Article.new.class
 => Article(id: integer, title: string, body: text, created_at: datetime, updated_at: datetime) 
1.9.2-p290 :005 > Article.new.class.methods
 	[not showing this but it creates around 351 methods]
 	review article.rb
 	shows that the Article class inherits from ActiveRecord
1.9.2-p290 :006 > a=Article.new
=> #<Article id: nil, title: nil, body: nil, created_at: nil, updated_at: nil> 
1.9.2-p290 :007 > a.title="First Sample Article"
 => "First Sample Article" 
1.9.2-p290 :008 > a.body = "The text of the first sample"
 => "The text of the first sample" 
1.9.2-p290 :009 > a
 => #<Article id: nil, title: "First Sample Article", body: "The text of the first sample", created_at: nil, updated_at: nil> 
1.9.2-p290 :010 > a.save
  SQL (119.2ms)  INSERT INTO "articles" ("body", "created_at", "title", "updated_at") VALUES (?, ?, ?, ?)  [["body", "The text of the first sample"], ["created_at", Wed, 11 Jan 2012 14:32:32 UTC +00:00], ["title", "First Sample Article"], ["updated_at", Wed, 11 Jan 2012 14:32:32 UTC +00:00]]
 => true 
1.9.2-p290 :011 > Article.all
  Article Load (0.7ms)  SELECT "articles".* FROM "articles" 
 => [#<Article id: 1, title: "First Sample Article", body: "The text of the first sample", created_at: "2012-01-11 14:32:32", updated_at: "2012-01-11 14:32:32">] 
1.9.2-p290 :013 > Article.all.first
  Article Load (0.2ms)  SELECT "articles".* FROM "articles" 
 => #<Article id: 1, title: "First Sample Article", body: "The text of the first sample", created_at: "2012-01-11 14:32:32", updated_at: "2012-01-11 14:32:32"> 


under config folder look at routes.rb for route changes
add line below to routes.db
  resources :articles
and then the command below
rake routes
This will create a new route for articles which will use the default ruby standards  (create, index, new, edit, show, update, destroy)
admins-MacBook-Pro:jsblogger joelbyler$ rake routes
    articles GET    /articles(.:format)          {:action=>"index", :controller=>"articles"}
             POST   /articles(.:format)          {:action=>"create", :controller=>"articles"}
 new_article GET    /articles/new(.:format)      {:action=>"new", :controller=>"articles"}
edit_article GET    /articles/:id/edit(.:format) {:action=>"edit", :controller=>"articles"}
     article GET    /articles/:id(.:format)      {:action=>"show", :controller=>"articles"}
             PUT    /articles/:id(.:format)      {:action=>"update", :controller=>"articles"}
             DELETE /articles/:id(.:format)      {:action=>"destroy", :controller=>"articles"}
if request comes in with GET verb for the following path /articles/new  then use articles controller and new action
if you try the link below now you will get an unitialized constant ArticlesController error
http://localhost:3000/articles
we must create the controller (using the command below)  We already created a model  notice how articles is plural for the controller
admins-MacBook-Pro:jsblogger joelbyler$ rails generate controller articles
      create  app/controllers/articles_controller.rb
      invoke  erb
      create    app/views/articles
      invoke  test_unit
      create    test/functional/articles_controller_test.rb
      invoke  helper
      create    app/helpers/articles_helper.rb
      invoke    test_unit
      create      test/unit/helpers/articles_helper_test.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/articles.js.coffee
      invoke    scss
      create      app/assets/stylesheets/articles.css.scss

if you mispell something above, don't try and go thru and fix by hand.  Push up arrow so you can get the exact command from above but change 'generate' to 'destroy'
rails destroy controller articles (don't do this now unless you actually did make a mistake)
then you can regenerate with the correct name

Review app/controllers/articles_controller.rb and app/controllers/application_controller.rb
now try to refresh web page
now you get a new error 'The action 'index' could not be found for ArticlesController'
add simple index method as show below
	def index
	end
now you get 'Template is missing' error.  Need to create erb template file.  View template you CANNOT USE GENERATE FOR
look into app/views/articles/  there are no files here.  We'll need to create a file app/views/articles/index.html.erb  (erb matches output format, see previous error message)  check into .html.erb instead of .html or .erb

Add Articles.all to your index method and then you can see in server console output where the select statement occurs if you refresh page.
Started GET "/articles" for 127.0.0.1 at 2012-01-11 10:02:08 -0500
  Processing by ArticlesController#index as HTML
  Article Load (0.1ms)  SELECT "articles".* FROM "articles" 
Rendered articles/index.html.erb within layouts/application (0.0ms)
Completed 200 OK in 8ms (Views: 6.5ms | ActiveRecord: 0.4ms)

ERB -> Embedded Ruby

set articles variable in index action, kinda sucks how you have to use the @ sybmol at the beginning of variable.  Promotes to instance variable.
@articles = Article.all

NOTE: <%= 5 + 5 %> will print where <% 5 + 5 %> will not
dude?
