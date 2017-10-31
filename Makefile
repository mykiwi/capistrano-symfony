FIG = docker-compose
RUBY = $(FIG) run --rm capistrano
STAGING_IP := $$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $$(docker-compose ps -q staging))

init: Gemfile Gemfile.lock
	$(RUBY) bundle exec cap install
.PHONY: init

deploy:
	$(FIG) up -d staging
	sed -i -r "s/STAGING_IP/$(STAGING_IP)/g" config/deploy/staging.rb
	$(RUBY) bundle exec cap staging deploy
.PHONY:deploy

Gemfile:
	$(RUBY) bundle init
	$(RUBY) bundle add capistrano-symfony --version="~> 1.0.0.rc1"

Gemfile.lock: Gemfile
	$(RUBY) bundle install

clean:
	rm -rf Gemfile Gemfile.lock
	rm -rf Capfile lib/ config/
.PHONY: clean
