.PHONY: test

test:
	@ruby -Ilib:test test/runner.rb "test/*_test.rb"

watch:
	@fswatch -0 -l0.1 ./lib/*.rb ./test/*.rb | xargs -0 -I {} make test

build:
	@rm -f *.gem && gem build feriados.gemspec

push: build
	@find . -name *.gem | xargs -n1 gem push
