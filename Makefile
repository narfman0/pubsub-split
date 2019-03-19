default: test

clean: clean-build clean-pyc

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

init:
	pipenv install

init-dev:
	pipenv install -d

lock-requirements:
	pipenv lock -r > requirements.txt

run-test:
	pipenv run pytest --flake8 --black --cov=pubsub_split --cov-report term-missing tests/

release-test: clean
	pipenv run python setup.py sdist bdist_wheel
	pipenv run twine upload --repository pypitest dist/*

release-prod: clean
	pipenv run python setup.py sdist bdist_wheel
	pipenv run twine upload --repository pypi dist/*

test: init-dev run-test
t: run-test
