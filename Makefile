APP_NAME=git-ask-pass
SRC=./main.go
BUILD_DIR=./build

GREEN = \e[32m
NC = \e[0m

.PHONY: all build-linux build-win run clean

all: build-linux build-win

build-linux: clean
	@echo -e "$(GREEN)Сборка $(APP_NAME) для linux...$(NC)"
	GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o $(BUILD_DIR)/$(APP_NAME)-linux ./

build-win: clean
	@echo -e "$(GREEN)Сборка $(APP_NAME) для windows...$(NC)"
	GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o $(BUILD_DIR)/$(APP_NAME).exe ./
	

run:
	@echo -e "$(GREEN)Запуск $(APP_NAME)...$(NC)"
	go run $(SRC)

clean:
	@echo -e "$(GREEN)Очистка...$(NC)"
	rm -f $(BUILD_DIR)/*

.DEFAULT_GOAL := build-linux