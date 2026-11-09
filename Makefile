-include .makefiles/Makefile
-include .makefiles/pkg/changelog/v2/Makefile

.makefiles/%:
	@curl -sfL https://makefiles.dev/v1 | bash /dev/stdin "$@"
