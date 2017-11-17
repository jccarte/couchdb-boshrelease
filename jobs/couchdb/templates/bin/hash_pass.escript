#!/usr/bin/env /var/vcap/packages/erlang/bin/escript
%%! -pa /var/vcap/packages/couchdb/lib/couch-2.1.1/ebin

-include("/var/vcap/packages/couchdb/lib/couch-2.1.1/include/couch_db.hrl").
main([Username, Password, SaltString]) ->
  try
    Pass = ?l2b(Password),
    Salt = ?l2b(SaltString),
    HashedPass = couch_passwords:pbkdf2(Pass, Salt, 10),
    io:format("~s = -pbkdf2-~s,~s,10\n", [Username, HashedPass, Salt])
  catch
    _:_ ->
      usage()
  end;
main(_) ->
    usage().
usage() ->
    io:format("usage: genpasswd.escript username password\n"),
    halt(1).