TESTS = $(wildcard tests/*_test.sh)
TDIR = test_dir

clean:
	rm -rf $(TDIR)

manualtest: clean
	@bash tests/manual.bash
	@cd $(TDIR)/processed; bash ../../submatcher.bash

showtree:
	find $(TDIR) -type f

tests:
	bash $(TESTS)

tt:
	bash $(TESTS)

.PHONY: tests
