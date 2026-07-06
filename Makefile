.PHONY: build install uninstall clean dev

PLUGIN_DIR := $(HOME)/.config/opendeck/plugins/com.example.opendeck.my-awesome-plugin.sdPlugin
# You can find it in Cargo.toml in the package section under name
CARGO_NAME := opendeck-plugin-template

build:
	. $$HOME/.cargo/env && cargo build --release

install: build
	mkdir -p $(PLUGIN_DIR)
	cp target/release/$(CARGO_NAME) $(PLUGIN_DIR)/plugin-opendeck-x86_64-unknown-linux-gnu.tmp
	mv $(PLUGIN_DIR)/plugin-opendeck-x86_64-unknown-linux-gnu.tmp $(PLUGIN_DIR)/plugin-opendeck-x86_64-unknown-linux-gnu
	cp -r assets/* $(PLUGIN_DIR)/

uninstall:
	rm -rf $(PLUGIN_DIR)

clean:
	cargo clean

dev:
	source $$HOME/.cargo/env && cargo build
	mkdir -p $(PLUGIN_DIR)
	cp target/debug/$(CARGO_NAME) $(PLUGIN_DIR)/plugin-opendeck-x86_64-unknown-linux-gnu.tmp
	mv $(PLUGIN_DIR)/plugin-opendeck-x86_64-unknown-linux-gnu.tmp $(PLUGIN_DIR)/plugin-opendeck-x86_64-unknown-linux-gnu
	cp -r assets/* $(PLUGIN_DIR)/
