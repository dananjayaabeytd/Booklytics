from setuptools import setup, find_packages

with open("requirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="MLOPS-Project-01",
    version="0.1",
    author="dananjayaabeytd",
    packages=find_packages(),
    install_requires=requirements,
)