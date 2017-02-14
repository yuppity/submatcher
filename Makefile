clean:
	rm -rf test_dir

manualtest:
	@bash tests/manual.bash
	@cd test_dir; \
	bash ../submatcher.bash
