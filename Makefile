.PHONY: all
all: native

UNAME_OS := $(shell uname -s)

ifeq ($(UNAME_OS),Darwin)
GRAAL_BUILD_ARGS += -H:-CheckToolchain
endif

.PHONY: repl
repl:
	clj -M:dev:repl

.PHONY: update
update:
	clojure -Sdeps '{:deps {org.slf4j/slf4j-simple {:mvn/version "RELEASE"} com.github.liquidz/antq {:mvn/version "RELEASE"}}}' -M -m antq.core --upgrade --force

.PHONY: test
test:
	clojure -M:dev:test

.PHONY: uber
uber: target/terraform-manager-standalone.jar

target/terraform-manager-standalone.jar:
	clojure -T:build uber

.PHONY: native
native: target/terraform-manager

target/terraform-manager: target/terraform-manager-standalone.jar
	native-image -jar $< \
	--features=clj_easy.graal_build_time.InitClojureClasses \
	--verbose \
	--no-fallback \
	--install-exit-handlers \
	$(GRAAL_BUILD_ARGS) \
	$@

.PHONY: clean
clean:
	rm -rf target
