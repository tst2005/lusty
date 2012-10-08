local lusty = ...
local namespace = 'store.mongo'
lusty.config(namespace)
local config = lusty.config[namespace]

local mongo = require "resty.mongol"
local conn = mongo:new()
local conn:set_timeout(config.timeout)
local ok, err = conn:connect(config.host, config.port)

if not ok then
  lusty.config.log(err ,"error")
end

local db = conn:get_db_handle(config.database)

if config.secure then
  ok, err = db:auth(config.username, config.password)
end

if not ok then
  lusty.config.log(err ,"error")
end

return db