all:	 
	rm -rf erl_cra* rebar3_crashreport;
	rm -rf *~ */*~;
	rm -rf test_ebin;
	rm -rf *.beam */*.beam;
	rm -rf test.rebar;
	rm -rf logs;
	rm -rf Mnesia.*;
	rm -rf _build;
	rm -rf ebin;
	rm -rf rebar.lock;
	#INFO: Compile application
	rm -rf common_include;
	cp -r ~/erlang/common_include .
	rebar3 release;
	rebar3 as prod tar;
	rm -rf tar_dir;
	mkdir tar_dir;
	cp _build/prod/rel/add_test/*.tar.gz tar_dir/add_test.tar.gz;
	rm -rf _build;
	git status
	echo Ok there you go!
	#INFO: no_ebin_commit ENDED SUCCESSFUL
clean:
	rm -rf erl_cra* rebar3_crashreport;
	rm -rf *~ */*~;
	rm -rf test_ebin;
	rm -rf *.beam */*.beam;
	rm -rf test.rebar;
	rm -rf logs;
	rm -rf Mnesia.*;
	rm -rf _build;
	rm -rf ebin;
	rm -rf rebar.lock;
	#INFO: Compile application
	rm -rf common_include;
	cp -r ~/erlang/common_include .
	cp config/rebar.config .;
	rebar3 compile;
	rm -rf _build;
	rm -rf rebar.lock
#INFO: clean ENDED SUCCESSFUL
eunit: 
	rm -rf erl_cra* rebar3_crashreport;
	rm -rf *~ */*~;
	rm -rf test_ebin;
	rm -rf *.beam */*.beam;
	rm -rf test.rebar;
	rm -rf logs;
	rm -rf Mnesia.*;
	rm -rf _build;
	rm -rf ebin;
	rm -rf rebar.lock;
#INFO: Creating eunit test code using test_ebin dir;
	rm -rf common_include;
	cp -r ~/erlang/common_include .
	mkdir test_ebin;
	cp test_config/test.rebar.config rebar.config;
	erlc -o test_ebin test/*.erl;
	cp test/*.app test_ebin;
	rebar3 release;
	rebar3 as prod tar;
	rm -rf tar_dir;
	mkdir tar_dir;
	cp _build/prod/rel/add_test/*.tar.gz tar_dir/add_test.tar.gz;
	#INFO: Starts the eunit testing .................
	erl -pa test_ebin\
	 -pa _build/default/lib/log/ebin\
	 -pa _build/default/lib/rd/ebin\
	 -pa _build/default/lib/add_test/ebin\
	 -sname test_appl\
	 -run $(m) start\
	 -setcookie a
