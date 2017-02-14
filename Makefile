clean:
	rm -rf test_dir

manualtest: clean
	@bash tests/manual.bash
	ls test_dir > test_dir/list-old
	@cd test_dir; bash ../submatcher.bash
	ls test_dir > test_dir/list-new
