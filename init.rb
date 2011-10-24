$KCODE = "UTF8"

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/"))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/lib"))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/modes"))

require "state"
require "tetris"
require "backtrack"
require "play"
require "input"
require "pattern"
