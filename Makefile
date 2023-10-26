install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt

pdm-install:
	#install commands
	pip install --upgrade pip &&\
		pip install pdm &&\
		pdm install

post-install:
	python -m textblob.download_corpora

format:
	#format code
	black *.py mylib/*.py
lint:
	#flake8 or #pylint
	pylint --disable=R,C *.py mylib/*.py
test:
	#test
	python -m pytest -vv --cov=mylib --cov=main test_*.py
build:
	#build container
	docker build -t deploy-fastapi .
run:
	#run docker
	docker run -p 127.0.0.1:8080:8080 8b6c522cb4e8
deploy:
	#deploy
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 085141973272.dkr.ecr.us-east-1.amazonaws.com
	docker build -t wiki-fastapi .
	docker tag wiki-fastapi:latest 085141973272.dkr.ecr.us-east-1.amazonaws.com/wiki-fastapi:latest
	docker push 085141973272.dkr.ecr.us-east-1.amazonaws.com/wiki-fastapi:latest

all: install post-install lint test deploy