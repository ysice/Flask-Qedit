.PHONY: release clean
help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

release: ## release flask-init to pypi
    docker build -t cclouds/finit:pypi .
    docker run -v ~/.pypirc:~/.pypirc --name finit_pypi cclouds/finit:pypi release

clean: ## clean flask-init image container
    docker stop finit_pypi
    docker rm finit_pypi
    docker rmi cclouds/finit:pypi