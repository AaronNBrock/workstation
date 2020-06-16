build:
	docker build -t dotfiles .

run:
	docker run --rm -it -v /:/mnt/host/ dotfiles

win-run: build
	MSYS_NO_PATHCONV=1 docker run --rm -it -v /c/:/mnt/host/c/ dotfiles