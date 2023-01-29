install:
	# installing commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt
format:
	black *.py mylib/*.py
lint:
	#pylint or flake8
	pylint --disable=R,C *.py mylib/*.py

test:
	#testing
	#python3 -m pytest -vv --cov=mylib test_logic.py
build:
	#build the docker image
	docker build -t deploy-fastapi .
run:
	#running the docker contianer from docker image
	docker run -p 127.0.0.1:8080:8080 1f53da591918
deploy:
	docker login --username AWS --password-stdin 492094906798.dkr.ecr.us-east-1.amazonaws.com
	docker build -t fastapi-wiki .
	docker tag fastapi-wiki:latest 492094906798.dkr.ecr.us-east-1.amazonaws.com/fastapi-wiki:latest
	docker push 492094906798.dkr.ecr.us-east-1.amazonaws.com/fastapi-wiki:latest

all: install format lint