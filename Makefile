include Makefile.vars

.PHONY: vendor

vendor: $(GOPATH)/bin/godep
	@go get -u github.com/bgentry/que-go
	@sudo chown vagrant:vagrant /mnt/GoWork/src/github.com/homemade
	@go get -u github.com/homemade/justin
	@go get -u github.com/jackc/pgx
	@go get -u github.com/Sirupsen/logrus
	@go get -u golang.org/x/sys/unix
	@godep save ./...

$(GOPATH)/bin/godep:
	@go get github.com/tools/godep

test-heartbeat:
	@export DATABASE_URL=$(DATABASE_URL) && export HEARTBEAT=$(HEARTBEAT) && go run cmd/clock/main.go

test-workers:
	@export DATABASE_URL=$(DATABASE_URL) && export JUSTIN_APIKEY=$(JUSTIN_APIKEY) && export JUSTIN_RESULTS_BATCH=$(JUSTIN_RESULTS_BATCH) && go run cmd/worker/main.go
