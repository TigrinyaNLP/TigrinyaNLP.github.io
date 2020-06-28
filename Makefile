.PHONY: up down status logs

_COMPOSE=docker-compose


up:
	$(call compose, up -d)

down:
	$(call compose, down)

status:
	$(call compose, ps)

logs:
	$(call compose, logs)

login:
	$(call exec, bash)

bundle:
	$(call exec, jekyll bundle)

build:
	$(call exec, jekyll build)

define compose
	$(_COMPOSE) $(1)
endef

define exec
	$(call compose, exec jekyll $(1))
endef