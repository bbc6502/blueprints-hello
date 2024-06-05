.PHONY: help clean requirements build run

help:
	@cat makefile

clean:
	rm -fr .venv dist build *.egg-info

.venv:
	python3.12 -m venv .venv

requirements: .venv
	.venv/bin/python -m pip install --upgrade pip
	.venv/bin/python -m pip install --upgrade -r requirements.txt

run: .venv
	.venv/bin/blueprints

build: .venv
	@rm -fr dist build dist
	@.venv/bin/python -m build

test: venv
	@.venv/bin/pytest --cov --cov-branch --cov-report term-missing

test-deploy: build
	@.venv/bin/python -m twine upload --repository testpypi dist/*

deploy: build
	@.venv/bin/python -m twine upload dist/*
